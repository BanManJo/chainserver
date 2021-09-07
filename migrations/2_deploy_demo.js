const Demo2 = artifacts.require("Demo");

module.exports = function(deployer){
    deployer.deploy(Demo2);
};

const OrderRoom2 = artifacts.require("OrderRoom");

module.exports = function(deployer){
    deployer.deploy(OrderRoom2);
};

