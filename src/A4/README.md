---
title: FAQ for Q4
---

# Q-4. ネイティブトークン支払いを試す


## 手順
`test/Q4/Question.t.sol`ファイル内にあるテスト関数`test_Q4_NativeToken()`のシナリオをよく読み、
`src/A4/AnswerSheet.sol`ファイル内の`modifier onlyYou2()`及び`function gimmeLicense()`を変更してテストをPASSさせてください。
必要に応じて別途ヘルパー関数やmapping等も作成してください。


## 技術的な背景
- EVMにおけるネイティブトークンの取り扱いを学びましょう。（Q-5, Q-6でERC-20やERC-721として規格化されたトークンの取り扱いについても学びます）


## 初期ソースコード
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { IAnswerNativeToken } from "src/A4/interfaces/IAnswerNativeToken.sol";

contract AnswerNativeToken is IAnswerNativeToken {

    /**
        A-4. ネイティブトークン支払いを試す
     */

    modifier onlyYou2(LicenseCandidate memory candidate) {
        require(msg.sender == candidate.addr, "You are not the owner of this account.");
        _;
    }

    mapping(address => LicenseCandidate) public licenseHolders;

    function gimmeLicense(LicenseCandidate memory candidate)
        external payable override onlyYou2(candidate)
    {
        // Note: Fix me!
        require(candidate.score > 80, "You failed.");
        licenseHolders[msg.sender] = candidate;
    }
}
```


## FAQ
