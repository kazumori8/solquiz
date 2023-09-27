// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract AnswerArithmetic {
    /**
        A-1. 四則演算を試す/gasleft()とconsole.log()を学ぶ
    */
    function calc() external pure returns (uint256) {
      uint256 MAX_INT = 2**256 -1;
      return MAX_INT; // Note: Fix me!
  }
}