/**
 * @title
 * @author Raj Mazumder <rajmazumder27.08.2001@gmail.com>
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

/// @notice Library imports
import {Address} from "@openzeppelin/contracts/utils/Address.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";

/// @notice Custom errors.
/// @dev The deployment failed.
error FailedToDeployBytecode();

/// @dev The ETH balance of the account is not enough to perform the operation.
error InsufficientBalance(uint256 balance, uint256 needed);

contract SmartContractWallet is Ownable2Step {
    /// @notice Initialize the contract with deployer as Contract/Wallet owner.
    constructor() Ownable(_msgSender()) {}

    /** @notice Events */
    /**
     * @notice `ContractDeployed` emitted after successful contract deployment.
     * @param deployedAddress The deployed contract address.
     */
    event ContractDeployed(address deployedAddress);

    /**
     * @notice `ETHTransferred` emitted after successful ETH transfer to `recipient`.
     * @param recipient The ETH receiver address.
     * @param amount The amount of ETH would be transferred.
     */
    event ETHTransferred(address recipient, uint256 amount);

    /**
     * @notice Execute a static encoded call on an external contract. (For estimating gas)
     * - Only owners can execute the function.
     *
     * @param target The address of the external contract to execute the call on.
     * @param data The bytes-encoded parameters and signature (if any) of the call.
     *
     * @return returnValue The return value from executing the call, if it was successful.
     * Otherwise, revert with `Errors.FailedCall` or another error as per EVM rules.
     */
    function executeStaticEncodedCall(
        address target,
        bytes memory data
    ) public view onlyOwner returns (bytes memory returnValue) {
        /// Execute and returns the expected return value from the call.
        returnValue = Address.functionStaticCall(target, data);
    }

    /**
     * @notice Transfer ETH from this wallet to `recipient` address.
     * - Wallet balance must be greater than or equal to `amount`.
     * - Only owners can execute the function.
     *
     * @param recipient The ETH amount receiver address.
     * @param amount The amount of ETH would be transferred (in wei).
     */
    function transferETH(
        address payable recipient,
        uint256 amount
    ) public onlyOwner {
        /// Transfer ETH
        Address.sendValue(recipient, amount);
        /// Emitting events
        emit ETHTransferred(recipient, amount);
    }

    /**
     * @notice Execute a dynamic encoded call on an external contract, without ETH attached.
     * - Only owners can execute the function.
     *
     * @param target The address of the external contract to execute the call on.
     * @param data The bytes-encoded parameters and signature (if any) of the call.
     *
     * @return returnValue The return value from executing the call, if it was successful.
     * Otherwise, revert with `Errors.FailedCall` or another error as per EVM rules.
     */
    function executeEncodedCall(
        address target,
        bytes memory data
    ) public onlyOwner returns (bytes memory returnValue) {
        /// Execute and returns the expected return value from the call.
        returnValue = Address.functionCall(target, data);
    }

    /**
     * @notice Execute a dynamic encoded call on an external contract, with ETH attached.
     * - Only owners can execute the function.
     *
     * @param target The address of the external contract to execute the call on.
     * @param data The bytes-encoded parameters and signature (if any) of the call.
     * @param ethAmount The amount of ETH to attach to the transaction when executing the call.
     *
     * @return returnValue The return value from executing the call, if it was successful.
     * Otherwise, revert with `Errors.FailedCall` or another error as per EVM rules.
     */
    function executeEncodedCallWithETH(
        address target,
        bytes memory data,
        uint256 ethAmount
    ) public onlyOwner returns (bytes memory returnValue) {
        /// Execute and returns the expected return value from the call.
        returnValue = Address.functionCallWithValue(target, data, ethAmount);
        /// Emitting events
        emit ETHTransferred(target, ethAmount);
    }
}
