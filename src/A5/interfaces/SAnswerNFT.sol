// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface SAnswerNFT {
    struct Person {
        address addr;
        uint256 collateral;
        uint256 debt;
    }

    struct Vars {
        Person alice;
        Person bob;
        uint256 balance;
        bool canEnter;
    }
}