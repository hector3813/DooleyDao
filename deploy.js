const hre = require("hardhat");

async function main() {
  console.log("Deploying contracts to Sepolia...");

  // Deploy Governance Token
  const DAOToken = await hre.ethers.getContractFactory("DAOToken");
  const daoToken = await DAOToken.deploy();
  await daoToken.deployed();
  console.log(`✅ DAOToken deployed at: ${daoToken.address}`);

  // Deploy DAO Contract
  const DAO = await hre.ethers.getContractFactory("DAO");
  const dao = await DAO.deploy(daoToken.address);
  await dao.deployed();
  console.log(`✅ DAO deployed at: ${dao.address}`);

  // Deploy Treasury
  const Treasury = await hre.ethers.getContractFactory("Treasury");
  const treasury = await Treasury.deploy(dao.address);
  await treasury.deployed();
  console.log(`✅ Treasury deployed at: ${treasury.address}`);

  console.log("🎉 Deployment successful!");
}

// Run the deploy script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("🚨 Deployment failed!", error);
    process.exit(1);
  });
