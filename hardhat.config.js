require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: process.env.ALCHEMY_SEPOLIA_RPC, // Your Sepolia RPC URL from Alchemy
      accounts: [process.env.PRIVATE_KEY],  // Your wallet private key
    },
  },
};
