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
      accounts: ["5475e18a1db16e4daad5fa776088b58c970fa7a5a2de4de676843d03c38a8ef1"]
    },
    amoy: {
      url: "https://rpc-amoy.polygon.technology",
      accounts: ["5475e18a1db16e4daad5fa776088b58c970fa7a5a2de4de676843d03c38a8ef1"],
    },
    sepolia: {
      url: "https://sepolia.infura.io",
      accounts: ["5475e18a1db16e4daad5fa776088b58c970fa7a5a2de4de676843d03c38a8ef1"],
      
    }
  },
  etherscan: {
    apiKey: {
      polygonAmoy: "39WBAYHMEAEGZXFVDPGE79GX2BMWDSA34Q"
    }
  }
};