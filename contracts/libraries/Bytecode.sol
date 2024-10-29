/**
 * @title
 * @author Raj Mazumder <rajmazumder27.08.2001@gmail.com>
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Bytecode {
    /**
     * @notice Generate a creation code that results on a contract with `_code` as bytecode
     * @param _code The returning value of the resulting `creationCode`
     * @return creationCode (constructor) for new contract
     */
    function getCreationCodeFor(
        bytes memory _code
    ) internal pure returns (bytes memory creationCode) {
        /// @dev Returns the creation code.
        creationCode = abi.encodePacked(
            hex"63",
            uint32(_code.length),
            hex"80_60_0E_60_00_39_60_00_F3",
            _code
        );
    }
}
