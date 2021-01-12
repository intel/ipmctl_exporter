if(NOT CMAKE_Go_COMPILER)
    if(NOT $ENV{GO_COMPILER} STREQUAL "")
        get_filename_component(CMAKE_Go_COMPILER_INIT $ENV{GO_COMPILER} PROGRAM PROGRAM_ARGS CMAKE_Go_FLAGS_ENV_INIT)

        if(CMAKE_Go_FLAGS_ENV_INIT)
            set(CMAKE_Go_COMPILER_ARG1 "${CMAKE_Go_FLAGS_ENV_INIT}" CACHE STRING "First argument to Go compiler")
        endif()

        if(NOT EXISTS ${CMAKE_Go_COMPILER_INIT})
            message(SEND_ERROR "Could not find compiler set in environment variable GO_COMPILER:\n$ENV{GO_COMPILER}.")
        endif()

    endif()

    set(Go_BIN_PATH
        $ENV{GOPATH}
        $ENV{GOROOT}
        $ENV{GOROOT}/../bin
        $ENV{GO_COMPILER}
        /usr/bin
        /usr/local/bin)

    if(CMAKE_Go_COMPILER_INIT)
        set(CMAKE_Go_COMPILER ${CMAKE_Go_COMPILER_INIT} CACHE PATH "Go Compiler")
    else()
        find_program(CMAKE_Go_COMPILER
            NAMES go
            PATHS ${Go_BIN_PATH})
    endif()

endif()

mark_as_advanced(CMAKE_Go_COMPILER)

configure_file(CMakeGoCompiler.cmake.in
    ${CMAKE_PLATFORM_INFO_DIR}/CMakeGoCompiler.cmake @ONLY)

set(CMAKE_Go_COMPILER_ENV_VAR "GO_COMPILER")
