// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract GomokuStorage {
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
        // string gameComment;
    }

    mapping(uint => Game) public games;
    uint public gameIdCounter = 1;
    address public logicContract;
    address public admin;
}
