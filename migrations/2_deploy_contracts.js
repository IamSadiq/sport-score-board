var SportScoreBoard = artifacts.require("./SportScoreBoard.sol");

module.exports = function(deployer) {
  deployer.deploy(SportScoreBoard);
};
