const hre = require("hardhat");
const fs = require("fs");
const path = require("path");

async function cleanArtifacts() {
  const artifactsPath = path.join(__dirname, "../artifacts");
  if (fs.existsSync(artifactsPath)) {
    fs.rmSync(artifactsPath, { recursive: true, force: true });
    console.log("Artifacts folder cleaned.");
  }
}

async function main() {
  // Clean the artifacts folder
  await cleanArtifacts();

  // Compile the smart contracts
  console.log("Compiling contracts...");
  await hre.run("compile");

  // Deploy the smart contract
  console.log("Deploying the CoffeeSupplyChain contract...");
  const CoffeeSupplyChain = await hre.ethers.getContractFactory("CoffeeSupplyChain");
  const coffeeSupplyChain = await CoffeeSupplyChain.deploy();

  await coffeeSupplyChain.deployed();
  console.log("CoffeeSupplyChain deployed to:", coffeeSupplyChain.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
