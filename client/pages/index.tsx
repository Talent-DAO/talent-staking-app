import Image from 'next/image'
import { ConnectButton } from "@rainbow-me/rainbowkit";
import styles from '../styles/Home.module.css'

export default function Home() {
  return (
    <div className="container">
      <main className=" flex flex-col">
        <nav className='flex justify-end'>
          <ul className="inline-flex">
            <li className="p-2">
              <ConnectButton />
            </li>
            <li className="p-2">
              <button className='bg-red-400 rounded-lg h-full p-2'>Help ?</button>
            </li>
          </ul>
        </nav>
        {/* <Header /> */}
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
