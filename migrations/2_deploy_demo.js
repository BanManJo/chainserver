const Demo = artifacts.require("Demo");
const OrderRoom = artifacts.require("OrderRoom");
const ChickenHouse = artifacts.require("ChickenHouse");

module.exports = function(deployer){
    deployer.deploy(Demo);
    deployer.deploy(OrderRoom);
    deployer.deploy(ChickenHouse);
};