cmake_minimum_required(VERSION 3.16)

project(thevpnov VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Sql)
find_package(OpenSSL REQUIRED)

# --- Use pkg-config for libssh ---
find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBSSH REQUIRED libssh)

# Add libssh include dirs and linker flags from pkg-config
include_directories(${LIBSSH_INCLUDE_DIRS})
link_directories(${LIBSSH_LIBRARY_DIRS})
add_definitions(${LIBSSH_CFLAGS_OTHER})

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(thevpnov
    main.cpp
    profilemanager.cpp
    profilemanager.h
    connectionmanager.cpp
    connectionmanager.h
)

qt_add_qml_module(thevpnov
    URI thevpnov
    VERSION 1.0
    QML_FILES
        Main.qml
        HomePage.qml
        ProfileManager.qml
)

set_target_properties(thevpnov PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(thevpnov
    PRIVATE Qt6::Quick Qt6::Sql
    PRIVATE OpenSSL::SSL OpenSSL::Crypto
    PRIVATE ${LIBSSH_LIBRARIES}
)

include(GNUInstallDirs)
install(TARGETS thevpnov
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
