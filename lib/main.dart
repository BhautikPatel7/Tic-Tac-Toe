import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String>? _board; // Holds the current state of the game
  bool? _isXTurn; // Keeps track of the current player's turn
  String? _winner; // Keeps track of the winner (if any)

  @override
  void initState() {
    super.initState();
    _resetGame(); // Initialize the game board
  }

  void _resetGame() {
    setState(() {
      _board = List<String>.filled(9, ''); // 9 empty slots
      _isXTurn = true; // X starts the game
      _winner = ''; // No winner initially
    });
  }

  void _handleTap(int index) {
    if (_board![index] != '' || _winner != '') {
      return; // Do nothing if the cell is already occupied or game is over
    }

    setState(() {
      _board![index] =
          _isXTurn! ? 'X' : 'O'; // Assign X or O to the tapped cell
      _isXTurn = !_isXTurn!; // Toggle the player turn
      _winner = _checkWinner(); // Check if there's a winner
    });
  }

  String _checkWinner() {
    const List<List<int>> winningCombinations = [
      [0, 1, 2], // Top row
      [3, 4, 5], // Middle row
      [6, 7, 8], // Bottom row
      [0, 3, 6], // Left column
      [1, 4, 7], // Middle column
      [2, 5, 8], // Right column
      [0, 4, 8], // Diagonal top-left to bottom-right
      [2, 4, 6], // Diagonal top-right to bottom-left
    ];

    // Check if any winning combination is satisfied
    for (var combo in winningCombinations) {
      if (_board![combo[0]] != '' &&
          _board![combo[0]] == _board![combo[1]] &&
          _board![combo[1]] == _board![combo[2]]) {
        return _board![combo[0]]; // Return the winner (X or O)
      }
    }

    // If all cells are filled and no winner, it's a draw
    if (!_board!.contains('')) {
      return 'Draw';
    }

    return ''; // No winner yet
  }

  Widget _buildBoard() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3x3 grid
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _handleTap(index),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                _board![index],
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: _buildBoard(), // Display the game board
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _winner!.isNotEmpty
                  ? _winner == 'Draw'
                      ? 'It\'s a Draw!'
                      : 'Winner: $_winner'
                  : 'Turn: ${_isXTurn! ? 'X' : 'O'}',
              style: TextStyle(fontSize: 24),
            ),
          ),
          ElevatedButton(
            onPressed: _resetGame, // Reset the game
            child: Text('Restart Game'),
          ),
        ],
      ),
    );
  }
}
