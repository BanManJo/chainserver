pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;
import "./OrderRoomTest.sol";

// ChickenHouse 역할
contract ChickenHouseTest {
  OrderRoomTest[] orderRooms;

  string storeName;
  address owner;
  uint8 onOff;
  string latitude;
  string longitude;
  Menu menu;

  struct Menu {
    string chickenName;
    uint256 price;
  }
  Menu[] public menus;
 constructor (string memory _storeName) public {
          storeName = _storeName;
      }
  // 메뉴(치킨, 가격)등록
  function registerChickenHouse(string[] memory _chickenNames, uint256[] memory _prices) public returns(uint256) {
       require(_chickenNames.length == _prices.length);
        
        for(uint i= 0;i<_chickenNames.length;i++){
            menus.push( Menu(_chickenNames[i], _prices[i]) );
        }
        return menus.length;    
      }
      
    
  // 주문방 만들기
  function createRoom(uint256 _price, uint256 _finish, string memory _chickenName) public payable {
    // room 생성!!!!
    OrderRoomTest orderRoom = new OrderRoomTest(_price, _finish, _chickenName);
    orderRooms.push(orderRoom);
    address(uint160(address(orderRoom))).transfer(address(this).balance);
  }

  function() external payable {}
      
   function matchRoom(uint256 _roomIndex) public payable {
    // 바로 할당을 위한 생성
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
     address(uint160(address(orderRoom))).transfer(address(this).balance);
    orderRoom.matchRoom();
  }
  
  function approveOrder(uint256 _roomIndex) public {
    OrderRoomTest orderRoom = orderRooms[_roomIndex]; // 해당 치킨하우스에 해당하는 orderRoom을 찾는다.
    // require (tx.origin == owner);  
    orderRoom.approveOrder();
  }

  function getBalance(uint256 _roomIndex) public view returns (uint256) {
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
    return address(orderRoom).balance;

  }

   function getStateRoom(uint256 _roomIndex) public view returns (uint256) {
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
    return orderRoom.getStateRoom();

  }


}
