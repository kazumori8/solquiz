  # Q-2. 構造体/ストレージアクセスを試す


## 手順
[QuestionStructAndStorage.t.sol](../../test/Q1/QuestionStructAndStorage.t.sol)ファイル内にあるテスト関数`test_Q2_StructAndStorage()`のシナリオをよく読み、
[AnswerStructAndStorage.sol](./AnswerStructAndStorage.sol)ファイル内の`submitScoreWithCheat()`を変更してテストをPASSさせてください。
必要に応じて別途ヘルパー関数やmapping等も作成してください。


## 初期ソースコード
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {SAnswerStructAndStorage} from "src/A2/interfaces/SAnswerStructAndStorage.sol";

contract AnswerStructAndStorage is SAnswerStructAndStorage {
    /**
        A-2. 構造体/ストレージアクセスを試す
    */
    mapping(address=> YourScore) public mscore;

    function scores(address _key) public view returns (string memory, string memory, uint256) {
      return (mscore[_key].name, mscore[_key].description,mscore[_key].score);
    }
    
    function submitScoreWithCheat(YourScore memory _score) public {
      // Note: Fill me!
    }
}
```


## FAQ
[FAQ日本語版](./docs/FAQ/FAQ.ja.md)
