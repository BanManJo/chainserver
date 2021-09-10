pragma solidity ^0.5.2;

contract A {
  uint256 public num = 10;

  function getNum() external view returns (uint256) {
    return num;
  }

  function() external payable {}
}
