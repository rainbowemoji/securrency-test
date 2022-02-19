// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
pragma experimental ABIEncoderV2;

import "./AddressChecksumUtils.sol";

contract TestTask {
    ///             ///
    ///    Task 1   ///
    ///             ///

    /**
     * @dev Test task condition:
     * @dev by a condition, a function getString accepts some template
     * @dev and we agreed that {account} in the template must be
     * @dev replaced by an "account" variable from the function,
     * @dev "{number}" must be replaced by a "number" variable
     * @dev Example
     * @dev template = "Example: {account}, {number}"
     * @dev result = "Example: 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c, 1250"
     *
     * @notice You can see more examples in a tests.
     *
     * @return result Updated template by a task condition
     */

    // view -> pure to do
    function buildStringByTemplate(string calldata template)
        external
        pure
        returns (string memory)
    {
        // 0x4549502d3535
        address account = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
        uint256 number = 1250;
        string memory result;
        /**
         * Write your code here
         * Try to do with the lowest gas consumption.
         * If you will use some libraries or ready solutions,
         * please add links in the "notice" comments section before the function.
         */
        bytes memory bTemplate = bytes(template);
        string[] memory plains = new string[](10);
        string[] memory variables = new string[](10);

        bytes memory plain;
        bytes memory variable;
        bool v;
        uint256 count;
        for (uint256 i = 0; i < bTemplate.length; i++) {
            // in case of {
            if (bTemplate[i] == 0x7b) {
                v = true;
                continue;
            }
            // in case of }
            if (bTemplate[i] == 0x7d) {
                v = false;

                plains[count] = (string(plain));
                variables[count] = (string(variable));
                plain = "";
                variable = "";
                count++;
                continue;
            }
            if (v) variable = bytes.concat(variable, bTemplate[i]);
            else plain = bytes.concat(plain, bTemplate[i]);
        }
        for (uint256 i = 0; i < count; i++) {
            if (compare(variables[i], "number")) {
                result = concatenate(result, plains[i]);
                result = concatenate(result, uint2str(number));
            }
            if (compare(variables[i], "account")) {
                result = concatenate(result, plains[i]);
                string memory checksumAddress = AddressChecksumUtils
                    .getChecksum(account);
                checksumAddress = concatenate("0x", checksumAddress);
                result = concatenate(result, checksumAddress);
            }
        }
        return result;
    }

    function compare(string memory a, string memory b)
        public
        pure
        returns (bool)
    {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }

    function concatenate(string memory a, string memory b)
        public
        pure
        returns (string memory)
    {
        return string(abi.encodePacked(a, b));
    }

    function uint2str(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    function addressToString(address _addr)
        public
        pure
        returns (string memory)
    {
        bytes memory s = new bytes(40);
        for (uint256 i = 0; i < 20; i++) {
            bytes1 b = bytes1(
                uint8(uint256(uint160(_addr)) / (2**(8 * (19 - i))))
            );
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2 * i] = char(hi);
            s[2 * i + 1] = char(lo);
        }
        return string(abi.encodePacked("0x", s));
    }

    function char(bytes1 b) public pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }

    ///             ///
    ///    Task 2   ///
    ///             ///

    /**
     * @dev Test task condition 2:
     *
     * @dev Write a function which takes an array of strings as input and outputs
     * @dev with one concatenated string. Function also should trim mirroring characters
     * @dev of each two consecutive array string elements. In two consecutive string elements
     * @dev "apple" and "electricity", mirroring characters are considered to be "le" and "el"
     * @dev and as a result these characters should be trimmed from both string elements,
     * @dev and concatenated string should be returned by the function. You may assume that
     * @dev array will consist of at least of one element, each element won't be an empty string.
     * @dev You may also assume that each element will contain only ascii characters.
     *
     * @dev Example 1
     * @dev input:  "apple", "electricity", "year"
     * @dev output: "appectricitear"
     *
     * @notice You can see more examples in a Task2Test smart contract.
     *
     * @return result Minimized string by a task condition
     */
    function trimMirroringChars(string[] memory data)
        public
        pure
        returns (string memory)
    {
        string memory result;

        /**
         * Write your code here
         * Try to do with the lowest gas consumption.
         * If you will use some libraries or ready solutions,
         * please add links in the "notice" comments section before the function.
         */
        result = data[0];
        for (uint256 i = 1; i < data.length; i++) {
            result = mirroring(result, data[i]);
        }
        return result;
    }

    function mirroring(string memory a, string memory b)
        public
        pure
        returns (string memory)
    {
        bytes memory first = bytes(a);
        uint256 lengthOfFirst = first.length;
        bytes memory second = bytes(b);
        uint256 lengthOfSecond = second.length;
        uint256 count = 0;
        while (first[lengthOfFirst - count - 1] == second[count]) {
            count++;
        }
        bytes memory temp;
        for (uint256 i = 0; i < lengthOfFirst - count; i++)
            temp = bytes.concat(temp, first[i]);
        for (uint256 i = count; i < lengthOfSecond; i++)
            temp = bytes.concat(temp, second[i]);
        return string(temp);
    }
}
