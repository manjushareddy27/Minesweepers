# Minesweepers

This is a game of Minesweeper built in Ruby. It is played in the terminal. To play, run the command /bin/minesweeper.rb. 


Setup 

To start a new game, enter Yes when prompted. Then enter a board size, and then the letter e, m, or h, corresponding to easy, medium, or hard difficulty. On easy difficulty, one tenth of the board will be covered in mines. On medium difficulty, one seventh. On hard difficulty, one fifth. More points are awarded for completing the game on higher difficulties and with larger boards.

Rules 

The rules of Minesweeper can be found here.

Input 

Choose a move by entering the letter r or f for reveal or flag, followed by a two-integer coordinate on the board. For example, a valid move would be r02 to reveal the tile at coordinate (0, 2), where the horizontal coordinate is first.

Output 

On the game board, * indicates an unrevealed tile. An integer indicates the number of adjacent tiles that contain a mine. _ indicates a safe tile with no adjacent mines F indicates a flagged tile. In the end-game board display, M indicates a tile with a mine on it.
