// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./GomokuStorage.sol";
import "./GomokuLogic.sol";

contract GomokuProxy is GomokuStorage {
    address public gomokuLogicAddr;
    
    constructor(address _gomokuLogicAddr) {
        gomokuLogicAddr = _gomokuLogicAddr;
    }
    
    function delegatecallCreateGame() public returns (uint) {
        (bool success, bytes memory data) = gomokuLogicAddr.delegatecall(
            abi.encodeWithSignature("createGame()")
        );
        require(success, "delegatecall failed");
        uint gameId = abi.decode(data, (uint));
        return gameId;
    }
    
    function delegatecallJoinGame(uint gameId) public returns (uint) {
        (bool success, bytes memory data) = gomokuLogicAddr.delegatecall(
            abi.encodeWithSignature("joinGame(uint256)", gameId)
        );
        require(success, "delegatecall failed");
        return abi.decode(data, (uint));
    }
    
    function delegatecallPlay(uint gameId, uint8 row, uint8 col) public returns (string memory) {
        (bool success, bytes memory data) = gomokuLogicAddr.delegatecall(
            abi.encodeWithSignature("play(uint256,uint8,uint8)", gameId, row, col)
        );
        require(success, "delegatecall failed");
        return abi.decode(data, (string));
    }
}
