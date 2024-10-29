/** @notice library imports */
import type { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";
import "dotenv/config";

/** @notice Hardhat configuration */
const config: HardhatUserConfig = {
  /// Solidity configuration
  solidity: {
    version: "0.8.27",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },

  sourcify: { enabled: true },

  /// Customized Paths
  paths: {
    /// Build
    cache: "build/cache",
    artifacts: "build/artifacts",

    /// Core
    tests: "/tests",
  },
};

export default config;
