# Q-5. ERC-721とapprovalとプログラマブルな送金と多様なコントラクト ガチャを通して、ERC-721の内容とコントラクトへの送金を学ぶ


## 手順
[QuestionNFT.t.sol](../../test/Q1/QuestionNFT.t.sol)ファイル内にあるテスト関数`test_Q5_NFT()`のシナリオをよく読み、
[AnswerNFT.sol](./AnswerNFT.sol)ファイル内の`buyBoosterPack()`, `canEnterByOriginHolder()`を変更してテストをPASSさせてください。
必要に応じて別途ヘルパー関数やmapping等も作成してください。


## 初期ソースコード
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import { SAnswerNFT } from "src/A5/interfaces/SAnswerNFT.sol";
import { IAnswerNFT } from "src/A5/interfaces/IAnswerNFT.sol";

contract AnswerNFT is IAnswerNFT, Ownable {
    /**
        Q-5. ERC-721とapprovalとプログラマブルな送金と多様なコントラクト
        ガチャを通して、ERC-721の内容とコントラクトへの送金を学ぶ
     */
    IERC721 nft;

    /**
     * @dev NFTAddressを設定する関数
     */
    function setNFT(address _nft) public onlyOwner {
        nft = IERC721(_nft);
    }

    uint256 _boosterCounter = 1;

    /**
     * @dev NFTのガチャガチャを回す関数
     */
    function buyBoosterPack() public payable override {
        // Note: Fill me
    }

    /**
     * @dev 最初にNFTのガチャガチャを回した者に入場の権利を付与する関数
     */
    function canEnterByOriginHolder() public override view returns (bool) {
        // Note: Fill me
    }
}
```


## FAQ
[FAQ日本語版](./docs/FAQ/FAQ.ja.md)
