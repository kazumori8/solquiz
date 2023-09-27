// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

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
      mscore[msg.sender] = _score;
      mscore[msg.sender].score *= 2;
    }
}

// interface QuestionStructAndStorageInterface{
//     function submitScoreWithCheat() external;
// }