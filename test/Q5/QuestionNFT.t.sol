// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import { AnswerNFT } from "src/A5/AnswerNFT.sol";
import { SAnswerNFT } from "src/A5/interfaces/SAnswerNFT.sol";
import { YourNFT } from "src/A5/utils/YourNFT.sol";
contract QuestionNFT is Test, SAnswerNFT { 
    AnswerNFT yourContract;
    address yourContractAddress;

    function setUp() public {
        yourContract = new AnswerNFT();
        yourContractAddress = address(yourContract);
    }
    
    /**
        Q-5. ERC-721とapprovalとプログラマブルな送金と多様なコントラクト
        ガチャガチャを通して、ERC-721の内容とコントラクトへの送金を学ぶ
     */
    function test_Q5_NFT() public {
        Vars memory vars;

        YourNFT nft = new YourNFT();
        for(uint256 i; i < 100;) {
            nft.mintItem(address(yourContract));
            unchecked { ++i; }
        }

        yourContract.setNFT(address(nft));

        vars.alice.addr = makeAddr("Alice");
        vm.deal(vars.alice.addr, 2 ether);
        vars.bob.addr = makeAddr("Bob");
        vm.deal(vars.bob.addr, 2 ether);

        vm.prank(vars.alice.addr);
        yourContract.buyBoosterPack{value: 1 ether}();
        vars.balance = nft.balanceOf(vars.alice.addr);
        assertEq(vars.balance, 5);

        vm.prank(vars.bob.addr);
        yourContract.buyBoosterPack{value: 1 ether}(); // 売るためのNFTはこのテストファイル内で用意してある.
        vars.balance = nft.balanceOf(vars.bob.addr);
        assertEq(vars.balance, 5);

        vm.prank(vars.alice.addr);
        vars.canEnter = yourContract.canEnterByOriginHolder();
        assertTrue(vars.canEnter);

        vm.prank(vars.bob.addr);
        vm.expectRevert(abi.encodePacked("You don't have the first NFT."));
        yourContract.canEnterByOriginHolder();
    }
}