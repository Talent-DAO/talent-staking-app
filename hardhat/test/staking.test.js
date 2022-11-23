const hre = require("hardhat");
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("Talent Staking Contract", function () {
  let stakingContract;

  // quick fix to let gas reporter fetch data from gas station & coinmarketcap
  before((done) => {
    setTimeout(done, 2000);
  });

  describe("Staking Contract", function () {
    it("should deploy staking contract", async function () {
      const [user] = await hre.ethers.getSigners();

      // Deploy the veTalent token contract
      const veToken = await hre.ethers.getContractFactory("veTalentToken");
      const veTokenContract = await veToken.deploy(user.address);

      // Deploy the Talent token contract
      const Token = await hre.ethers.getContractFactory("TalentToken");
      const TokenContract = await Token.deploy(user.address);

      // Deploy the Governor contract
      const Contract = await hre.ethers.getContractFactory("TalentStaking");
      stakingContract = await Contract.deploy(
        35948024, // polygon current block
        45948024, // polygon current block + 10000000
        TokenContract.address,
        veTokenContract.address,
        "0x1fD06f088c720bA3b7a3634a8F021Fdd485DcA42",
      );
    });
  });
});
