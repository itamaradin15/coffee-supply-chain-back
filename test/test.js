const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CoffeeSupplyChain", function () {
  it("Should create a new lot and add steps", async function () {
    const CoffeeSupplyChain = await ethers.getContractFactory("CoffeeSupplyChain");
    const coffeeSupplyChain = await CoffeeSupplyChain.deploy();
    await coffeeSupplyChain.deployed();

    await coffeeSupplyChain.createLot();
    await coffeeSupplyChain.addStep(1, "Siembra");

    const lot = await coffeeSupplyChain.getLot(1);
    expect(lot.steps[0]).to.equal("Siembra");
  });
});