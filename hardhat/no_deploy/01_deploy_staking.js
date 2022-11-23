// deploy/00_deploy_tokens_manager.js

const { ethers, run } = require("hardhat");

const localChainId = "31337";

// const sleep = (ms) =>
//   new Promise((r) =>
//     setTimeout(() => {
//       console.log(`waited for ${(ms / 1000).toFixed(3)} seconds`);
//       r();
//     }, ms)
//   );

module.exports = async ({ getNamedAccounts, deployments, getChainId }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = await getChainId();

  const TalentToken = await ethers.getContractFactory("TalentToken");
  const veTalentToken = await ethers.getContractFactory("veTalentToken");

  await deploy("TalentStaking", {
    from: deployer,
    constructorArguments: [
      35948024, // polygon current block
      45948024, // polygon current block + 10000000
      TalentToken.address,
      veTalentToken.address,
      "0x3f15B8c6F9939879Cb030D6dd935348E57109637",
    ],
    log: true,
  });

  // Getting a previously deployed contract
  const TalentStakingContract = await ethers.getContract(
    "TalentStaking",
    deployer,
  );

  // You can also Verify your contracts with Etherscan here...
  // You don't want to verify on localhost
  try {
    if (chainId !== localChainId) {
      await run("verify:verify", {
        address: TalentStakingContract.address,
        contract: "contracts/TalentStaking.sol:TalentStaking",
        constructorArguments: [
          35948024, // polygon current block
          45948024, // polygon current block + 10000000
          TalentToken.address,
          veTalentToken.address,
          "0x3f15B8c6F9939879Cb030D6dd935348E57109637",
        ],
      });
    }
  } catch (error) {
    console.error(error);
  }
};

module.exports.tags = ["TalentStaking"];
