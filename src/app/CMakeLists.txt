add_executable(app main.cpp)

target_link_libraries(app
    PRIVATE core
)

# プリコンパイル済みヘッダーの設定
if(USE_PCH)
    target_precompile_headers(app PRIVATE
        <memory>
        <string>
    )
    message(STATUS "Precompiled headers enabled for executables")
endif()
