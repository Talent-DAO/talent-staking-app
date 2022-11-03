import { ConnectButton } from "@rainbow-me/rainbowkit";

export default function Nav() {
  return (
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
  );
}