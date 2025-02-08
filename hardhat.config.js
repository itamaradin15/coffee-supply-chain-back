require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
const { ethers } = require("ethers");

module.exports = {
  solidity: {
    version: "0.8.28",
    settings: {
      viaIR: true,
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    zkEVM: {
      url: "https://rpc.cardona.zkevm-rpc.com", 
      accounts: ["af03f5ad55b23a5a07f19d7693a7c21e2cb180b4ccab3ca258e76cf3a15d9e43"]
    },
    amoy: {
      url: "https://rpc-amoy.polygon.technology",
      accounts: ["af03f5ad55b23a5a07f19d7693a7c21e2cb180b4ccab3ca258e76cf3a15d9e43"],
    },
    sepolia: {
      url: "https://sepolia.infura.io",
      accounts: ["af03f5ad55b23a5a07f19d7693a7c21e2cb180b4ccab3ca258e76cf3a15d9e43"],
    }
  },
  etherscan: {
    apiKey: {
      polygonAmoy: "39WBAYHMEAEGZXFVDPGE79GX2BMWDSA34Q"
    }
  }
};