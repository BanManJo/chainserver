const chicken = artifacts.require("Chicken");

module.exports = function (deployer) {
  deployer.deploy(chicken);
};
