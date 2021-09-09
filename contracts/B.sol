pragma solidity ^0.5.2;

import "./A.sol";

contract B {
  A[] a_s;

  address public addr;

  function makeA() public {
    A a = new A();
    a_s.push(a);
  }

  function getABalanceIndexOf(uint256 index)
    public
    view
    returns (uint256, address)
  {
    A a = a_s[index];
    return (address(a).balance, address(a));
  }

  function getBalance() public payable returns (uint256) {
    return address(this).balance;
  }

  function transferTo(address payable targetAddr) public payable {
    targetAddr.transfer(10);
  }
}
