// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { IAnswerConditionalCheck } from "src/A3/interfaces/IAnswerConditionalCheck.sol";
import { SAnswerConditionalCheck } from "src/A3/interfaces/SAnswerConditionalCheck.sol";

contract AnswerConditionalCheck is IAnswerConditionalCheck, SAnswerConditionalCheck {

    /**
        A-3. 制御構文(if, for, require, revert), modifier, アクセス制御, オーナー権限を試す
     */

    function borrowMore(Person memory person, uint256 amount)
        external view override onlyYou(person) returns (bool)
    {
        if(person.debt != 0){
            uint collateral_rate = 100 * person.collateral / person.debt;
            require(collateral_rate > 110,"Collateralization ratio is already too high");
        }            
        uint new_collateral_rate = 100 * person.collateral / (person.debt + amount);
        require(new_collateral_rate > 110, "Collateralization ratio must be more than 110%");
        return true;
    }

    modifier onlyYou(Person memory person){
        // Note: Fill me!
        require(msg.sender == person.addr,"You are not the owner of this account."); 
        _;
    }
}
