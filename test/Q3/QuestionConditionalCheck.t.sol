// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import { AnswerConditionalCheck } from "src/A3/AnswerConditionalCheck.sol";
import { IQuestionConditionalCheck } from "./interfaces/IQuestionConditionalCheck.sol";

contract QuestionConditionalCheck is Test, IQuestionConditionalCheck {
    using stdStorage for StdStorage;

    AnswerConditionalCheck yourContract;
    address yourContractAddress;

    function setUp() public {
        yourContract = new AnswerConditionalCheck();
        yourContractAddress = address(yourContract);
    }

    /**
        Q-3. 制御構文(if, for, require, revert), modifier, アクセス制御, オーナー権限を試す
     */
    function test_Q3_ConditionalCheck() public {
        TestVars memory vars; // Note: structに一時変数を保存するクセをつけておくと "Stack too deep" に泣かされないで済むぞ。（メモリ空間上のスロットは有限リソース）

        /*
            ストーリーサンプル
                - 100万ドルの不動産を担保にドルを借りてるイメージ
                - 担保率=100*担保/負債
                - 不動産価値が落ちて担保率110%くらいになったら現物を抑える(実装しなくてよい)
                - 担保率110%以下になるようなポジションは許さない
        */
        vars.alice.addr = makeAddr("Alice");
        vars.alice.collateral = 100;
        vars.alice.debt = 0;
        vars.bob.addr = makeAddr("Bob");
        vars.bob.collateral = 150;
        vars.bob.debt = 10;
        vars.carl.addr = makeAddr("Carl");
        vars.carl.collateral = 200;
        vars.carl.debt = 200;

        vm.prank(vars.alice.addr);
        vm.expectRevert("Collateralization ratio must be more than 110%");
        vars.result1 = yourContract.borrowMore(vars.alice, 100);

        vm.prank(vars.alice.addr);
        vm.expectRevert("You are not the owner of this account.");
        vars.result1 = yourContract.borrowMore(vars.bob, 100);

        vm.prank(vars.bob.addr);
        vars.result2 = yourContract.borrowMore(vars.bob, 120);

        vm.prank(vars.carl.addr);
        vm.expectRevert("Collateralization ratio is already too high");
        vars.result3 = yourContract.borrowMore(vars.carl, 100);

        assertEq(vars.result1, false);
        assertEq(vars.result2, true);
        assertEq(vars.result3, false);
    }
}
