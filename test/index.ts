import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("test task", function () {
  it("test task1", async function () {
    const TestTask = await ethers.getContractFactory("TestTask");
    const task1 = await TestTask.deploy();
    await task1.deployed();

    expect(
      await task1.buildStringByTemplate("Result: {account}, {number}")
    ).to.equal("Result: 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c, 1250");

    expect(
      await task1.buildStringByTemplate("number: {number}, account: {account}")
    ).to.equal(
      "number: 1250, account: 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c"
    );

    expect(
      await task1.buildStringByTemplate("number: {number}, number: {number}")
    ).to.equal("number: 1250, number: 1250");

    expect(
      await task1.buildStringByTemplate(
        "account: {account}, account: {account}"
      )
    ).to.equal(
      "account: 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c, account: 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c"
    );
  });

  it("test task2", async function () {
    const TestTask = await ethers.getContractFactory("TestTask");
    const task1 = await TestTask.deploy();
    await task1.deployed();

    expect(
      await task1.trimMirroringChars(["apple", "electricity", "year"])
    ).to.equal("appectricitear");

    expect(
      await task1.trimMirroringChars(["ethereum", "museum", "must", "tree"])
    ).to.equal("etheresesree");
  });

  it("test task3", async function () {
    let admin: SignerWithAddress;
    [admin] = await ethers.getSigners();
    const TestTask3 = await ethers.getContractFactory("GasUsageOptimisation");
    const task3 = await TestTask3.deploy();
    await task3.deployed();
    console.log(admin.address);

    await task3.setLeadInvestorForARound(
      admin.address,
      2000,
      20,
      true,
      true,
      false
    );

    await task3.setLeadInvestorForARoundUpdated(
      admin.address,
      2000,
      20,
      true,
      true,
      false
    );
    let result1 = await task3.getInvestorDetailsByInvestmentRound(1);
    let result2 = await task3.getInvestorDetailsByInvestmentRoundUpdated(2);
    console.log("origin: ", result1);
    console.log("updated: ", result2);
  });
});
