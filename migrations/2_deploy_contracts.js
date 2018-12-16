var MatchScoreBoard = artifacts.require("./MatchScoreBoard.sol");

module.exports = function(deployer) {
  deployer.deploy(MatchScoreBoard);
};
