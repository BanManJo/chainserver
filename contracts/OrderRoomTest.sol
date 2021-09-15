pragma solidity ^0.5.2;

// OrderRoom 역할
contract OrderRoomTest {
  uint8 public state;
  uint256 public startTime;
  uint256 public finishTime;
  address public user1;
  address public user2;


  function() external payable {}

  // constructor(uint256 _num) public {
  //   num = _num;
  // }
  function matchRoom() external returns (bool){
    state = 2;
    user2 = tx.origin;
    
    return true;
  }

 
}
s