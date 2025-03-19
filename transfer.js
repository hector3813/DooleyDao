const hre = require("hardhat");

async function main() {
  const [owner] = await hre.ethers.getSigners();

  // Replace with your deployed token address
  const token = await hre.ethers.getContractAt("DAOToken", "0x043Def5fAeDFA97f35950cA4bC453FbFA628f7A7");

  console.log("Owner address:", owner.address);
  console.log("Owner balance:", (await token.balanceOf(owner.address)).toString());

  // Replace this with the recipient's wallet address
  const recipient = "0xA448038Bfd226382feCC5018Fa5366E9D5fbAb39";
  
  // Transfer 100 tokens (adjust decimals if needed)
  const tx = await token.transfer(recipient, hre.ethers.parseUnits("100", 18));
  await tx.wait();

  console.log(`✅ Successfully transferred 100 tokens to ${recipient}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
