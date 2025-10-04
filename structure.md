CMakeプロジェクトディレクトリ構成

```text
project_root/
├── CMakeLists.txt             # トップレベル（全体設定）
├── cmake/                     # CMakeモジュールやツール設定
│   ├── ConfigXXX.cmake
│   └── FindYYY.cmake
├── external/                  # 外部ライブラリ（FetchContentやサブモジュール）
│   ├── CMakeLists.txt
│   └── fmt/
├── src/                       # 実装コード
│   ├── CMakeLists.txt
│   ├── core/                  # 共通ロジック
│   │   ├── CMakeLists.txt
│   │   ├── core.hpp
│   │   └── core.cpp
│   ├── net/                   # 通信関連
│   │   ├── CMakeLists.txt
│   │   ├── net.hpp
│   │   └── net.cpp
│   └── app/                   # 実行ファイル
│       ├── CMakeLists.txt
│       └── main.cpp
├── include/                   # 公開ヘッダ（ライブラリ公開API）
│   └── myproject/
│       └── core.hpp
├── tests/                     # テストコード
│   ├── CMakeLists.txt
│   └── test_core.cpp
└── build/                     # ビルドディレクトリ（gitignore対象）
```

`CMakeLists.txt`

```cmake
cmake_minimum_required(VERSION 3.22)
project(MyProject LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# 外部ライブラリ設定
include(FetchContent)
# FetchContent_Declare(...)

# サブプロジェクト追加
add_subdirectory(src)
add_subdirectory(tests)
```

`src/CMakeLists.txt`

```cmake
add_subdirectory(core)
add_subdirectory(net)
add_subdirectory(app)
```

`src/net/CMakeLists.txt`

```cmake
add_library(net STATIC
    net.cpp
)

target_include_directories(net
    PUBLIC ${CMAKE_SOURCE_DIR}/include
)
target_link_libraries(net
    PUBLIC core          # coreに依存
)
```

`src/app/CMakeLists.txt`

```cmake
add_executable(app main.cpp)

target_link_libraries(app
    PRIVATE core
    PRIVATE net
)

# 実行時RPATH設定
set_target_properties(app PROPERTIES
    BUILD_RPATH "${CMAKE_SOURCE_DIR}/lib"
)
```

`tests/CMakeLists.txt`

```cmake
enable_testing()
add_executable(test_core test_core.cpp)
target_link_libraries(test_core PRIVATE core doctest::doctest)
add_test(NAME core_test COMMAND test_core)
```
