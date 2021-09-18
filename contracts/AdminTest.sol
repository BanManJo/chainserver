pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;

import "./ChickenHouseTest.sol";

// Admin 역할
contract AdminTest {
    ChickenHouseTest[] chickenHouses;

    function() external payable {}

    mapping(string => uint256) storeIndexs;

    // ChickenHouse (메뉴와함께) 등록
    function registerChickenHouse(
        string memory _storeName,
        string memory _latitude,
        string memory _longitude,
        string[] memory _chickenNames,
        uint256[] memory _prices
    ) public {
        ChickenHouseTest chickenHouse = new ChickenHouseTest(
            _storeName,
            _latitude,
            _longitude
        );
        chickenHouse.registerChickenHouse(_chickenNames, _prices);
        storeIndexs[_storeName] = (chickenHouses.push(chickenHouse)) - 1;
    }

    // 방만들기 함수
    function createRoom(
        string memory _storeName,
        uint256 _price,
        uint256 _finish,
        string memory _chickenName
    ) public payable {
        // chickenHouse를 찾자 storeName 으로!
        ChickenHouseTest chickenHouse = chickenHouses[storeIndexs[_storeName]];
        address(uint160(address(chickenHouse))).transfer(msg.value); // msg.value : 사용자가 전달한 이더
        uint256 _valueToSend = msg.value;
        chickenHouse.createRoom(_price, _finish, _chickenName, _valueToSend);
    }

    // 방 Match 함수
    function matchRoom(string memory _storeName, uint256 _roomIndex)
        public
        payable
    {
        // 바로 할당을 위한 생성
        ChickenHouseTest chickenHouse = chickenHouses[storeIndexs[_storeName]];
        address(uint160(address(chickenHouse))).transfer(msg.value);
        chickenHouse.matchRoom(_roomIndex);
    }

    //가게 주인이 돈받는 함수
    function approveOrder(string memory _storeName, uint256 _roomIndex) public {
        //여기는 해당되는 방을 찾기위해 _storeName으로 치킨집을 찾고 _roomNumber로 해당되는 방을 찾는다
        ChickenHouseTest chickenHouse = chickenHouses[storeIndexs[_storeName]];
        chickenHouse.approveOrder(_roomIndex);
    }

    function getBalanceOfRoom(uint256 _storeIndex, uint256 _roomIndex)
        public
        view
        returns (uint256)
    {
        ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
        return chickenHouse.getBalance(_roomIndex);
    }

    function getStateRoom(uint256 _storeIndex, uint256 _roomIndex)
        public
        view
        returns (uint256)
    {
        ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
        return chickenHouse.getStateRoom(_roomIndex);
    }

    // 2. 원하는 치킨집의 정보를 가져온다?
    function getChickenHouse(string memory _storeName)
        public
        view
        returns (
            string memory storeName,
            string memory latitude,
            string memory longitude,
            uint8 closed
        )
    {
        ChickenHouseTest chickenHouse = chickenHouses[storeIndexs[_storeName]];
        return chickenHouse.getChickenHouse();
    }

    // 2.5 원하는 치킨집의 메뉴를 가져온다?
    function getStoreMenu(string memory _storeName)
        public
        view
        returns (string[] memory, uint256[] memory)
    {
        ChickenHouseTest chickenHouse = chickenHouses[storeIndexs[_storeName]];
        return chickenHouse.getStoreMenu();
    }

    // 3. 원하는 주문방의 정보를 가져온다?
    function getRoomInfo(string memory _storeName, uint256 _roomIndex)
        public
        view
        returns (
            string memory,
            uint256,
            uint8,
            address
        )
    {
        ChickenHouseTest chickenHouse = chickenHouses[storeIndexs[_storeName]];
        return chickenHouse.getRoomInfo(_roomIndex);
    }
}
