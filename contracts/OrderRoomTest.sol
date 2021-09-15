pragma solidity ^0.5.2;

// OrderRoom 역할
contract OrderRoomTest {
  uint256 public num = 10;
  // uint8 public state;
  // uint256 public startTime;
  // uint256 public finishTime;
  // address public user1;
  // address public user2;

  event approve (string menu);
  
  function() external payable {}

  // constructor(uint256 _num) public {
  //   num = _num;
  // }

  function getNum() external view returns (uint256) {
    return num;
  }

  function approveOrder() external payable{
    tx.origin.transfer(address(this).balance); 
    //방에 들어있는 돈들 출금
    
    // this.state = 3;
    // this.user1 = "";
    // this.user2 = "";
    // this.stratTime = 0;
    // this.finishTime = 0;

    //여기서 이제 event 날린다?     
  } 
}
