import 'package:flutter/material.dart';

enum PuzzleDifficulty {
  easy(
    label: 'Easy',
    gridSize: 6,
    wordCount: 3,
    color: Color(0xFF10B981),
    darkColor: Color(0xFF047857),
  ),
  medium(
    label: 'Medium',
    gridSize: 8,
    wordCount: 5,
    color: Color(0xFF3897F0),
    darkColor: Color(0xFF1E6BB8),
  ),
  hard(
    label: 'Hard',
    gridSize: 10,
    wordCount: 6,
    color: Color(0xFFFFA502),
    darkColor: Color(0xFFCC8400),
  ),
  expert(
    label: 'Expert',
    gridSize: 11,
    wordCount: 7,
    color: Color(0xFFFF4757),
    darkColor: Color(0xFFC0392B),
  ),
  master(
    label: 'Master',
    gridSize: 12,
    wordCount: 8,
    color: Color(0xFF8E44AD),
    darkColor: Color(0xFF6C3483),
  );

  final String label;
  final int gridSize;
  final int wordCount;
  final Color color;
  final Color darkColor;

  const PuzzleDifficulty({
    required this.label,
    required this.gridSize,
    required this.wordCount,
    required this.color,
    required this.darkColor,
  });
}

class GridCoordinate {
  final int row;
  final int col;

  const GridCoordinate(this.row, this.col);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GridCoordinate &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          col == other.col;

  @override
  int get hashCode => row.hashCode ^ col.hashCode;

  @override
  String toString() => '($row, $col)';
}

class WordPlacement {
  final String word;
  final List<GridCoordinate> coordinates;
  final Color color;
  bool isFound;

  WordPlacement({
    required this.word,
    required this.coordinates,
    required this.color,
    this.isFound = false,
  });

  WordPlacement clone() {
    return WordPlacement(
      word: word,
      coordinates: List.from(coordinates),
      color: color,
      isFound: isFound,
    );
  }
}

enum GameStatus {
  playing,
  won,
}

class WordColors {
  static const List<Color> palette = [
    Color(0xFFFF4757),
    Color(0xFF00CEC9),
    Color(0xFFFFA502),
    Color(0xFF9B59B6),
    Color(0xFF2ECC71),
    Color(0xFF0984E3),
    Color(0xFFE84393),
    Color(0xFFFF6B35),
    Color(0xFF1ABC9C),
    Color(0xFFE67E22),
  ];
}

class GameState {
  final int level;
  final bool isRandom;
  final PuzzleDifficulty? difficulty;
  final int? seed;
  final int gridSize;
  final List<List<String>> grid;
  final List<WordPlacement> words;
  final List<GridCoordinate> currentSelection;
  final GameStatus status;

  const GameState({
    required this.level,
    this.isRandom = false,
    this.difficulty,
    this.seed,
    required this.gridSize,
    required this.grid,
    required this.words,
    this.currentSelection = const [],
    this.status = GameStatus.playing,
  });

  GameState copyWith({
    int? level,
    bool? isRandom,
    PuzzleDifficulty? difficulty,
    int? seed,
    int? gridSize,
    List<List<String>>? grid,
    List<WordPlacement>? words,
    List<GridCoordinate>? currentSelection,
    GameStatus? status,
  }) {
    return GameState(
      level: level ?? this.level,
      isRandom: isRandom ?? this.isRandom,
      difficulty: difficulty ?? this.difficulty,
      seed: seed ?? this.seed,
      gridSize: gridSize ?? this.gridSize,
      grid: grid ?? this.grid,
      words: words ?? this.words,
      currentSelection: currentSelection ?? this.currentSelection,
      status: status ?? this.status,
    );
  }
}
