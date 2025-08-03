cmake_minimum_required(VERSION 3.16)

project(thevpnov VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick SQL)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(thevpnov
    main.cpp
)

qt_add_qml_module(thevpnov
    URI thevpnov
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES HomePage.qml
        QML_FILES ProfileEditor.qml
        SOURCES profilemanager.h profilemanager.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(thevpnov PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appthevpnov
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(thevpnov
    PRIVATE Qt6::Quick Qt6::Sql
)

include(GNUInstallDirs)
install(TARGETS thevpnov
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
