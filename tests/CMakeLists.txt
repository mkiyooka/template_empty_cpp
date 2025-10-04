# Test executable
add_executable(test_core
    test_core.cpp
)

target_include_directories(test_core PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_link_libraries(test_core PRIVATE core doctest::doctest)

# Register the test with CTest
add_test(
    NAME test_core
    COMMAND $<TARGET_FILE:test_core>
)
