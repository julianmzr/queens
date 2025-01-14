import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';

class Board {
  final List<List<Color>> colorRegions;
  final List<List<int>> solution;

  Board(this.colorRegions, this.solution);
}

class BoardStorage {
  static final List<List<int>> _solutions = [
    [0, 4, 7, 5, 2, 6, 1, 3],
    [0, 5, 7, 2, 6, 3, 1, 4],
    [0, 6, 3, 5, 7, 1, 4, 2],
    [0, 6, 4, 7, 1, 3, 5, 2],
    [1, 3, 5, 7, 2, 0, 6, 4],
    [1, 4, 6, 0, 2, 7, 5, 3],
    [1, 4, 6, 3, 0, 7, 5, 2],
    [1, 5, 0, 6, 3, 7, 2, 4],
    [1, 5, 7, 2, 0, 3, 6, 4],
    [1, 6, 2, 5, 7, 4, 0, 3],
    [1, 6, 4, 7, 0, 3, 5, 2],
    [1, 7, 5, 0, 2, 4, 6, 3],
    [2, 0, 6, 4, 7, 1, 3, 5],
    [2, 4, 1, 7, 0, 6, 3, 5],
    [2, 4, 1, 7, 5, 3, 6, 0],
    [2, 4, 6, 0, 3, 1, 7, 5],
    [2, 4, 7, 3, 0, 6, 1, 5],
    [2, 5, 1, 4, 7, 0, 6, 3],
    [2, 5, 1, 6, 0, 3, 7, 4],
    [2, 5, 1, 6, 4, 0, 7, 3],
    [2, 5, 3, 0, 7, 4, 6, 1],
    [2, 5, 3, 1, 7, 4, 6, 0],
    [2, 5, 7, 0, 3, 6, 4, 1],
    [2, 5, 7, 0, 4, 6, 1, 3],
    [2, 5, 7, 1, 3, 0, 6, 4],
    [2, 6, 1, 7, 4, 0, 3, 5],
    [2, 6, 1, 7, 5, 3, 0, 4],
    [2, 7, 3, 6, 0, 5, 1, 4],
    [3, 0, 4, 7, 1, 6, 2, 5],
    [3, 0, 4, 7, 5, 2, 6, 1],
    [3, 1, 4, 7, 5, 0, 2, 6],
    [3, 1, 6, 2, 5, 7, 0, 4],
    [3, 1, 6, 2, 5, 7, 4, 0],
    [3, 1, 6, 4, 0, 7, 5, 2],
    [3, 1, 7, 4, 6, 0, 2, 5],
    [3, 1, 7, 5, 0, 2, 4, 6],
    [3, 5, 0, 4, 1, 7, 2, 6],
    [3, 5, 7, 1, 6, 0, 2, 4],
    [3, 5, 7, 2, 0, 6, 4, 1],
    [3, 6, 0, 7, 4, 1, 5, 2],
    [3, 6, 2, 7, 1, 4, 0, 5],
    [3, 6, 4, 1, 5, 0, 2, 7],
    [3, 6, 4, 2, 0, 5, 7, 1],
    [3, 7, 0, 2, 5, 1, 6, 4],
    [3, 7, 0, 4, 6, 1, 5, 2],
    [3, 7, 4, 2, 0, 6, 1, 5],
    [4, 0, 3, 5, 7, 1, 6, 2],
    [4, 0, 7, 3, 1, 6, 2, 5],
    [4, 0, 7, 5, 2, 6, 1, 3],
    [4, 1, 3, 5, 7, 2, 0, 6],
    [4, 1, 3, 6, 2, 7, 5, 0],
    [4, 1, 5, 0, 6, 3, 7, 2],
    [4, 1, 7, 0, 3, 6, 2, 5],
    [4, 2, 0, 5, 7, 1, 3, 6],
    [4, 2, 0, 6, 1, 7, 5, 3],
    [4, 2, 7, 3, 6, 0, 5, 1],
    [4, 6, 0, 2, 7, 5, 3, 1],
    [4, 6, 0, 3, 1, 7, 5, 2],
    [4, 6, 1, 3, 7, 0, 2, 5],
    [4, 6, 1, 5, 2, 0, 3, 7],
    [4, 6, 1, 5, 2, 0, 7, 3],
    [4, 6, 3, 0, 2, 7, 5, 1],
    [4, 7, 3, 0, 2, 5, 1, 6],
    [4, 7, 3, 0, 6, 1, 5, 2],
    [5, 0, 4, 1, 7, 2, 6, 3],
    [5, 1, 6, 0, 2, 4, 7, 3],
    [5, 1, 6, 0, 3, 7, 4, 2],
    [5, 2, 0, 6, 4, 7, 1, 3],
    [5, 2, 0, 7, 3, 1, 6, 4],
    [5, 2, 0, 7, 4, 1, 3, 6],
    [5, 2, 4, 6, 0, 3, 1, 7],
    [5, 2, 4, 7, 0, 3, 1, 6],
    [5, 2, 6, 1, 3, 7, 0, 4],
    [5, 2, 6, 1, 7, 4, 0, 3],
    [5, 2, 6, 3, 0, 7, 1, 4],
    [5, 3, 0, 4, 7, 1, 6, 2],
    [5, 3, 1, 7, 4, 6, 0, 2],
    [5, 3, 6, 0, 2, 4, 1, 7],
    [5, 3, 6, 0, 7, 1, 4, 2],
    [5, 7, 1, 3, 0, 6, 4, 2],
    [6, 0, 2, 7, 5, 3, 1, 4],
    [6, 1, 3, 0, 7, 4, 2, 5],
    [6, 1, 5, 2, 0, 3, 7, 4],
    [6, 2, 0, 5, 7, 4, 1, 3],
    [6, 2, 7, 1, 4, 0, 5, 3],
    [6, 3, 1, 4, 7, 0, 2, 5],
    [6, 3, 1, 7, 5, 0, 2, 4],
    [6, 4, 2, 0, 5, 7, 1, 3],
    [7, 1, 3, 0, 6, 4, 2, 5],
    [7, 1, 4, 2, 0, 6, 3, 5],
    [7, 2, 0, 5, 1, 4, 6, 3],
    [7, 3, 0, 2, 5, 1, 6, 4],
  ];

  static final List<Color> _colors = [
    Colors.red[500]!,
    Colors.blue[500]!,
    Colors.green[500]!,
    Colors.purple[500]!,
    Colors.orange[500]!,
    Colors.amber[500]!,
    Colors.pink[500]!,
    Colors.teal[500]!,
  ];

  static Board getRandomBoard() {
    final solution = _solutions[Random().nextInt(_solutions.length)];
    final List<List<int>> queenPositions = [];
    for (int row = 0; row < 8; row++) {
      queenPositions.add([row, solution[row]]);
    }
    return Board(_generateValidColorRegions(queenPositions), queenPositions);
  }

  static List<List<Color>> _generateValidColorRegions(List<List<int>> queens) {
    List<List<Color>> regions = List.generate(
      8,
      (i) => List.generate(8, (j) => Colors.transparent),
    );

    // Shuffle colors for random assignment
    List<Color> availableColors = List.from(_colors)..shuffle();

    // First, place each queen in its own region
    for (int i = 0; i < queens.length; i++) {
      var queen = queens[i];
      regions[queen[0]][queen[1]] = availableColors[i];
    }

    // Assign random growth rates to each color (between 0.2 and 0.9)
    // Higher variance in growth rates will lead to more size variation
    Map<Color, double> growthRates = {};
    Random random = Random();
    for (var color in availableColors) {
      // 10% chance for a color to be "dominant" (larger region)
      if (random.nextDouble() < 0.1) {
        growthRates[color] = 0.7 + random.nextDouble() * 0.2; // 0.7-0.9
      } else {
        growthRates[color] = 0.2 + random.nextDouble() * 0.5; // 0.2-0.7
      }
    }

    // Then grow each region one cell at a time, taking turns
    bool changed;
    int maxIterations = 100; // Prevent infinite loops
    int iterations = 0;
    
    do {
      changed = false;
      iterations++;
      
      // Shuffle the order each time to avoid bias
      List<Color> currentColors = List.from(availableColors)..shuffle();
      
      // Calculate current sizes
      Map<Color, int> regionSizes = {};
      for (int row = 0; row < 8; row++) {
        for (int col = 0; col < 8; col++) {
          Color cellColor = regions[row][col];
          if (cellColor != Colors.transparent) {
            regionSizes[cellColor] = (regionSizes[cellColor] ?? 0) + 1;
          }
        }
      }
      
      for (var color in currentColors) {
        // Skip if region is already large
        if ((regionSizes[color] ?? 0) > 20) continue;
        
        // Try to grow this region, with its specific growth rate
        if (random.nextDouble() < growthRates[color]!) {
          if (_growRegionOneStep(regions, color)) {
            changed = true;
          }
        }
      }
    } while (changed && iterations < maxIterations && _hasTransparentCells(regions));

    // Fill any remaining cells with adjacent colors
    while (_hasTransparentCells(regions)) {
      for (int row = 0; row < 8; row++) {
        for (int col = 0; col < 8; col++) {
          if (regions[row][col] == Colors.transparent) {
            Color? adjacentColor = _findAdjacentColor(regions, row, col);
            if (adjacentColor != null) {
              regions[row][col] = adjacentColor;
            }
          }
        }
      }
    }

    return regions;
  }

  static bool _growRegionOneStep(List<List<Color>> regions, Color color) {
    // Find all transparent cells adjacent to this color
    List<List<int>> candidates = [];
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        if (regions[row][col] == color) {
          // Check all adjacent cells
          List<List<int>> directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
          for (var dir in directions) {
            int newRow = row + dir[0];
            int newCol = col + dir[1];
            if (newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8 && 
                regions[newRow][newCol] == Colors.transparent) {
              candidates.add([newRow, newCol]);
            }
          }
        }
      }
    }

    // If we found any candidates, pick one randomly and color it
    if (candidates.isNotEmpty) {
      var cell = candidates[Random().nextInt(candidates.length)];
      regions[cell[0]][cell[1]] = color;
      return true;
    }
    return false;
  }

  static bool _hasTransparentCells(List<List<Color>> regions) {
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        if (regions[row][col] == Colors.transparent) {
          return true;
        }
      }
    }
    return false;
  }

  static Color? _findAdjacentColor(List<List<Color>> regions, int row, int col) {
    List<List<int>> directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    List<Color> adjacentColors = [];

    for (var dir in directions) {
      int newRow = row + dir[0];
      int newCol = col + dir[1];
      if (newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8 && 
          regions[newRow][newCol] != Colors.transparent) {
        adjacentColors.add(regions[newRow][newCol]);
      }
    }

    // Return a random adjacent color if any exist
    return adjacentColors.isEmpty ? null : adjacentColors[Random().nextInt(adjacentColors.length)];
  }
}

enum GameRule {
  onePerRow('One queen per row'),
  onePerColumn('One queen per column'),
  onePerDiagonal('One queen per diagonal'),
  onePerRegion('One queen per color region');

  final String description;
  const GameRule(this.description);
}

void main() {
  runApp(const QueensGameApp());
}

class QueensGameApp extends StatelessWidget {
  const QueensGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 4 * 3.14159,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuart,
    ));

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 60,
      ),
    ]).animate(_controller);

    _controller.forward().then((_) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const QueensGameScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: SvgPicture.string(
                  '''<svg width="64" height="64" viewBox="0 0 24 24" fill="black">
                    <path d="M12 2L8 7L3 4L4 10L2 16H22L20 10L21 4L16 7L12 2ZM12 4.5L14.5 7.8L12 10L9.5 7.8L12 4.5ZM6.9 14L8 10.2L10.5 12.5L12 10L13.5 12.5L16 10.2L17.1 14H6.9Z"/>
                  </svg>''',
                  width: 64,
                  height: 64,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class QueensGameScreen extends StatefulWidget {
  const QueensGameScreen({super.key});

  @override
  State<QueensGameScreen> createState() => _QueensGameScreenState();
}

enum CellState {
  empty,
  blocked,
  queen,
}

// First, add this class to represent user actions
class GameAction {
  final Map<String, CellState> previousStates;
  final Map<String, CellState> newStates;

  GameAction(this.previousStates, this.newStates);
}

class _QueensGameScreenState extends State<QueensGameScreen> with SingleTickerProviderStateMixin {
  final int gridSize = 8;
  final Map<String, CellState> cellStates = {};
  bool _showSolution = false;
  bool _hasWon = false;
  List<List<int>>? _solution;
  late List<List<Color>> colorRegions;
  String? _errorMessage;
  Set<String> _errorCells = {};
  Timer? _errorTimer;
  Set<GameRule> _violatedRules = {};
  Timer? _gameTimer;
  Duration _elapsedTime = Duration.zero;
  bool _showTimer = true;
  bool _isTimerRunning = false;
  CellState? _currentDragOperation;
  final List<GameAction> _actionHistory = [];
  Map<String, CellState> _currentDragChanges = {};
  Map<String, CellState> _dragInitialStates = {};
  bool _isDarkMode = false;
  late AnimationController _themeController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _themeController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 180,
    ).animate(CurvedAnimation(
      parent: _themeController,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.5)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.5, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_themeController);

    final board = BoardStorage.getRandomBoard();
    colorRegions = board.colorRegions;
    _solution = board.solution;
    _toggleTimer();
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      if (_isDarkMode) {
        _themeController.forward();
      } else {
        _themeController.reverse();
      }
    });
  }

  Color get backgroundColor => _isDarkMode ? Colors.grey[900]! : Colors.grey[50]!;
  Color get surfaceColor => _isDarkMode ? Colors.grey[850]! : Colors.white;
  Color get borderColor => _isDarkMode ? Colors.white.withAlpha(192) : Colors.black.withAlpha(192);
  Color get iconColor => _isDarkMode ? Colors.white : Colors.black87;
  Color get textColor => _isDarkMode ? Colors.white : Colors.black87;
  Color get timerBackgroundColor => _isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;

  @override
  void dispose() {
    _themeController.dispose();
    _gameTimer?.cancel();
    _errorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        elevation: 0,
        title: _showTimer ? Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: timerBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _formatDuration(_elapsedTime),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ) : null,
        actions: [
          AnimatedBuilder(
            animation: _themeController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value * 3.14159 / 180,
                  child: IconButton(
                    icon: Icon(
                      _isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      color: iconColor,
                    ),
                    onPressed: _toggleTheme,
                    tooltip: _isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
                  ),
                ),
              );
            },
          ),
          Tooltip(
            message: 'Undo last move',
            child: IconButton(
              icon: Icon(Icons.undo_rounded, color: iconColor),
              onPressed: _actionHistory.isEmpty ? null : _undo,
            ),
          ),
          Tooltip(
            message: 'Clear all pieces',
            child: IconButton(
              icon: Icon(Icons.delete_outline_rounded, color: iconColor),
              onPressed: cellStates.isEmpty ? null : _clearBoard,
            ),
          ),
          Tooltip(
            message: _isTimerRunning ? 'Pause timer' : 'Start timer',
            child: IconButton(
              icon: Icon(
                _isTimerRunning ? Icons.pause_circle_outline_rounded : Icons.play_circle_outline_rounded,
                color: iconColor,
              ),
              onPressed: _toggleTimer,
            ),
          ),
          Tooltip(
            message: _showTimer ? 'Hide timer' : 'Show timer',
            child: IconButton(
              icon: Icon(
                _showTimer ? Icons.timer_off_rounded : Icons.timer_rounded,
                color: iconColor,
              ),
              onPressed: () => setState(() => _showTimer = !_showTimer),
            ),
          ),
          Tooltip(
            message: _showSolution ? 'Hide solution' : 'Show solution',
            child: IconButton(
              icon: Icon(
                _showSolution ? Icons.lightbulb_rounded : Icons.lightbulb_outline_rounded,
                color: _showSolution ? Colors.amber : iconColor,
              ),
              onPressed: () => setState(() => _showSolution = !_showSolution),
            ),
          ),
          Tooltip(
            message: 'New puzzle',
            child: IconButton(
              icon: Icon(Icons.casino_rounded, color: iconColor),
              onPressed: _loadNewBoard,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildRulesDisplay(),
                if (_errorMessage != null)
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red[900],
                      ),
                    ),
                  ),
                if (_hasWon)
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green[300]!, Colors.green[400]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green[200]!,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.emoji_events_rounded, color: Colors.white, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'Puzzle Solved!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: (_isDarkMode ? Colors.black : Colors.black.withOpacity(0.1)),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return GestureDetector(
                                onPanStart: (details) => _handleDragStart(details, context, constraints),
                                onPanUpdate: (details) => _handleDragUpdate(details, context, constraints),
                                onPanEnd: _handleDragEnd,
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    _hasWon ? Colors.grey : Colors.transparent,
                                    BlendMode.saturation,
                                  ),
                                  child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: gridSize,
                                    ),
                                    itemCount: gridSize * gridSize,
                                    itemBuilder: (context, index) {
                                      final int row = index ~/ gridSize;
                                      final int col = index % gridSize;
                                      final Color cellColor = colorRegions[row][col];
                                      final CellState state = _getCellState(row, col);
                                      final bool isError = _errorCells.contains(_getCellKey(row, col));

                                      return GestureDetector(
                                        onTap: () => toggleCell(row, col),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: cellColor == Colors.transparent ? 
                                              cellColor : 
                                              cellColor.withAlpha(((_isDarkMode ? 0.8 : 0.6) * 255).round()),
                                            gradient: isError ? LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                (_isDarkMode ? Colors.red[900]! : Colors.red).withOpacity(0.3),
                                                Colors.transparent
                                              ],
                                              stops: [0.4, 0.6],
                                              tileMode: TileMode.repeated,
                                            ) : null,
                                            border: Border(
                                              top: BorderSide(
                                                color: borderColor,
                                                width: _shouldDrawBorder(row, col, 0) ? 1.5 : 0.0,
                                              ),
                                              right: BorderSide(
                                                color: borderColor,
                                                width: _shouldDrawBorder(row, col, 1) ? 1.5 : 0.0,
                                              ),
                                              bottom: BorderSide(
                                                color: borderColor,
                                                width: _shouldDrawBorder(row, col, 2) ? 1.5 : 0.0,
                                              ),
                                              left: BorderSide(
                                                color: borderColor,
                                                width: _shouldDrawBorder(row, col, 3) ? 1.5 : 0.0,
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: _buildCellContent(state),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCellKey(int row, int col) => '$row-$col';

  CellState _getCellState(int row, int col) {
    if (_showSolution && _solution != null) {
      if (_solution!.any((pos) => pos[0] == row && pos[1] == col)) {
        return CellState.queen;
      }
    }
    return cellStates[_getCellKey(row, col)] ?? CellState.empty;
  }

  void _showError(String message, Set<String> errorCells) {
    setState(() {
      _errorMessage = message;
      _errorCells = errorCells;
    });

    // Clear error after 2 seconds
    _errorTimer?.cancel();
    _errorTimer = Timer(Duration(seconds: 2), () {
      setState(() {
        _errorMessage = null;
        _errorCells = {};
      });
    });
  }

  void toggleCell(int row, int col) {
    if (_hasWon) return;
    
    final key = _getCellKey(row, col);
    final currentState = cellStates[key] ?? CellState.empty;
    CellState newState;
    
    switch (currentState) {
      case CellState.empty:
        newState = CellState.blocked;
        break;
      case CellState.blocked:
        newState = CellState.queen;
        break;
      case CellState.queen:
        newState = CellState.empty;
        break;
    }

    // Record the action before making the change
    _recordAction({key: newState});
    
    setState(() {
      cellStates[key] = newState;
      
      // Clear all violations first
      _errorCells = {};
      _violatedRules = {};
      
      switch (newState) {
        case CellState.blocked:
          _checkBlockedRegions(row, col);
          break;
        case CellState.queen:
          _checkRuleViolations(row, col);
          _checkWinCondition();
          break;
        case CellState.empty:
          _checkAllQueensViolations();
          break;
      }
    });
  }

  void _checkRuleViolations(int newQueenRow, int newQueenCol) {
    Set<String> errorCells = {};
    _violatedRules = {}; // Reset violated rules

    // Get all queen positions
    List<List<int>> queens = [];
    Map<Color, List<List<int>>> queensByColor = {};
    
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (cellStates[_getCellKey(row, col)] == CellState.queen) {
          queens.add([row, col]);
          Color color = colorRegions[row][col];
          queensByColor.putIfAbsent(color, () => []).add([row, col]);
        }
      }
    }

    // Check row violation
    if (queens.where((q) => q[0] == newQueenRow).length > 1) {
      _violatedRules.add(GameRule.onePerRow);
      for (int col = 0; col < gridSize; col++) {
        errorCells.add(_getCellKey(newQueenRow, col));
      }
    }

    // Check column violation
    if (queens.where((q) => q[1] == newQueenCol).length > 1) {
      _violatedRules.add(GameRule.onePerColumn);
      for (int row = 0; row < gridSize; row++) {
        errorCells.add(_getCellKey(row, newQueenCol));
      }
    }

    // Check diagonal violations
    for (var queen in queens) {
      if (queen[0] == newQueenRow && queen[1] == newQueenCol) continue;
      
      if ((queen[0] - newQueenRow).abs() == (queen[1] - newQueenCol).abs()) {
        _violatedRules.add(GameRule.onePerDiagonal);
        
        // Highlight the diagonal path
        int rowDiff = queen[0] - newQueenRow;
        int colDiff = queen[1] - newQueenCol;
        int steps = rowDiff.abs();
        int rowStep = rowDiff ~/ steps;
        int colStep = colDiff ~/ steps;
        
        for (int i = 0; i <= steps; i++) {
          int r = newQueenRow + (i * rowStep);
          int c = newQueenCol + (i * colStep);
          errorCells.add(_getCellKey(r, c));
        }
      }
    }

    // Check color region violation
    Color newQueenColor = colorRegions[newQueenRow][newQueenCol];
    int queensInSameColor = queensByColor[newQueenColor]?.length ?? 0;
    if (queensInSameColor > 1) {
      _violatedRules.add(GameRule.onePerRegion);
      for (int row = 0; row < gridSize; row++) {
        for (int col = 0; col < gridSize; col++) {
          if (colorRegions[row][col] == newQueenColor) {
            errorCells.add(_getCellKey(row, col));
          }
        }
      }
    }

    if (_violatedRules.isNotEmpty) {
      setState(() {
        _errorCells = errorCells;
      });
    }
  }

  void _checkWinCondition() {
    // Get all queen positions
    List<List<int>> queens = [];
    Map<Color, List<List<int>>> queensByColor = {};
    
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (cellStates[_getCellKey(row, col)] == CellState.queen) {
          queens.add([row, col]);
          Color color = colorRegions[row][col];
          queensByColor.putIfAbsent(color, () => []).add([row, col]);
        }
      }
    }

    // Check if we have exactly 8 queens
    if (queens.length != gridSize) return;

    // Check if we have exactly one queen per color
    Set<Color> uniqueColors = Set<Color>.from(colorRegions.expand((row) => row));
    final bool isValidQueenDistribution = queensByColor.length == uniqueColors.length && 
        queensByColor.values.every((list) => list.length == 1);
    if (!isValidQueenDistribution) return;

    // Check if all queens are valid (no same row/column/diagonal)
    for (int i = 0; i < queens.length; i++) {
      for (int j = i + 1; j < queens.length; j++) {
        var queen1 = queens[i];
        var queen2 = queens[j];
        if (queen1[0] == queen2[0] || // Same row
            queen1[1] == queen2[1] || // Same column
            (queen1[0] - queen2[0]).abs() == (queen1[1] - queen2[1]).abs()) { // Same diagonal
          return;
        }
      }
    }

    // If we get here, the player has won
    setState(() {
      _hasWon = true;
    });
  }

  void _handleDragStart(DragStartDetails details, BuildContext context, BoxConstraints constraints) {
    if (_hasWon) return;

    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    
    final cellWidth = constraints.maxWidth / gridSize;
    final cellHeight = constraints.maxHeight / gridSize;
    
    final row = (localPosition.dy / cellHeight).floor();
    final col = (localPosition.dx / cellWidth).floor();
    
    if (row >= 0 && row < gridSize && col >= 0 && col < gridSize) {
      final currentState = _getCellState(row, col);
      if (currentState != CellState.queen) {
        _currentDragChanges = {};
        _dragInitialStates = {}; // Reset initial states
        setState(() {
          _currentDragOperation = currentState == CellState.empty ? 
              CellState.blocked : CellState.empty;
        });
      }
    }
  }

  void _handleDragUpdate(DragUpdateDetails details, BuildContext context, BoxConstraints constraints) {
    if (_hasWon || _currentDragOperation == null) return;
    
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    
    final cellWidth = constraints.maxWidth / gridSize;
    final cellHeight = constraints.maxHeight / gridSize;
    
    final row = (localPosition.dy / cellHeight).floor();
    final col = (localPosition.dx / cellWidth).floor();
    
    if (row >= 0 && row < gridSize && col >= 0 && col < gridSize) {
      final currentState = _getCellState(row, col);
      if (currentState != CellState.queen) {
        final key = _getCellKey(row, col);
        if (cellStates[key] != _currentDragOperation) {
          // Store the initial state if we haven't seen this cell before
          if (!_dragInitialStates.containsKey(key)) {
            _dragInitialStates[key] = cellStates[key] ?? CellState.empty;
          }
          
          _currentDragChanges[key] = _currentDragOperation!;
          
          setState(() {
            cellStates[key] = _currentDragOperation!;
            if (_currentDragOperation == CellState.blocked) {
              _checkBlockedRegions(row, col);
            } else if (_currentDragOperation == CellState.empty) {
              _clearViolationsIfResolved();
            }
          });
        }
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_currentDragChanges.isNotEmpty) {
      // Create the action with the initial states we collected
      _actionHistory.add(GameAction(_dragInitialStates, Map.from(_currentDragChanges)));
      _currentDragChanges = {};
      _dragInitialStates = {};
    }
    setState(() {
      _currentDragOperation = null;
    });
  }

  Widget _buildCellContent(CellState state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellSize = min(constraints.maxWidth, constraints.maxHeight);
        final iconSize = cellSize * 0.6;
        
        switch (state) {
          case CellState.queen:
            return SvgPicture.string(
              '''<svg width="32" height="32" viewBox="0 0 24 24" fill="${_isDarkMode ? 'white' : 'black'}">
                <path d="M12 2L8 7L3 4L4 10L2 16H22L20 10L21 4L16 7L12 2ZM12 4.5L14.5 7.8L12 10L9.5 7.8L12 4.5ZM6.9 14L8 10.2L10.5 12.5L12 10L13.5 12.5L16 10.2L17.1 14H6.9Z"/>
              </svg>''',
              width: iconSize,
              height: iconSize,
            );
          case CellState.blocked:
            return SvgPicture.string(
              '''<svg width="32" height="32" viewBox="0 0 24 24" fill="${_isDarkMode ? 'white' : 'black'}">
                <path d="M6 6L10 10L6 14L8 16L12 12L16 16L18 14L14 10L18 6L16 4L12 8L8 4L6 6Z"/>
              </svg>''',
              width: iconSize * 0.7,
              height: iconSize * 0.7,
            );
          case CellState.empty:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildRulesDisplay() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        runSpacing: 8.0,
        children: GameRule.values.map((rule) {
          final bool isViolated = _violatedRules.contains(rule);
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isViolated 
                ? (_isDarkMode ? Colors.red[900] : Colors.red[50])
                : surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isViolated 
                  ? (_isDarkMode ? Colors.red[700]! : Colors.red[300]!)
                  : (_isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                width: 1,
              ),
              boxShadow: [
                if (isViolated)
                  BoxShadow(
                    color: (_isDarkMode ? Colors.red[900]! : Colors.red[100]!).withOpacity(0.5),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getRuleIcon(rule),
                  color: isViolated 
                    ? (_isDarkMode ? Colors.red[300] : Colors.red[700])
                    : (_isDarkMode ? Colors.grey[300] : Colors.grey[700]),
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  _getRuleShortText(rule),
                  style: TextStyle(
                    fontSize: 13,
                    color: isViolated 
                      ? (_isDarkMode ? Colors.red[300] : Colors.red[900])
                      : textColor,
                    fontWeight: isViolated ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getRuleIcon(GameRule rule) {
    switch (rule) {
      case GameRule.onePerRow:
        return Icons.table_rows_rounded;
      case GameRule.onePerColumn:
        return Icons.view_column_rounded;
      case GameRule.onePerDiagonal:
        return Icons.trending_up_rounded;
      case GameRule.onePerRegion:
        return Icons.palette_rounded;
    }
  }

  String _getRuleShortText(GameRule rule) {
    switch (rule) {
      case GameRule.onePerRow:
        return '1 per row';
      case GameRule.onePerColumn:
        return '1 per column';
      case GameRule.onePerDiagonal:
        return 'max 1 per diagonal';
      case GameRule.onePerRegion:
        return '1 per region';
    }
  }

  // Add this new method to check all queens
  void _checkAllQueensViolations() {
    Set<String> errorCells = {};
    _violatedRules = {}; // Reset violated rules

    // Get all queen positions
    List<List<int>> queens = [];
    Map<Color, List<List<int>>> queensByColor = {};
    
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (cellStates[_getCellKey(row, col)] == CellState.queen) {
          queens.add([row, col]);
          Color color = colorRegions[row][col];
          queensByColor.putIfAbsent(color, () => []).add([row, col]);
        }
      }
    }

    // Check all queens for violations
    for (var queen in queens) {
      // Check row violations
      if (queens.where((q) => q[0] == queen[0]).length > 1) {
        _violatedRules.add(GameRule.onePerRow);
        for (int col = 0; col < gridSize; col++) {
          errorCells.add(_getCellKey(queen[0], col));
        }
      }

      // Check column violations
      if (queens.where((q) => q[1] == queen[1]).length > 1) {
        _violatedRules.add(GameRule.onePerColumn);
        for (int row = 0; row < gridSize; row++) {
          errorCells.add(_getCellKey(row, queen[1]));
        }
      }

      // Check diagonal violations
      for (var otherQueen in queens) {
        if (queen == otherQueen) continue;
        
        if ((queen[0] - otherQueen[0]).abs() == (queen[1] - otherQueen[1]).abs()) {
          _violatedRules.add(GameRule.onePerDiagonal);
          
          // Highlight the diagonal path
          int rowDiff = otherQueen[0] - queen[0];
          int colDiff = otherQueen[1] - queen[1];
          int steps = rowDiff.abs();
          int rowStep = rowDiff ~/ steps;
          int colStep = colDiff ~/ steps;
          
          for (int i = 0; i <= steps; i++) {
            int r = queen[0] + (i * rowStep);
            int c = queen[1] + (i * colStep);
            errorCells.add(_getCellKey(r, c));
          }
        }
      }

      // Check color region violations
      Color queenColor = colorRegions[queen[0]][queen[1]];
      if (queensByColor[queenColor]!.length > 1) {
        _violatedRules.add(GameRule.onePerRegion);
        for (int row = 0; row < gridSize; row++) {
          for (int col = 0; col < gridSize; col++) {
            if (colorRegions[row][col] == queenColor) {
              errorCells.add(_getCellKey(row, col));
            }
          }
        }
      }
    }

    setState(() {
      _errorCells = errorCells;
    });
  }

  bool _shouldDrawBorder(int row, int col, int direction) {
    // direction: 0 = top, 1 = right, 2 = bottom, 3 = left
    if (row < 0 || row >= gridSize || col < 0 || col >= gridSize) return true;
    
    switch (direction) {
      case 0: // top
        return row == 0 || colorRegions[row][col] != colorRegions[row - 1][col];
      case 1: // right
        return col == gridSize - 1 || colorRegions[row][col] != colorRegions[row][col + 1];
      case 2: // bottom
        return row == gridSize - 1 || colorRegions[row][col] != colorRegions[row + 1][col];
      case 3: // left
        return col == 0 || colorRegions[row][col] != colorRegions[row][col - 1];
      default:
        return false;
    }
  }

  void _toggleTimer() {
    setState(() {
      if (_isTimerRunning) {
        _gameTimer?.cancel();
      } else {
        _gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (!_hasWon) {
            setState(() {
              _elapsedTime += Duration(seconds: 1);
            });
          } else {
            timer.cancel();
          }
        });
      }
      _isTimerRunning = !_isTimerRunning;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  // Add this new method to check for fully blocked regions
  void _checkBlockedRegions(int row, int col) {
    Set<String> errorCells = {};
    _violatedRules = {}; // Reset violated rules

    // Check row
    bool isRowBlocked = true;
    for (int c = 0; c < gridSize; c++) {
      if (_getCellState(row, c) != CellState.blocked) {
        isRowBlocked = false;
        break;
      }
    }
    if (isRowBlocked) {
      _violatedRules.add(GameRule.onePerRow);
      for (int c = 0; c < gridSize; c++) {
        errorCells.add(_getCellKey(row, c));
      }
    }

    // Check column
    bool isColBlocked = true;
    for (int r = 0; r < gridSize; r++) {
      if (_getCellState(r, col) != CellState.blocked) {
        isColBlocked = false;
        break;
      }
    }
    if (isColBlocked) {
      _violatedRules.add(GameRule.onePerColumn);
      for (int r = 0; r < gridSize; r++) {
        errorCells.add(_getCellKey(r, col));
      }
    }

    // Check color region
    Color regionColor = colorRegions[row][col];
    bool isRegionBlocked = true;
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (colorRegions[r][c] == regionColor && 
            _getCellState(r, c) != CellState.blocked) {
          isRegionBlocked = false;
          break;
        }
      }
    }
    if (isRegionBlocked) {
      _violatedRules.add(GameRule.onePerRegion);
      for (int r = 0; r < gridSize; r++) {
        for (int c = 0; c < gridSize; c++) {
          if (colorRegions[r][c] == regionColor) {
            errorCells.add(_getCellKey(r, c));
          }
        }
      }
    }

    if (_violatedRules.isNotEmpty) {
      setState(() {
        _errorCells = errorCells;
      });
    }
  }

  // Add this new method to check if violations should be cleared
  void _clearViolationsIfResolved() {
    // If there are no violations currently shown, no need to check
    if (_violatedRules.isEmpty) return;

    bool hasBlockedRow = false;
    bool hasBlockedColumn = false;
    bool hasBlockedDiagonal = false;
    bool hasBlockedRegion = false;

    // Check rows
    for (int row = 0; row < gridSize; row++) {
      bool isRowBlocked = true;
      for (int col = 0; col < gridSize; col++) {
        if (_getCellState(row, col) != CellState.blocked) {
          isRowBlocked = false;
          break;
        }
      }
      if (isRowBlocked) {
        hasBlockedRow = true;
        break;
      }
    }

    // Check columns
    for (int col = 0; col < gridSize; col++) {
      bool isColBlocked = true;
      for (int row = 0; row < gridSize; row++) {
        if (_getCellState(row, col) != CellState.blocked) {
          isColBlocked = false;
          break;
        }
      }
      if (isColBlocked) {
        hasBlockedColumn = true;
        break;
      }
    }

    // Check diagonals
    for (int startRow = 0; startRow < gridSize; startRow++) {
      for (int startCol = 0; startCol < gridSize; startCol++) {
        // Check main diagonal starting from this position
        List<List<int>> mainDiagonal = [];
        List<List<int>> antiDiagonal = [];
        
        for (int i = 0; i < gridSize; i++) {
          for (int j = 0; j < gridSize; j++) {
            if ((i - j) == (startRow - startCol)) {
              mainDiagonal.add([i, j]);
            }
            if ((i + j) == (startRow + startCol)) {
              antiDiagonal.add([i, j]);
            }
          }
        }

        if (mainDiagonal.length > 1 && mainDiagonal.every(
          (pos) => _getCellState(pos[0], pos[1]) == CellState.blocked
        )) {
          hasBlockedDiagonal = true;
          break;
        }

        if (antiDiagonal.length > 1 && antiDiagonal.every(
          (pos) => _getCellState(pos[0], pos[1]) == CellState.blocked
        )) {
          hasBlockedDiagonal = true;
          break;
        }
      }
      if (hasBlockedDiagonal) break;
    }

    // Check color regions
    Set<Color> checkedColors = {};
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        Color regionColor = colorRegions[row][col];
        if (!checkedColors.contains(regionColor)) {
          checkedColors.add(regionColor);
          bool isRegionBlocked = true;
          for (int r = 0; r < gridSize; r++) {
            for (int c = 0; c < gridSize; c++) {
              if (colorRegions[r][c] == regionColor && 
                  _getCellState(r, c) != CellState.blocked) {
                isRegionBlocked = false;
                break;
              }
            }
            if (!isRegionBlocked) break;
          }
          if (isRegionBlocked) {
            hasBlockedRegion = true;
            break;
          }
        }
      }
      if (hasBlockedRegion) break;
    }

    // If no violations are found, clear the error state
    if (!hasBlockedRow && !hasBlockedColumn && !hasBlockedDiagonal && !hasBlockedRegion) {
      setState(() {
        _errorCells = {};
        _violatedRules = {};
      });
    }
  }

  // Add these methods to handle actions
  void _recordAction(Map<String, CellState> changedCells) {
    Map<String, CellState> previousStates = {};
    Map<String, CellState> newStates = {};
    
    for (var key in changedCells.keys) {
      previousStates[key] = cellStates[key] ?? CellState.empty;
      newStates[key] = changedCells[key]!;
    }
    
    _actionHistory.add(GameAction(previousStates, newStates));
  }

  void _undo() {
    if (_actionHistory.isEmpty) return;
    
    setState(() {
      final action = _actionHistory.removeLast();
      
      // Remove the new states (current states) from the cellStates map
      action.newStates.keys.forEach((key) {
        cellStates.remove(key);
      });
      
      // Only add back non-empty previous states
      action.previousStates.forEach((key, state) {
        if (state != CellState.empty) {
          cellStates[key] = state;
        }
      });
      
      // Check for any remaining violations
      _clearViolationsIfResolved();
      _checkAllQueensViolations();
    });
  }

  void _clearBoard() {
    if (cellStates.isEmpty) return;
    
    setState(() {
      // Record the clear action
      Map<String, CellState> clearedStates = Map.from(cellStates);
      _recordAction(clearedStates);
      
      // Clear the board
      cellStates.clear();
      _errorCells.clear();
      _violatedRules.clear();
    });
  }

  void _loadNewBoard() {
    final board = BoardStorage.getRandomBoard();
    setState(() {
      colorRegions = board.colorRegions;
      _solution = board.solution;
      _hasWon = false;
      cellStates.clear();
      _elapsedTime = Duration.zero;
      
      // Cancel existing timer
      _gameTimer?.cancel();
      _isTimerRunning = false;
    });
    
    // Start timer after setState is complete
    _toggleTimer();
  }
}


// TODO: 
//Add a hint system
//Make the levels not totally random, but more easily solvable through known tactics.