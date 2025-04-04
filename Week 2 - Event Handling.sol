// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Event {
    // Event declaration
    // Up to 3 parameters can be indexed.
    // Indexed parameters helps you filter the logs by the indexed parameter
    event Log(address indexed sender, string message);
    event AnotherLog(); // Events are stored in the transaction logs. But not accessible by the smart contract itself.

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog(); // Emits are actually logged in the contracts log atribute.
    }
}
