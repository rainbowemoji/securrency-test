// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
pragma experimental ABIEncoderV2;

///             ///
///    Task 4   ///
///             ///

/**
 * This contract should compile
 * A stack overflow issue
 */

// contractDealDate, statusDate, initialExchangeDate, maturityDate, purchaseDate, capitalizationEndDate, cycleAnchorDateOfInterestPayment, cycleAnchorDateOfRateReset, cycleAnchorDateOfScalingIndex, cycleAnchorDateOfFee
contract StackOverflow {
    function createAsset(
        address currency,
        address settlementCurrency,
        bytes32 marketObjectCodeRateReset,
        uint256[] memory data,
        int256 notionalPrincipal,
        int256 nominalInterestRate,
        int256 accruedInterest,
        int256 rateMultiplier
    ) external {
        require(currency != address(0x00), "Invalid currency address");
        require(
            settlementCurrency != address(0x00),
            "Invalid settlement currency address"
        );
        require(
            marketObjectCodeRateReset != bytes32(0x00),
            "Code rate request is required"
        );
        require(data.length == 10, "invalid Data");
        require(data[0] != 0, "Contract deal date can't be empty");
        require(data[1] != 0, "statusDate can't be empty");
        require(data[2] != 0, "initialExchangeDate can't be empty");
        require(data[3] != 0, "maturityDate can't be empty");
        require(data[4] != 0, "purchaseDate can't be empty");
        require(data[5] != 0, "capitalizationEndDate can't be empty");
        require(
            data[6] != 0,
            "cycleAnchorDateOfInterestPayment can't be empty"
        );
        require(data[8] != 0, "cycleAnchorDateOfScalingIndex can't be empty");
        require(data[9] != 0, "cycleAnchorDateOfFee can't be empty");
        require(
            notionalPrincipal != 0,
            "notionalPrincipalnotionalPrincipal can't be empty"
        );
        require(nominalInterestRate != 0, "nominalInterestRate can't be empty");
        require(accruedInterest != 0, "accruedInterest can't be empty");
        require(rateMultiplier != 0, "rateMultiplier can't be empty");

        saveDetailsToStorage(
            currency,
            settlementCurrency,
            marketObjectCodeRateReset,
            notionalPrincipal,
            nominalInterestRate,
            accruedInterest,
            rateMultiplier
        );

        saveDatesToStorage(
            data[0],
            data[1],
            data[2],
            data[3],
            data[4],
            data[5],
            data[6],
            data[7],
            data[8],
            data[9]
        );
    }

    function saveDetailsToStorage(
        address currency,
        address settlementCurrency,
        bytes32 marketObjectCodeRateReset,
        int256 notionalPrincipal,
        int256 nominalInterestRate,
        int256 accruedInterest,
        int256 rateMultiplier
    ) internal {
        // Mock function
        // skip implementation
    }

    function saveDatesToStorage(
        uint256 contractDealDate,
        uint256 statusDate,
        uint256 initialExchangeDate,
        uint256 maturityDate,
        uint256 purchaseDate,
        uint256 capitalizationEndDate,
        uint256 cycleAnchorDateOfInterestPayment,
        uint256 cycleAnchorDateOfRateReset,
        uint256 cycleAnchorDateOfScalingIndex,
        uint256 cycleAnchorDateOfFee
    ) internal {
        // Mock function
        // skip implementation
    }
}
