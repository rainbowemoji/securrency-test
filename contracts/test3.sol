// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
pragma experimental ABIEncoderV2;

///             ///
///    Task 3   ///
///             ///

/**
 * Test task "Investor registration"
 * A gas usage optimization
 *
 * function "setLeadInvestorForARound" need to be optimized by a gas usage.
 * current transaction cost > 140 000
 * expected transaction cost < 55 000
 *
 * Required to save the interface.
 * All other modifications are allowed.
 **/
contract GasUsageOptimisation {
    uint256 public investmentRound = 1;

    // investment round => investors
    mapping(uint256 => address) investors;
    // investment round => deposited Amount
    mapping(uint256 => uint64) deposits;
    // investment round => age
    mapping(uint256 => uint8) investorsAge;
    // investment round => kyc
    mapping(uint256 => bool) kyc;
    // investment round => verification status
    mapping(uint256 => bool) verificationStatus;
    // investment round => US resident
    mapping(uint256 => bool) USResident;

    struct Investor {
        address investor;
        uint64 deposit;
        uint8 investorAge;
        bool kyc;
        bool verificationStatus;
        bool USResident;
    }

    mapping(uint256 => Investor) new_investors;

    /**
     * @notice Lead investor registration
     *
     * @param investor A lead investor address
     * @param depositAmount The amount deposited by a investor
     * @param age Investor age
     * @param kycStatus Investor KYC status
     * @param isVerifiedInverstor Investor verification status
     * @param isUSResident Resident status
     **/
    function setLeadInvestorForARound(
        address investor,
        uint64 depositAmount,
        uint8 age,
        bool kycStatus,
        bool isVerifiedInverstor,
        bool isUSResident
    ) external {
        require(investor != address(0x00), "Invalid investor address");
        require(
            depositAmount > 0,
            "A deposint amount should be more than zero"
        );
        require(age > 18, "The investor should be adult");

        investors[investmentRound] = investor;
        deposits[investmentRound] = depositAmount;
        investorsAge[investmentRound] = age;
        kyc[investmentRound] = kycStatus;
        verificationStatus[investmentRound] = isVerifiedInverstor;
        USResident[investmentRound] = isUSResident;

        investmentRound++;
    }

    function setLeadInvestorForARoundUpdated(
        address investor,
        uint64 depositAmount,
        uint8 age,
        bool kycStatus,
        bool isVerifiedInverstor,
        bool isUSResident
    ) external {
        require(investor != address(0x00), "Invalid investor address");
        require(
            depositAmount > 0,
            "A deposint amount should be more than zero"
        );
        require(age > 18, "The investor should be adult");

        Investor memory i = Investor(
            investor,
            depositAmount,
            age,
            kycStatus,
            isVerifiedInverstor,
            isUSResident
        );

        new_investors[investmentRound] = i;

        investmentRound++;
    }

    /**
     * @notice Returns a lead investor details
     **/
    function getInvestorDetailsByInvestmentRound(uint256 round)
        external
        view
        returns (
            address investor,
            uint64 depositAmount,
            uint8 age,
            bool kycStatus,
            bool isVerifiedInverstor,
            bool isUSResident
        )
    {
        return (
            investors[round],
            deposits[round],
            investorsAge[round],
            kyc[round],
            verificationStatus[round],
            USResident[round]
        );
    }

    function getInvestorDetailsByInvestmentRoundUpdated(uint256 round)
        external
        view
        returns (
            address investor,
            uint64 depositAmount,
            uint8 age,
            bool kycStatus,
            bool isVerifiedInverstor,
            bool isUSResident
        )
    {
        return (
            new_investors[round].investor,
            new_investors[round].deposit,
            new_investors[round].investorAge,
            new_investors[round].kyc,
            new_investors[round].verificationStatus,
            new_investors[round].USResident
        );
    }
}
