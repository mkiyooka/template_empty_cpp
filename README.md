# C++ Project Template

モダンC++開発のためのクロスプラットフォーム対応テンプレートプロジェクトです。

## プロジェクト構成

- **ビルドシステム**: CMake 4.1.1 + Ninja
- **パッケージマネージャー**: Conan 2.20.1
- **環境管理**: Pixi (クロスプラットフォーム対応)
- **テストフレームワーク**: doctest
- **C++標準**: C++17

## 必要な環境

### 基本要件

- **CMake** 3.19以上
- **Pixi** (推奨)
- **C++17**対応コンパイラ

### プラットフォーム別コンパイラ

- **Linux**: GCC + Clang (Pixiで自動インストール)
- **macOS**: Clang (Pixiで自動インストール)
- **Windows**: MSVC / MinGW (システム要件 + Pixiサポート)

## クイックスタート

### 1. Pixi環境セットアップ

```bash
# Pixi依存関係のインストール
pixi install

# Pixiシェル環境の起動
pixi shell
```

### 2. ビルド手順

```bash
# 依存関係のインストール (Conan)
pixi run conan

# CMake設定
pixi run config

# ビルド
pixi run build

# テスト実行
pixi run test
```

### 3. 従来の方法 (Pixiなし)

```bash
# 依存関係のインストール
conan install . --output-folder=build --build=missing

# CMake設定
cmake --preset release

# ビルド
cmake --build build -j

# テスト実行
ctest --test-dir build
```

## 開発ツール

### コード品質管理

```bash
# フォーマット
cmake --build build --target format

# リント (clang-tidy)
cmake --build build --target lint

# 静的解析 (cppcheck)
cmake --build build --target run-cppcheck

# 全品質チェック
cmake --build build --target fullcheck
```

### 利用可能なツール

- **clang-format**: コードフォーマット (21.1.1)
- **clang-tidy**: 静的解析・リント (21.1.1)
- **clangd**: Language Server (21.1.1)
- **cppcheck**: 追加静的解析 (2.18.3)

## VSCode統合

### 推奨拡張機能

プロジェクトを開くと以下の拡張機能がインストール推奨されます:

- **C/C++拡張パック**: IntelliSense、デバッグ
- **CMake Tools**: CMakeサポート
- **clangd**: 高性能Language Server

### 自動化機能

- **Pixi環境**: ターミナルで自動アクティベート
- **フォーマット**: 保存時自動実行
- **ビルドタスク**: Ctrl+Shift+P → "Tasks: Run Task"
- **デバッグ**: F5でビルド&デバッグ実行

## プロジェクト構造

```text
- cmake/                    # CMake設定ファイル
  - quality-tools.cmake     # コード品質ツール設定
- include/                  # ヘッダーファイル
  - sub/
- src/                      # ソースコード
  - main.cpp               # メインプログラム
  - sub/                   # サブモジュール
- tests/                    # テストコード
  - cpp/
- .vscode/                  # VSCode設定
- pixi.toml                 # Pixi環境定義
- conanfile.py              # Conan依存関係
- CMakeLists.txt            # CMake設定
```

## 開発開始方法

1. **環境構築**: `pixi install`
2. **開発**: VSCodeでプロジェクト開く
3. **コード作成**: `src/`, `include/`にファイル追加
4. **テスト作成**: `tests/cpp/`にテストファイル追加
5. **ビルド確認**: `pixi run build`

## ライセンス情報

サードパーティライブラリのライセンスは以下で確認可能:

```bash
cmake --build build --target collect-licenses
ls build/third_party_licenses/
```

## pixiの導入

```bash
curl -fsSL https://pixi.sh/install.sh | bash
export PATH="$HOME/.pixi/bin:$PATH"
# bashに設定する場合、以下のコマンドを実行
echo '[ -d "$HOME/.pixi/bin" ] && export PATH="$HOME/.pixi/bin:$PATH"' >> ~/.bashrc
pixi install # install package
pixi shell # activate environment
```
