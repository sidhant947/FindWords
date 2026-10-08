import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_models.dart';
import '../services/haptics.dart';
import '../services/level_generator.dart';
import '../services/storage_service.dart';

final highestLevelProvider = StateProvider<int>((ref) {
  return StorageService.getHighestLevel();
});

final hardModeProvider = StateProvider<bool>((ref) {
  return StorageService.getHardMode();
});

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  final startLevel = ref.read(highestLevelProvider);
  return GameNotifier(startLevel, ref);
});

class GameNotifier extends StateNotifier<GameState> {
  final Ref _ref;

  GameNotifier(int initialLevel, this._ref)
      : super(LevelGenerator.generateLevel(initialLevel));

  void startLevel(int level) {
    state = LevelGenerator.generateLevel(level);
  }

  void startRandomPuzzle(PuzzleDifficulty difficulty, {int? seed}) {
    state = LevelGenerator.generateDifficultyLevel(difficulty, seed: seed);
  }

  void restartCurrentLevel() {
    if (state.isRandom && state.difficulty != null) {
      state = LevelGenerator.generateDifficultyLevel(
        state.difficulty!,
        seed: state.seed,
      );
      return;
    }
    state = LevelGenerator.generateLevel(state.level);
  }

  void nextLevel() {
    if (state.isRandom && state.difficulty != null) {
      startRandomPuzzle(state.difficulty!);
      return;
    }
    final nextLvl = min(100, state.level + 1);
    StorageService.setHighestLevel(nextLvl);
    if (nextLvl > _ref.read(highestLevelProvider)) {
      _ref.read(highestLevelProvider.notifier).state = nextLvl;
    }
    startLevel(nextLvl);
  }

  void startSelection(GridCoordinate coord) {
    if (state.status != GameStatus.playing) return;
    state = state.copyWith(currentSelection: [coord]);
    Haptics.light();
  }

  void updateSelection(GridCoordinate coord) {
    if (state.status != GameStatus.playing) return;
    if (state.currentSelection.isEmpty) {
      startSelection(coord);
      return;
    }

    final start = state.currentSelection.first;
    if (coord == state.currentSelection.last) return;

    final dr = coord.row - start.row;
    final dc = coord.col - start.col;

    final isHorizontal = dr == 0 && dc != 0;
    final isVertical = dc == 0 && dr != 0;
    final isDiagonal = dr.abs() == dc.abs() && dr != 0;

    if (isHorizontal || isVertical || isDiagonal) {
      final stepR = dr == 0 ? 0 : dr ~/ dr.abs();
      final stepC = dc == 0 ? 0 : dc ~/ dc.abs();
      final steps = max(dr.abs(), dc.abs());

      final newSelection = <GridCoordinate>[];
      for (int i = 0; i <= steps; i++) {
        newSelection.add(
          GridCoordinate(start.row + stepR * i, start.col + stepC * i),
        );
      }

      if (newSelection.length != state.currentSelection.length) {
        Haptics.light();
      }
      state = state.copyWith(currentSelection: newSelection);
    }
  }

  void commitSelection() {
    if (state.status != GameStatus.playing) return;
    if (state.currentSelection.isEmpty) return;

    final letters = state.currentSelection
        .map((c) => state.grid[c.row][c.col])
        .join();
    final reversed = letters.split('').reversed.join();

    WordPlacement? matchedWord;
    for (final w in state.words) {
      if (!w.isFound && (w.word == letters || w.word == reversed)) {
        matchedWord = w;
        break;
      }
    }

    if (matchedWord != null) {
      Haptics.heavy();

      final updatedWords = state.words.map((w) {
        if (w.word == matchedWord!.word) {
          return w.clone()..isFound = true;
        }
        return w;
      }).toList();

      final allFound = updatedWords.every((w) => w.isFound);

      state = state.copyWith(
        words: updatedWords,
        currentSelection: const [],
        status: allFound ? GameStatus.won : GameStatus.playing,
      );

      if (allFound && !state.isRandom) {
        final nextLvl = min(100, state.level + 1);
        StorageService.setHighestLevel(nextLvl);
        if (nextLvl > _ref.read(highestLevelProvider)) {
          _ref.read(highestLevelProvider.notifier).state = nextLvl;
        }
      }
    } else {
      state = state.copyWith(currentSelection: const []);
    }
  }
}
