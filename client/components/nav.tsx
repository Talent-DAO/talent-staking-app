import { ConnectButton } from "@rainbow-me/rainbowkit";
import Link from "next/link";

export default function Nav() {
  return (
    <nav className='flex justify-end'>
      <ul className="inline-flex">
        <li className="p-2">
          <ConnectButton />
        </li>
        <li className="p-2">
          <Link href="/">
            Home
          </Link>
        </li>
        <li className="p-2">
          <Link href="/siwe">
            SIWE
          </Link>
        </li>
        <li className="p-2">
          <button className='bg-red-400 rounded-lg h-full p-2'>Help ?</button>
        </li>
      </ul>
    </nav>
  );
}