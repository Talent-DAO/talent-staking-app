// contracts/rTalent.sol
// SPDX-License-Identifier: GPL
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC1155/presets/ERC1155PresetMinterPauser.sol";

contract rTalent is ERC1155 {
    constructor() ERC1155("https://api.talentdao.org/api/v1/nft/{id}") {}

    function mint(address account, uint256 id, uint256 amount, bytes memory data) public {
        _mint(account, id, amount, data);
    }
}