// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import { AnswerNativeToken } from "src/A4/AnswerNativeToken.sol";
import { IQuestionNativeToken } from "./interfaces/IQuestionNativeToken.sol";

contract QuestionNativeToken is Test, IQuestionNativeToken {
    using stdStorage for StdStorage;

    AnswerNativeToken yourContract;
    address yourContractAddress;

    function setUp() public {
        yourContract = new AnswerNativeToken();
        yourContractAddress = address(yourContract);
    }

    /**
        Q-4. ネイティブトークン支払いを試す
     */
    function test_Q4_NativeToken() public {
        TestVars memory vars;

        vars.alice.addr = makeAddr("Alice");
        vars.alice.score = 100;
        vm.deal(vars.alice.addr, 1 ether);
        vars.bob.addr = makeAddr("Bob");
        vars.bob.score = 60;
        vm.deal(vars.bob.addr, 2 ether);

        vm.prank(vars.alice.addr);
        yourContract.gimmeLicense(vars.alice);

        vm.prank(vars.bob.addr);
        vm.expectRevert("You failed.");
        yourContract.gimmeLicense(vars.bob);

        vm.prank(vars.bob.addr);
        vm.expectRevert("You failed.");
        yourContract.gimmeLicense{value: 1e17}(vars.bob);

        (, vars.score) = yourContract.licenseHolders(vars.bob.addr);
        assertEq(vars.score, 0);

        vm.prank(vars.bob.addr);
        yourContract.gimmeLicense{value: 1 ether}(vars.bob);

        (, vars.score) = yourContract.licenseHolders(vars.bob.addr);
        assertEq(vars.score, vars.bob.score);
    }
}
