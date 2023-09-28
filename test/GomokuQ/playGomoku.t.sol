// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

import { IQuestionGomokuPlayersPerson } from "./interfaces/IQuestionGomokuPlayersPerson.sol";
import { GameGomoku } from "src/GomokuA/GameGomoku.sol";

contract PlayGomoku is Test, IQuestionGomokuPlayersPerson{
    GameGomoku _yourContract;
    address _yourContractAddress;

    function setUp() public {
        _yourContract = new GameGomoku();
        _yourContractAddress = address(_yourContract);
    }

    function testGomokuPlayGomokuGomogomo() public {
        TestVars memory vars; // Note: structに一時変数を保存するクセをつけておくと "Stack too deep" に泣かされないで済むぞ。（メモリ空間上のスロットは有限リソース）
        vars.alice.addr = makeAddr("Alice");
        vars.bob.addr = makeAddr("Bob");
        vars.carl.addr = makeAddr("Carl");
        
        // create game
        vm.prank(vars.alice.addr);
        vars.alice.playGameId = _yourContract.createGame();
        assertEq(vars.alice.playGameId, 1);
        //Join game
        vm.prank(vars.bob.addr);
        vars.bob.playGameId = _yourContract.joinGame(1);
        assertEq(vars.bob.playGameId, 1);
        //start game
        vm.prank(vars.alice.addr);
        _yourContract.play(1,0,1);
        
        vm.prank(vars.bob.addr);
        _yourContract.play(1,1,0);

        for (uint i = 2; i < 8; i++){
            vm.prank(vars.alice.addr);
            _yourContract.play(1,0, uint8(i));
            
            vm.prank(vars.bob.addr);
            _yourContract.play(1, uint8(i),0);
        }
        vm.prank(vars.alice.addr);
        _yourContract.play(1,0, 6);


    }
}
