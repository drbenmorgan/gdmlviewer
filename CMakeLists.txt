#------------------------------------------------------------------------------
# Top Level CMakeLists.txt for Latte Build
#

#------------------------------------------------------------------------------
# Enforce out-of-source builds before anything else
#
if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
    message(STATUS "gdmlview requires an out-of-source build.")
    message(STATUS "Please remove these files from ${CMAKE_BINARY_DIR} first:")
    message(STATUS "CMakeCache.txt")
    message(STATUS "CMakeFiles")
    message(STATUS "Once these files are removed, create a separate directory")
    message(STATUS "and run CMake from there")
    message(FATAL_ERROR "in-source build detected")
endif()

#------------------------------------------------------------------------------
# Define CMake requirements and override make rules as needed
#
cmake_minimum_required(VERSION 3.3)

#------------------------------------------------------------------------------
# Define the project
#
project(gdmlview VERSION "0.1.0")

#------------------------------------------------------------------------------
# Set up path to internal set of CMake modules.
#
set(CMAKE_MODULE_PATH
    ${PROJECT_SOURCE_DIR}/cmake
    ${PROJECT_SOURCE_DIR}/cmake/Modules
    ${CMAKE_MODULE_PATH})

#------------------------------------------------------------------------------
# Build output
# Output all binaries to single directory based on their type
#
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/outputs/runtime)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/outputs/library)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/outputs/archive)


#------------------------------------------------------------------------------
# Includes for common utilities
#
include(gdmlviewCPackBase)

#------------------------------------------------------------------------------
# Find needed packages
#
find_package(Geant4 9.6 REQUIRED gdml qt NO_MODULE)

# Force static linking of Boost...
#set(Boost_USE_STATIC_LIBS ON)

find_package(Boost REQUIRED COMPONENTS program_options)



#------------------------------------------------------------------------------
# Add the subdirectories
#
add_subdirectory(src)


