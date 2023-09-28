// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract GameGomoku {
    enum Player { None, Host, Challenger }
    enum GameState { Open, Ongoing, Finished }

    struct Game {
        address host;
        address challenger;
        Player currentPlayer;
        GameState state;
        Player[15][15] board;
        bool endGame;
        address winnerAddr;
    }

    mapping(uint => Game) public games;
    uint public gameIdCounter = 1;

    function createGame() public returns (uint) {
        uint gameId = gameIdCounter++;
        games[gameId] = Game(msg.sender, address(0), Player.Host, GameState.Open, _createEmptyBoard(), false, address(0));
        return gameId;
    }

    function joinGame(uint gameId) public returns (uint) {
        Game storage game = games[gameId];
        require(game.state == GameState.Open, "Game is not open");
        require(msg.sender != game.host, "Host cannot join the game");
        
        game.challenger = msg.sender;
        game.state = GameState.Ongoing;
        return gameId;
    }

    function play(uint gameId, uint8 row, uint8 col) public returns(string memory){
        Game storage game = games[gameId];
        require(game.state == GameState.Ongoing, "Game is not ongoing");
        require(game.board[row][col] == Player.None, "Cell is already occupied");
        require((msg.sender == game.host && game.currentPlayer == Player.Host) || 
                (msg.sender == game.challenger && game.currentPlayer == Player.Challenger), "Not your turn");
        if(game.endGame){
            if(msg.sender == game.winnerAddr){
                return "You win!";
            }else{
                return "You lose!";
            }
        }
        game.board[row][col] = game.currentPlayer;
        
        if (_checkWin(game.board, row, col, game.currentPlayer)) {
            game.state = GameState.Finished;
            game.endGame = true;
            game.winnerAddr = msg.sender;
            return "You win!";
        }
        
        game.currentPlayer = (game.currentPlayer == Player.Host) ? Player.Challenger : Player.Host;
        return "continue";
    }

    function _createEmptyBoard() internal pure returns (Player[15][15] memory) {
        Player[15][15] memory board;
        for (uint8 i = 0; i < 15; i++)
            for (uint8 j = 0; j < 15; j++)
                board[i][j] = Player.None;
        return board;
    }
    function _checkWin(Player[15][15] storage board, uint8 row, uint8 col, Player player) internal view returns (bool) {
        uint8[4] memory xDirections = [1, 0, 1, 1];
        uint8[4] memory yDirections = [0, 1, 1, 1]; // -1 is replaced with 1, adjusted logic accordingly
        
        for (uint8 i = 0; i < 4; i++) {
            uint8 count = 1;
            for (uint8 j = 1; j <= 4; j++) {
                bool flag = true;
                for (uint8 k = 0; k < 2; k++) { // k = 0 for positive direction, k = 1 for negative direction
                    uint8 newRow;
                    uint8 newCol;
                    if (k == 1 && (j > row || j > col)) continue; // Prevent underflow
                    
                    if (k == 0) {
                        newRow = row + j * xDirections[i];
                        newCol = col + j * yDirections[i];
                    } else {
                        newRow = row - j * xDirections[i];
                        newCol = col - j * yDirections[i];
                    }
                    
                    // Check boundary conditions
                    if (newRow >= 15 || newCol >= 15) continue;
                    if (board[newRow][newCol] != player) {
                        flag = false;
                        break;
                    }
                }
                if (flag) count += 1;
                if (count == 5) return true;
            }
        }
        return false;
    }


}
