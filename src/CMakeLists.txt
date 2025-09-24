# Add subdirectories
add_subdirectory(sub)

add_executable(cmd main.cpp)
target_link_libraries(cmd PRIVATE sub_lib)

# プリコンパイル済みヘッダーの設定
if(USE_PCH)
    target_precompile_headers(cmd PRIVATE
        <memory>
        <string>
    )
    message(STATUS "Precompiled headers enabled for executables")
endif()
