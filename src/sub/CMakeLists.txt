add_library(sub_lib
    STATIC
    sub.cpp
)
target_include_directories(sub_lib PUBLIC ${PROJECT_SOURCE_DIR}/include)
