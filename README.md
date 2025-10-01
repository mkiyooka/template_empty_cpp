# C++ Project Template

モダンC++開発のためのクロスプラットフォーム対応テンプレートプロジェクトです。CMake FetchContentを使用してライブラリを管理しています。

## プロジェクト構成

- **ビルドシステム**: CMake 4.1.1 + Ninja
- **環境管理**: Pixi (クロスプラットフォーム対応)
- **テストフレームワーク**: doctest
- **C++標準**: C++17

## セットアップ

```bash
# Pixi環境のインストール
pixi install

# CMake設定とビルド
pixi run config
pixi run build

# テスト実行
pixi run test
```

## 開発ツール

```bash
# コードフォーマット
pixi run format

# 静的解析
pixi run lint

# 全チェック実行
pixi run fullcheck
```

## ディレクトリ構造

- `src/`: ソースコード
- `include/`: ヘッダーファイル
- `tests/`: テストコード
- `cmake/`: CMake設定ファイル
