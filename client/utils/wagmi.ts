import { getDefaultWallets } from "@rainbow-me/rainbowkit";
import { chain, configureChains, createClient } from "wagmi";
import { publicProvider } from "wagmi/providers/public";

export const { chains, provider } = configureChains(
    [chain.mainnet, chain.goerli, chain.polygonMumbai, chain.polygon],
    [publicProvider()],
  );
  
  export const { connectors } = getDefaultWallets({
    appName: "TALENT STAKING",
    chains,
  });
  
  export const wagmiClient = createClient({
    autoConnect: true,
    connectors,
    provider,
  });