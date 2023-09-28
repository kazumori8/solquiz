// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

import { IQuestionGomokuPlayersPerson } from "./interfaces/IQuestionGomokuPlayersPerson.sol";
import { GomokuProxy } from "src/UpgradableGomokuA/GomokuProxy.sol";

import { GomokuLogic } from "src/UpgradableGomokuA/GomokuLogic.sol";
contract PlayGomoku is Test, IQuestionGomokuPlayersPerson{
    GomokuProxy gomokuProxy;
    address gomokuProxyAddress;
    GomokuLogic gomokuLogic;
    address gomokuLogicAddress;
    function setUp() public {
        gomokuLogic = new GomokuLogic();
        gomokuProxy = new GomokuProxy(address(gomokuLogic)); // GomokuProxyをインスタンス化
        gomokuProxyAddress = address(gomokuProxy);
    }

    function testGomokuPlayGomokuGomogomo() public {
        TestVars memory vars; // Note: structに一時変数を保存するクセをつけておくと "Stack too deep" に泣かされないで済むぞ。（メモリ空間上のスロットは有限リソース）
        vars.alice.addr = makeAddr("Alice");
        vars.bob.addr = makeAddr("Bob");
        vars.carl.addr = makeAddr("Carl");
        
   // create game
        vm.prank(vars.alice.addr);
        vars.alice.playGameId = gomokuProxy.delegatecallCreateGame();
        assertEq(vars.alice.playGameId, 1);



        // Join game
        vm.prank(vars.bob.addr);
        vars.bob.playGameId = gomokuProxy.delegatecallJoinGame(1);
        assertEq(vars.bob.playGameId, 1);

        // start game
        vm.prank(vars.alice.addr);
        gomokuProxy.delegatecallPlay(1, 0, 1);
        
        vm.prank(vars.bob.addr);
        gomokuProxy.delegatecallPlay(1, 1, 0);

        for (uint i = 2; i < 8; i++){
            vm.prank(vars.alice.addr);
            gomokuProxy.delegatecallPlay(1,uint8(16-i), uint8(i));
            
            vm.prank(vars.bob.addr);
            gomokuProxy.delegatecallPlay(1, uint8(i*2),0);
        }
        // for (uint i = 2; i < 8; i++){
        //     vm.prank(vars.alice.addr);
        //     gomokuProxy.play(1,uint8(i), uint8(i));
            
        //     vm.prank(vars.bob.addr);
        //     gomokuProxy.play(1, uint8(i*2),0);
        // }
        // bool aliceFlg = false;
        // for (uint i = 0; i <15; i+=2){
        //     for (uint j = 0; j < 15; j++){
        //         if(!aliceFlg){
        //             vm.prank(vars.alice.addr);
        //             gomokuProxy.play(1, uint8(i), uint8(j));
        //         }else{
        //             vm.prank(vars.bob.addr);
        //             gomokuProxy.play(1, uint8(i), uint8(j));
        //         }
        //         aliceFlg = !aliceFlg;
        //     }
        // }
        // for (uint i = 1; i <15; i+=2){
        //     for (uint j = 0; j < 15; j++){
        //         if(!aliceFlg){
        //             vm.prank(vars.alice.addr);
        //             gomokuProxy.play(1, uint8(i), uint8(j));
        //         }else{
        //             vm.prank(vars.bob.addr);
        //             gomokuProxy.play(1, uint8(i), uint8(j));
        //         }
        //         aliceFlg = !aliceFlg;
        //     }
        // }
        vm.prank(vars.alice.addr);
        gomokuProxy.delegatecallPlay(1, 1, 0);

        vm.prank(vars.carl.addr);
        gomokuProxy.delegatecallPlay(1,0, 6);

    }
}
