import { RainbowKitProvider } from "@rainbow-me/rainbowkit";
import "@rainbow-me/rainbowkit/styles.css";
import { Session } from "next-auth";
import { SessionProvider } from "next-auth/react";
import type { AppProps } from "next/app";
import { WagmiConfig } from "wagmi";
import "../styles/globals.css";
import { chains, wagmiClient } from "../utils/wagmi";

export default function App({ Component, pageProps }: AppProps<{ session: Session }>) {
  return (
    <WagmiConfig client={wagmiClient}>
      <RainbowKitProvider chains={chains}>
        <SessionProvider session={pageProps.session} refetchInterval={0}>
          <Component {...pageProps} />
        </SessionProvider>
      </RainbowKitProvider>
    </WagmiConfig>
  );
}
