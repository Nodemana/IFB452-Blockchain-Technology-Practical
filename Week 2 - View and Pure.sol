// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract ViewAndPure {
    uint public x = 1;
    // Can not modify state variables. doesnt consume gas when called externally.
    // Promise not to modify the state.
    function addToX(uint y) public view returns (uint) {
        return x + y;
    }
    // Can not even read state variables, it cant see x and it also can not modify x.
    // Promise not to modify or read from the state.
    function add(uint i, uint j) public pure returns (uint) {
        return i + j;
    }
}
