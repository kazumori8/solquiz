// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { SAnswerNativeToken } from "src/A4/interfaces/SAnswerNativeToken.sol";

interface IAnswerNativeToken {
    function gimmeLicense(SAnswerNativeToken.LicenseCandidate memory candidate) external payable;
    function licenseHolders(address _key) external returns (address, uint256);
}
