// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {GomokuPlayersPerson} from "src/GomokuA/interfaces/GomokuPlayersPerson.sol";

interface IQuestionGomokuPlayersPerson {
    struct TestVars {
        GomokuPlayersPerson.Person alice;
        GomokuPlayersPerson.Person bob;
        GomokuPlayersPerson.Person carl;
    }
}
