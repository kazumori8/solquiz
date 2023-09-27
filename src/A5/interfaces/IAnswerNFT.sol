// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IAnswerNFT {
    function setNFT(address _nft) external;
    function buyBoosterPack() external payable;
    function canEnterByOriginHolder() external view returns (bool);
}