# Q-3. 制御構文(if, for, require, revert), modifier, アクセス制御, オーナー権限を試す


## 手順
[QuestionConditionalCheck.t.sol](../../test/Q3/QuestionConditionalCheck.t.sol)ファイル内にあるテスト関数`test_Q3_ConditionalCheck()`のシナリオをよく読み、
[AnswerConditionalCheck.sol](./AnswerConditionalCheck.sol)ファイル内の`modifier onlyYou()`及び`function borrowMore()`を変更してテストをPASSさせてください。
必要に応じて別途ヘルパー関数やmapping等も作成してください。


## 技術的な背景
- パブリックチェーン上のスマートコントラクトは誰でもアクセス可能となります。modifierやvisibility、mutability等を利用して慎重に権限を設定しましょう。


## 初期ソースコード
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { IAnswerConditionalCheck } from "src/A3/interfaces/IAnswerConditionalCheck.sol";

contract AnswerConditionalCheck is IAnswerConditionalCheck {

    /**
        A-3. 制御構文(if, for, require, revert), modifier, アクセス制御, オーナー権限を試す
     */

    modifier onlyYou(Person memory person) {
        // Note: Fill me!
        _;
    }

    function borrowMore(Person memory person, uint256 amount)
        external override onlyYou(person) returns (bool)
    {
        // Note: Fill me!
    }
}
```


## FAQ
[FAQ日本語版](./docs/FAQ/FAQ.ja.md)
