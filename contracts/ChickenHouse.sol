pragma solidity ^0.5.2;
// solidity version
contract ChickenHouse {

struct Store {
        string storeName;
        address ceoAccount;
        string location;
        string menu;
        uint countRoom;
        uint256 cookingTime;
        uint8 finishType;
}

Store[] public stores;

function StoreRegistration(string memory _storeName, address _ceoAccount, 
    string memory _location, string memory _menu, uint _countRoom, uint256 _cookingTime, uint8 _finishType) public returns(bool) {
    Store memory newStore;
    newStore.storeName = _storeName;
    newStore.ceoAccount = _ceoAccount;
    newStore.location = _location;
    newStore.menu = _menu;
    newStore.countRoom = _countRoom;
    newStore.cookingTime = _cookingTime;
    newStore.finishType = _finishType;

    stores.push(newStore);
      
    return true;
    }
    
function getStoresById(uint _storeId) public view returns(
        string memory storeName,
        address ceoAccount,
        string memory location,
        string memory menu,
        uint countRoom,
        uint256 cookingTime,
        uint8 finishType) 
        {

        Store memory store = stores[_storeId];
        return (
            store.storeName,
            store.ceoAccount,
            store.location,
            store.menu,
            store.countRoom,
            store.cookingTime,
            store.finishType);
    }
}