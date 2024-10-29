/** @notice Library imports */
import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

/// SmartContractWallet module
const SmartContractWalletModule = buildModule(
  "SmartContractWalletModule",
  (m) => {
    const smartContractWallet = m.contract("SmartContractWallet");
    return { smartContractWallet };
  }
);

export default SmartContractWalletModule;
