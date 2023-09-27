# SolQuiz by Smart Contract Application Laboratory - 入門編

## Getting Started

### ベース環境
- WindowsはWSL2を用意。MacOSはTerminalを用意。
  - WSL(1)はUbuntu18.04なのでFoundryが未対応
- Foundryのダウンロード
  - `curl -L https://foundry.paradigm.xyz | bash`
  - インストール: `foundryup`
    - (もうリポジトリに入れてあるが必要なら) 依存ライブラリのインストール
      - `forge install foundry-rs/forge-std`
      - `forge install openzeppelin/openzeppelin-contracts`

## 開発エディタ
- エディタはVSCode推奨.
  - Solidity pluginをextensionsから追加（JuanBlanco.solidity）
 - VSCodeがmonorepo内のimportを解決できない問題があります。
   - 個別ディレクトリをVSCodeで開けばエラーは表示されないので個別ディレクトリ推奨です。
   - ただし、`importエラー`が表示されていても、foundryのテストが問題なく動作します。
     - `importエラー`で、動作しない場合は相談しましょう。

## 進め方
- `./test/Questions.t.sol` は単体テストフレームワークを応用した問題集になっている
- `forge test -vv -m <テスト名>` コマンドを使用して「答案用紙を実行」して、テストを通過するようにプログラムを埋めよう
  - テスト実行コマンドいろいろ
  - `forge test -vv -m test_Q1_Arithmetic`
  - `forge test -vv -m test_Q2_StructAndStorage`
  - `forge test -vv -m test_Q3_ConditionalCheck`
  - `forge test -vv -m test_Q4_NativeToken`
  - `forge test -vv -m test_Q5_NFT`
  - `forge test -vv` 失敗したテストだけ簡易に結果が出る
  - `forge test -vvv` 失敗したテストだけスタックトレースも出る
  - `forge test -vvvv` 全てのテストが簡易に結果が出る
  - `forge test -vvvvv` 全てのテストがスタックトレースも出る

## スマートコントラクトのテスト駆動開発を覚える
- Q-1.
  不動小数点の四則演算を試す/gasleft()とconsole.log()を学ぶ
- Q-2.
  構造体/ストレージアクセスを試す
- Q-3.
  制御構文(if, for, require, revert), modifier, アクセス制御, オーナー権限を試す
- Q-4.
  ネイティブトークン支払いを試す
- Q-5.
  ERC-721とapprovalとプログラマブルな送金と多様なコントラクト
