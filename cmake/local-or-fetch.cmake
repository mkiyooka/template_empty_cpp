# ローカルディレクトリが存在する場合はそれを使用し、
# 存在しない場合はGitまたはHTTP/FTPから取得する関数
#
# 使用例(Git):
#   add_external_package(CLI11 ext/CLI11-2.5.0
#       GIT_REPOSITORY https://github.com/CLIUtils/CLI11.git
#       GIT_TAG v2.5.0
#   )
#
# 使用例(HTTP/FTP):
#   add_external_package(CLI11 ext/CLI11-2.5.0
#       URL https://github.com/CLIUtils/CLI11/archive/refs/tags/v2.5.0.tar.gz
#       URL_HASH SHA256=abc123...
#   )
#
# 引数:
#   LIBRARY_NAME: ライブラリ名
#   LOCAL_PATH: ローカルディレクトリパス（プロジェクトルートからの相対パス）
#   GIT_REPOSITORY: GitリポジトリURL（Git取得時、常にshallow clone）
#   GIT_TAG: Gitタグまたはブランチ名
#   URL: ダウンロードURL（HTTP/FTP取得時）
#   URL_HASH: チェックサムハッシュ（オプション、SHA256=...形式）
#
# 注意:
#   FetchContent_MakeAvailable()は呼び出し側で実行してください

function(add_external_package LIBRARY_NAME LOCAL_PATH)
    set(options "")
    set(oneValueArgs GIT_REPOSITORY GIT_TAG URL URL_HASH)
    set(multiValueArgs "")
    cmake_parse_arguments(ARG "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    set(FULL_LOCAL_PATH "${CMAKE_SOURCE_DIR}/${LOCAL_PATH}")
    if(EXISTS ${FULL_LOCAL_PATH})
        message(STATUS "Using local ${LIBRARY_NAME} from ${FULL_LOCAL_PATH}")
        FetchContent_Declare(${LIBRARY_NAME}
            SOURCE_DIR ${FULL_LOCAL_PATH}
        )
    elseif(DEFINED ARG_URL)
        message(STATUS "Downloading ${LIBRARY_NAME} from ${ARG_URL}")
        if(DEFINED ARG_URL_HASH)
            FetchContent_Declare(${LIBRARY_NAME}
                URL ${ARG_URL}
                URL_HASH ${ARG_URL_HASH}
                DOWNLOAD_EXTRACT_TIMESTAMP ON
            )
        else()
            FetchContent_Declare(${LIBRARY_NAME}
                URL ${ARG_URL}
                DOWNLOAD_EXTRACT_TIMESTAMP ON
            )
        endif()
    elseif(DEFINED ARG_GIT_REPOSITORY)
        message(STATUS "Fetching ${LIBRARY_NAME} from ${ARG_GIT_REPOSITORY}")
        FetchContent_Declare(${LIBRARY_NAME}
            GIT_REPOSITORY ${ARG_GIT_REPOSITORY}
            GIT_TAG ${ARG_GIT_TAG}
            GIT_SHALLOW TRUE
        )
    else()
        message(FATAL_ERROR "Either GIT_REPOSITORY or URL must be specified for ${LIBRARY_NAME}")
    endif()
endfunction()
