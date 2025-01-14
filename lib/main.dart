import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.yellow,
    Colors.pink,
    Colors.teal,
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

    // Assign random growth rates to each color (between 0.3 and 0.9)
    Map<Color, double> growthRates = {};
    for (var color in availableColors) {
      growthRates[color] = 0.3 + Random().nextDouble() * 0.6;
    }

    // Then grow each region one cell at a time, taking turns
    bool changed;
    do {
      changed = false;
      // Shuffle the order each time to avoid bias
      List<Color> currentColors = List.from(availableColors)..shuffle();
      for (var color in currentColors) {
        // Try to grow this region, with its specific growth rate
        if (Random().nextDouble() < growthRates[color]!) {
          if (_growRegionOneStep(regions, color)) {
            changed = true;
          }
        }
      }
    } while (changed);

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

  static void _growConnectedRegion(List<List<Color>> regions, int row, int col, Color color) {
    if (row < 0 || row >= 8 || col < 0 || col >= 8 || regions[row][col] != Colors.transparent) {
      return;
    }

    regions[row][col] = color;
    
    // Get all possible directions
    List<List<int>> directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    directions.shuffle();

    // Try each direction randomly
    for (var dir in directions) {
      int newRow = row + dir[0];
      int newCol = col + dir[1];
      
      // Only grow with 50% chance to create more interesting shapes
      if (Random().nextBool()) {
        _growConnectedRegion(regions, newRow, newCol, color);
      }
    }
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
      home: const QueensGameScreen(),
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

class _QueensGameScreenState extends State<QueensGameScreen> {
  final int gridSize = 8;
  final Map<String, CellState> cellStates = {};
  bool _isGenerating = false;
  bool _showSolution = false;
  bool _hasWon = false;
  List<List<int>>? _solution;
  late List<List<Color>> colorRegions;
  String? _errorMessage;
  Set<String> _errorCells = {};
  Timer? _errorTimer;

  @override
  void initState() {
    super.initState();
    _loadNewBoard();
  }

  void _loadNewBoard() {
    final board = BoardStorage.getRandomBoard();
    setState(() {
      colorRegions = board.colorRegions;
      _solution = board.solution;
      _hasWon = false;
      cellStates.clear();
    });
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
    if (_hasWon) return; // Prevent moves after winning
    
    setState(() {
      final key = _getCellKey(row, col);
      final currentState = cellStates[key] ?? CellState.empty;
      
      switch (currentState) {
        case CellState.empty:
          cellStates[key] = CellState.blocked;
          break;
        case CellState.blocked:
          cellStates[key] = CellState.queen;
          // Check for rule violations before checking win
          _checkRuleViolations(row, col);
          _checkWinCondition();
          break;
        case CellState.queen:
          cellStates[key] = CellState.empty;
          break;
      }
    });
  }

  void _checkRuleViolations(int newQueenRow, int newQueenCol) {
    Set<String> errorCells = {};
    String? errorMessage;

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
      errorMessage = 'Multiple queens in the same row!';
      for (int col = 0; col < gridSize; col++) {
        errorCells.add(_getCellKey(newQueenRow, col));
      }
    }

    // Check column violation
    if (queens.where((q) => q[1] == newQueenCol).length > 1) {
      errorMessage = 'Multiple queens in the same column!';
      for (int row = 0; row < gridSize; row++) {
        errorCells.add(_getCellKey(row, newQueenCol));
      }
    }

    // Check color region violation
    Color newQueenColor = colorRegions[newQueenRow][newQueenCol];
    int queensInSameColor = queensByColor[newQueenColor]?.length ?? 0;
    if (queensInSameColor > 1) {
      errorMessage = 'Multiple queens in the same color region!';
      // Add all cells of the same color
      for (int row = 0; row < gridSize; row++) {
        for (int col = 0; col < gridSize; col++) {
          if (colorRegions[row][col] == newQueenColor) {
            errorCells.add(_getCellKey(row, col));
          }
        }
      }
    }

    if (errorMessage != null) {
      _showError(errorMessage, errorCells);
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

    // Check if all queens are valid (no same row/column)
    for (int i = 0; i < queens.length; i++) {
      for (int j = i + 1; j < queens.length; j++) {
        var queen1 = queens[i];
        var queen2 = queens[j];
        if (queen1[0] == queen2[0] || // Same row
            queen1[1] == queen2[1]) { // Same column
          return;
        }
      }
    }

    // If we get here, the player has won
    setState(() {
      _hasWon = true;
    });
  }

  void _handleDragUpdate(DragUpdateDetails details, BuildContext context, BoxConstraints constraints) {
    if (_hasWon) return; // Prevent moves after winning
    
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    
    final cellWidth = constraints.maxWidth / gridSize;
    final cellHeight = constraints.maxHeight / gridSize;
    
    final row = (localPosition.dy / cellHeight).floor();
    final col = (localPosition.dx / cellWidth).floor();
    
    if (row >= 0 && row < gridSize && col >= 0 && col < gridSize) {
      final currentState = _getCellState(row, col);
      if (currentState != CellState.queen) {
        setState(() {
          cellStates[_getCellKey(row, col)] = CellState.blocked;
        });
      }
    }
  }

  Widget _buildCellContent(CellState state) {
    switch (state) {
      case CellState.queen:
        return const Icon(
          Icons.person,
          color: Colors.black,
          size: 32,
        );
      case CellState.blocked:
        return const Icon(
          Icons.close,
          color: Colors.red,
          size: 28,
        );
      case CellState.empty:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(_showSolution ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _showSolution = !_showSolution),
            tooltip: 'Toggle Solution',
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadNewBoard,
            tooltip: 'New Board',
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                if (_hasWon)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Congratulations! You solved the puzzle!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return GestureDetector(
                            onPanUpdate: (details) => _handleDragUpdate(details, context, constraints),
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
                                        border: Border.all(color: Colors.black12),
                                        color: cellColor == Colors.transparent ? cellColor : cellColor.withAlpha((0.3 * 255).round()),
                                        gradient: isError ? LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [Colors.red.withOpacity(0.3), Colors.transparent],
                                          stops: [0.4, 0.6],
                                          tileMode: TileMode.repeated,
                                        ) : null,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _errorTimer?.cancel();
    super.dispose();
  }
}


// TODO: 
//Add a timer to the game
//Add a hint system
//Let user drag to remove the blocked cells
//add undo button to remove the last action (e.g. placed cell, dragged cells, etc.)
//add a reset button to reset the board to the initial state
