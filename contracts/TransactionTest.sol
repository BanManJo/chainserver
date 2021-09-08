pragma solidity ^0.5.2;

// solidity version

contract TransactionTest {
    address sender;

    // function : persona -> contract Transaction!
    function sendToContract() public payable {
        //
        sender = msg.sender;
    }

    function getSender() public view returns (address) {
        return sender;
    }

    function getBalanceOf() public view returns (uint256) {
        return address(this).balance;
    }
}
