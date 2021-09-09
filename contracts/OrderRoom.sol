pragma solidity >=0.5.2;

contract OrderRoom {
  
  // event pending(uint startTime, uint state, address user2);
  struct Menu {
    uint16 price;
    string chickenName;
  }

  struct OrderRoom {
    uint256 roomNumber;
    string storeName;
    address user1;
    address user2;
    Menu menu;
    uint256 startTime;
    uint256 finishTime;
    uint8 state;
  }

  OrderRoom[] private orderRooms;

  function createRoom(
    string memory _storeName,
    //     Menu memory _menu,
    string memory _chickenName,
    uint16 _price,
    uint256 _finishTime
  ) payable public returns (bool) {
    OrderRoom memory newRoom;
    newRoom.roomNumber = orderRooms.length -1;
    newRoom.storeName = _storeName;
    newRoom.user1 = msg.sender;
    Menu memory menu;
    menu.chickenName = _chickenName;
    menu.price = _price;
    newRoom.menu = menu;
    newRoom.startTime = block.timestamp; //now 써도되는지 확인해야함 
    newRoom.finishTime = block.timestamp + _finishTime ;
    newRoom.state = 1;

    orderRooms.push(newRoom);

    return true;
  }

  function getRoomById(uint256 _roomId)
    public
    view
    returns (
      uint256 roomNumber,
      string memory storeName,
      address user1,
      address user2,
      uint16 price,
      string memory chickenName,
      uint256 startTime,
      uint256 finishTime,
      uint256 state
    )
  {
    OrderRoom memory orderRoom = orderRooms[_roomId];

    return (
      orderRoom.roomNumber,
      orderRoom.storeName,
      orderRoom.user1,
      orderRoom.user2,
      orderRoom.menu.price,
      orderRoom.menu.chickenName,
      orderRoom.startTime,
      orderRoom.finishTime,
      orderRoom.state
    );
  }

  function orderComplete(uint _roomId) payable public {
    //해당 방에 해당하는 주문버튼 클릭 -> _roomId 값을 받아온다?? 어디서? -> 프론트 쪽에서 roomId 인자 받아온다.
    //모든 주문 버튼에는 orderComplete가 걸려있다.
    //누름과 동시에 정해진 돈이 보내지고 함수 실행 
    //보낸 돈이 메뉴 가격의 1/2보다 큰지 확인
    // require(orderRooms[_roomId].state == 1); //방의 상태 확인
    // require(msg.value == orderRooms[_roomId].menu.price / 2); // 맞게 돈을 송금했는지 확인
    // require(orderRooms[_roomId].finishTime - orderRooms[_roomId].startTime > 0); //유효시간안에 주문하였는지 확인

    // 주문한 방의 정보 변경 시작시간, 상태, user2 주소, 
    
    orderRooms[_roomId].startTime = block.timestamp;
    orderRooms[_roomId].state = 2;
    orderRooms[_roomId].user2 = msg.sender;

    // pending(orderRooms[_roomId].startTime, orderRooms[_roomId].state, orderRooms[_roomId].user);


}
  function ownerFetch(uint _roomId, uint256 state ) payable public {
    // owner 주소 
                              // require를 사용해서 rooId Store 주인이 owner인지 확인해야한다.
                              //컨트랙트에서 owner 계좌로 송금을 한다.
                              // state 3 으로 변경 .
    msg.sender.transfer(address(this).balance);

    

}
    
}
