// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {AnswerStructAndStorage} from "src/A2/AnswerStructAndStorage.sol";
import {SAnswerStructAndStorage} from "src/A2/interfaces/SAnswerStructAndStorage.sol";


contract  QuestionStructAndStorage is Test, SAnswerStructAndStorage {
    using stdStorage for StdStorage;
    AnswerStructAndStorage structAndStorage;

    struct Test2Vars {
      uint256 slot;
    }

    function setUp() public {
        structAndStorage = new AnswerStructAndStorage();
    }

    function test_Q2_StructAndStorage() public {
        Test2Vars memory vars;
        YourScore memory _score;
        _score.name = "John Doe";
        _score.description = "This is a sample score.";
        _score.score = 50;

        structAndStorage.submitScoreWithCheat(_score);

        vars.slot = stdstore
                        .target(address(structAndStorage))
                        .sig(structAndStorage.scores.selector)
                        .with_key(address(this))
                        .depth(2) // Note: Struct getter returns array of members
                        .find();
        assertEq(uint256(vm.load(address(structAndStorage), bytes32(vars.slot))), 100);

        /*
            Hint:
                このテストはストレージに狙った値が入っていることをテストしています。
                したがって、ストレージを検査するために外部からストレージを閲覧できるようにしてあげる必要があります。
                Solidityにおいてことなるコントラクトを叩くときは、インターフェースを用います。
                インターフェースはコンパイラに型情報をよりたくさん与えられるので、
                コンパイラが人間の代わりにミスを発見してくれる良さもあります。
        */
    }
}