#------------------------------------------------------------------------------
# CMakeLists.txt for gdml viewer app
#

set(GDMLVIEW_COMPONENT_SOURCES
    GdmlCmdLineParser.hh GdmlCmdLineParser.cc
    UISessionFactory.hh
    RandomizePolicy.hh
    DetectorConstructor.hh DetectorConstructor.cc
    DetectorConstructorMessenger.hh DetectorConstructorMessenger.cc
    GDMLGeometryConstructor.hh GDMLGeometryConstructor.cc
    GDMLGeometryConstructorMessenger.hh GDMLGeometryConstructorMessenger.cc
    ExN01PhysicsList.hh ExN01PhysicsList.cc
    PrimaryGeneratorAction.hh PrimaryGeneratorAction.cc)

set(GDMLVIEW_MAIN_APP gdmlview.cc)


#
# Add the executable
#
include_directories(${Geant4_INCLUDE_DIRS})
include_directories(${Boost_INCLUDE_DIR})


#
# Select the available sessions and visualizations to add
#
include(${GEANT4_USE_FILE})

add_executable(gdmlview ${GDMLVIEW_MAIN_APP} ${GDMLVIEW_COMPONENT_SOURCES})
target_link_libraries(gdmlview
    ${Geant4_LIBRARIES}
    ${Boost_PROGRAM_OPTIONS_LIBRARY}
    )

install(TARGETS gdmlview DESTINATION bin)

