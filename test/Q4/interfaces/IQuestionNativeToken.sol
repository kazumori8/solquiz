// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {SAnswerNativeToken} from "src/A4/interfaces/SAnswerNativeToken.sol";

interface IQuestionNativeToken {
    struct TestVars {
        SAnswerNativeToken.LicenseCandidate alice;
        SAnswerNativeToken.LicenseCandidate bob;
        uint256 score;
    }
}
