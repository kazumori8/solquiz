// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {SAnswerConditionalCheck} from "src/A3/interfaces/SAnswerConditionalCheck.sol";

interface IQuestionConditionalCheck {
    struct TestVars {
        SAnswerConditionalCheck.Person alice;
        SAnswerConditionalCheck.Person bob;
        SAnswerConditionalCheck.Person carl;
        bool result1;
        bool result2;
        bool result3;
    }
}
