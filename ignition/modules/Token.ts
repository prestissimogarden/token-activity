import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const TokenModule = buildModule("TokenModule", (m) => {
    const token = m.contract("MyToken");
    return { token };
})

export default TokenModule;