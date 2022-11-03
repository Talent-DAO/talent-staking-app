import Image from 'next/image'
import { ConnectButton } from "@rainbow-me/rainbowkit";
import styles from '../styles/Home.module.css'
import Nav from '../components/nav';
import Header from '../components/header';

export default function Home() {
  return (
    <div className="container">
      <main className=" flex flex-col">
        <Header />
        <div className="text-3xl text-center">
          TalentDAO Staking
        </div>
      </main>

      <footer className={styles.footer}>
        <a
          href="https://vercel.com?utm_source=create-next-app&utm_medium=default-template&utm_campaign=create-next-app"
          target="_blank"
          rel="noopener noreferrer"
        >
          Powered by{' '}
          <span className={styles.logo}>
            <Image src="/vercel.svg" alt="Vercel Logo" width={72} height={16} />
          </span>
        </a>
      </footer>
    </div>
  )
}
