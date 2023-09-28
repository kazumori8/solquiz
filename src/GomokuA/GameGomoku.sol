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
        if(game.endGame){
            if(msg.sender == game.host || msg.sender == game.challenger){
                if(msg.sender == game.winnerAddr){
                    return "You already win!";
                }else{
                    return "You already lose!";    
                }
            }
        }
        
        require(game.state == GameState.Ongoing, "Game is not ongoing");
        require(game.board[row][col] == Player.None, "Cell is already occupied");
        require((msg.sender == game.host && game.currentPlayer == Player.Host) || 
                (msg.sender == game.challenger && game.currentPlayer == Player.Challenger), "Not your turn");
        game.board[row][col] = game.currentPlayer;
        
        if (_checkWin(game.board, row, col, game.currentPlayer)) {
            game.state = GameState.Finished;
            game.endGame = true;
            game.winnerAddr = msg.sender;
            return "You win!";
        }
        
        game.currentPlayer = (game.currentPlayer == Player.Host) ? Player.Challenger : Player.Host;
        return "End of your turn";
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
        uint8[4] memory yDirections = [0, 1, 1, 1];
        
        for (uint8 i = 0; i < 4; i++) {
            uint8 count = 1;
            for (uint8 j = 1; j <= 4; j++) {
                uint8 posX = row + j * xDirections[i];
                uint8 posY = col + j * yDirections[i];
                uint8 negX = row >= j * xDirections[i] ? row - j * xDirections[i] : 15; 
                uint8 negY = col >= j * yDirections[i] ? col - j * yDirections[i] : 15;
                
                if(i != 3) {
                    if (posX < 15 && posY < 15 && board[posX][posY] == player) count++;
                    if (negX < 15 && negY < 15 && board[negX][negY] == player) count++;
                } else {
                    // For the diagonal direction in the top-right.
                    if (posX < 15 && col >= j && board[posX][col - j] == player) count++;
                    if (row >= j && posY < 15 && board[row - j][posY] == player) count++;
                }

                if (count >= 5) return true;
            }
            if (count < 5) count = 1; // Reset count for the next direction.
        }
        return false;
    }
}
