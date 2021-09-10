pragma solidity ^0.5.2;

// OrderRoom 역할
contract OrderRoomTest {
  uint256 public num = 10;

  function() external payable {}

  // constructor(uint256 _num) public {
  //   num = _num;
  // }

  function getNum() external view returns (uint256) {
    return num;
  }
}
