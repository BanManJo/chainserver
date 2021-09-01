pragma solidity ^0.5.2;
// solidity version

contract Demo { // contract name is Demo
    string public constant name = "DEMO token";
    string public constant symbol = "DEMO";
    uint public constant decimals = 18;
    uint public constant INITIAL_SUPPLY = 1000 * 10 ** decimals;
    string constant test = "You can not see this";
}