// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { SAnswerConditionalCheck } from "src/A3/interfaces/SAnswerConditionalCheck.sol";

interface IAnswerConditionalCheck {
    function borrowMore(SAnswerConditionalCheck.Person memory person, uint256 amount) external returns (bool);
}
