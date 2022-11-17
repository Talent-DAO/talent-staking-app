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

  const talentDaoTokenContract = await deploy("TalentDaoToken", {
    from: deployer,
    args: ["0x3f15B8c6F9939879Cb030D6dd935348E57109637"],
    log: true,
  });

  const veTalentDaoTokenContract = await deploy("veTalentToken", {
    from: deployer,
    args: ["0x3f15B8c6F9939879Cb030D6dd935348E57109637"],
    log: true,
  });
  
  const stakingContract = await deploy("TalentStaking", {
    from: deployer,
    args: [
      1,
      100000,
      talentDaoTokenContract.address,
      veTalentDaoTokenContract.address,
    ],
    log: true,
  });

  // You don't want to verify on localhost
  try {
    if (chainId !== localChainId) {
      await run("verify:verify", {
        address: talentDAOTokenContract.address,
        contract: "contracts/TalentDaoToken.sol:TalentDaoToken",
        constructorArguments: ["0x3f15B8c6F9939879Cb030D6dd935348E57109637"],
      });
      await run("verify:verify", {
        address: veTalentDaoTokenContract.address,
        contract: "contracts/veTalentDaoToken.sol:veTalentDaoToken",
        constructorArguments: ["0x3f15B8c6F9939879Cb030D6dd935348E57109637"],
      });
      await run("verify:verify", {
        address: stakingContract.address,
        contract: "contracts/TalentStaking.sol:TalentStaking",
        constructorArguments: [
          1,
          100000,
          talentDaoTokenContract.address,
          veTalentDaoTokenContract.address,
        ],
      });
    }
  } catch (error) {
    console.error(error);
  }
};
module.exports.tags = ["TalentDaoToken", "veTalentToken", "TalentStaking"];
