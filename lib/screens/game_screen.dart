import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/app_theme.dart';
import '../models/game_models.dart';
import '../providers/game_provider.dart';
import '../providers/theme_provider.dart';
import '../services/haptics.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  final GlobalKey _gridKey = GlobalKey();

  void _onPointerDown(
    PointerDownEvent event,
    GameState gameState,
    GameNotifier notifier,
  ) {
    final coord = _coordinateFromOffset(
      event.localPosition,
      gameState.gridSize,
    );
    if (coord != null) {
      notifier.startSelection(coord);
    }
  }

  void _onPointerMove(
    PointerMoveEvent event,
    GameState gameState,
    GameNotifier notifier,
  ) {
    final coord = _coordinateFromOffset(
      event.localPosition,
      gameState.gridSize,
    );
    if (coord != null) {
      notifier.updateSelection(coord);
    }
  }

  void _onPointerUp(PointerUpEvent event, GameNotifier notifier) {
    notifier.commitSelection();
  }

  GridCoordinate? _coordinateFromOffset(Offset localPos, int gridSize) {
    final renderBox = _gridKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    final size = renderBox.size;
    final cellWidth = size.width / gridSize;
    final cellHeight = size.height / gridSize;

    final col = (localPos.dx / cellWidth).floor();
    final row = (localPos.dy / cellHeight).floor();

    if (row >= 0 && row < gridSize && col >= 0 && col < gridSize) {
      return GridCoordinate(row, col);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);
    final notifier = ref.read(gameProvider.notifier);
    final appTheme = ref.watch(themeProvider);
    final hardMode = ref.watch(hardModeProvider);
    return Scaffold(
      backgroundColor: appTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: appTheme.appBarFg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: appTheme.appBarFg,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: gameState.isRandom
                ? (gameState.difficulty?.color.withValues(alpha: 0.15) ??
                      appTheme.surfaceVariant)
                : appTheme.surfaceVariant,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            gameState.isRandom
                ? 'RANDOM • ${gameState.difficulty?.label.toUpperCase() ?? "PUZZLE"}'
                : 'LEVEL ${gameState.level}',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 1.0,
              color: gameState.isRandom
                  ? (gameState.difficulty?.darkColor ?? appTheme.textPrimary)
                  : appTheme.textPrimary,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.replay_rounded,
              color: appTheme.textMuted,
              size: 24,
            ),
            onPressed: () {
              Haptics.select();
              notifier.restartCurrentLevel();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildGridArea(gameState, notifier, appTheme),
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (gameState.status == GameStatus.won)
              _buildCompletionSection(context, gameState, notifier, appTheme)
            else if (!hardMode)
              _buildWordChips(gameState, appTheme),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildWordChips(GameState state, AppThemeData appTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: state.words.map((placement) {
          final isFound = placement.isFound;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isFound ? placement.color : appTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isFound
                    ? placement.color
                    : appTheme.border.withValues(alpha: 0.4),
                width: 1.5,
              ),
              boxShadow: isFound
                  ? [
                      BoxShadow(
                        color: placement.color.withValues(alpha: 0.35),
                        offset: const Offset(0, 3),
                        blurRadius: 4,
                      ),
                    ]
                  : null,
            ),
            child: Text(
              placement.word,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                decoration: isFound
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationThickness: 2.0,
                decorationColor: Colors.white,
                color: isFound ? Colors.white : appTheme.textPrimary,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGridArea(
    GameState gameState,
    GameNotifier notifier,
    AppThemeData appTheme,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxSide = min(constraints.maxWidth, constraints.maxHeight);

        return Container(
          width: maxSide,
          height: maxSide,
          decoration: BoxDecoration(
            color: appTheme.cardBg,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: appTheme.border.withValues(alpha: 0.5),
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                offset: const Offset(0, 6),
                blurRadius: 12,
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Listener(
            key: _gridKey,
            behavior: HitTestBehavior.opaque,
            onPointerDown: (e) => _onPointerDown(e, gameState, notifier),
            onPointerMove: (e) => _onPointerMove(e, gameState, notifier),
            onPointerUp: (e) => _onPointerUp(e, notifier),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: WordPillPainter(
                      gridSize: gameState.gridSize,
                      foundWords: gameState.words
                          .where((w) => w.isFound)
                          .toList(),
                      currentSelection: gameState.currentSelection,
                      selectionColor: appTheme.playBg,
                    ),
                  ),
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gameState.gridSize,
                    crossAxisSpacing: gameState.gridSize >= 10 ? 2 : 4,
                    mainAxisSpacing: gameState.gridSize >= 10 ? 2 : 4,
                  ),
                  itemCount: gameState.gridSize * gameState.gridSize,
                  itemBuilder: (context, index) {
                    final r = index ~/ gameState.gridSize;
                    final c = index % gameState.gridSize;
                    final letter = gameState.grid[r][c];

                    return Center(
                      child: Text(
                        letter,
                        style: TextStyle(
                          fontSize: _fontSizeForGrid(gameState.gridSize),
                          fontWeight: FontWeight.w900,
                          color: appTheme.textPrimary,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _fontSizeForGrid(int size) {
    if (size <= 5) return 26;
    if (size <= 6) return 24;
    if (size <= 7) return 22;
    if (size <= 8) return 20;
    if (size <= 9) return 18;
    if (size <= 10) return 16;
    if (size <= 11) return 14;
    return 13;
  }

  Widget _buildCompletionSection(
    BuildContext context,
    GameState gameState,
    GameNotifier notifier,
    AppThemeData appTheme,
  ) {
    final nextText = gameState.isRandom ? 'NEW PUZZLE' : 'NEXT LEVEL';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.emoji_events_rounded,
                  color: appTheme.playBg,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'CONGRATULATIONS!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: appTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Haptics.select();
              notifier.nextLevel();
            },
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: appTheme.playBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: appTheme.playBorder, width: 2.0),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.playShadow,
                    offset: const Offset(0, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    nextText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Haptics.select();
              Navigator.of(context).pop();
            },
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: appTheme.surfaceVariant,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: appTheme.border.withValues(alpha: 0.6),
                  width: 2.0,
                ),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_rounded,
                        color: appTheme.textPrimary,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'HOME',
                        style: TextStyle(
                          color: appTheme.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Haptics.select();
              launchUrl(
                Uri.parse('https://ko-fi.com/sidhant947'),
                mode: LaunchMode.externalApplication,
              );
            },
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFFDD00),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE5C700), width: 2.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFC4AA00),
                    offset: Offset(0, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: const Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.coffee_rounded,
                        color: Color(0xFF000000),
                        size: 20,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'BUY ME A COFFEE',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WordPillPainter extends CustomPainter {
  final int gridSize;
  final List<WordPlacement> foundWords;
  final List<GridCoordinate> currentSelection;
  final Color selectionColor;

  WordPillPainter({
    required this.gridSize,
    required this.foundWords,
    required this.currentSelection,
    required this.selectionColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (gridSize <= 0) return;

    final cellWidth = size.width / gridSize;
    final cellHeight = size.height / gridSize;
    final strokeWidth = min(cellWidth, cellHeight) * 0.78;

    for (final placement in foundWords) {
      if (placement.coordinates.isEmpty) continue;
      _drawCapsule(
        canvas,
        placement.coordinates.first,
        placement.coordinates.last,
        cellWidth,
        cellHeight,
        placement.color.withValues(alpha: 0.35),
        strokeWidth,
      );
    }

    if (currentSelection.isNotEmpty) {
      _drawCapsule(
        canvas,
        currentSelection.first,
        currentSelection.last,
        cellWidth,
        cellHeight,
        selectionColor.withValues(alpha: 0.38),
        strokeWidth,
      );
    }
  }

  void _drawCapsule(
    Canvas canvas,
    GridCoordinate start,
    GridCoordinate end,
    double cellWidth,
    double cellHeight,
    Color color,
    double strokeWidth,
  ) {
    final startCenter = Offset(
      (start.col + 0.5) * cellWidth,
      (start.row + 0.5) * cellHeight,
    );
    final endCenter = Offset(
      (end.col + 0.5) * cellWidth,
      (end.row + 0.5) * cellHeight,
    );

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawLine(startCenter, endCenter, paint);
  }

  @override
  bool shouldRepaint(covariant WordPillPainter oldDelegate) {
    return oldDelegate.gridSize != gridSize ||
        oldDelegate.foundWords != foundWords ||
        oldDelegate.currentSelection != currentSelection ||
        oldDelegate.selectionColor != selectionColor;
  }
}
