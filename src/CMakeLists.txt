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
set(GDMLVIEW_APP_CONFIG )
set(GDMLVIEW_APP_EXTRA_LIBS )

if(HAVE_GEANT4_UI_TCSH)
    list(APPEND GDMLVIEW_APP_CONFIG "G4UI_USE_TCSH")
endif()

if(HAVE_GEANT4_UI_QT)
    list(APPEND GDMLVIEW_APP_CONFIG "G4UI_USE_QT")
endif()

if(HAVE_GEANT4_VIS_OPENGLX)
    list(APPEND GDMLVIEW_APP_CONFIG "G4VIS_USE_OPENGLX")
    list(APPEND GDMLVIEW_APP_EXTRA_LIBS ${Geant4_VIS_OPENGL_LIBRARY})
    list(APPEND GDMLVIEW_APP_EXTRA_LIBS ${Geant4_VIS_GL2PS_LIBRARY})    
endif()

if(HAVE_GEANT4_VIS_OPENGLQT)
    list(APPEND GDMLVIEW_APP_CONFIG "G4VIS_USE_OPENGLQT")
    list(APPEND GDMLVIEW_APP_EXTRA_LIBS ${Geant4_VIS_OPENGL_LIBRARY})    
    list(APPEND GDMLVIEW_APP_EXTRA_LIBS ${Geant4_VIS_GL2PS_LIBRARY})    
endif()


set_source_files_properties(${GDMLVIEW_MAIN_APP} 
    PROPERTIES COMPILE_DEFINITIONS "${GDMLVIEW_APP_CONFIG}") 

add_executable(gdmlview ${GDMLVIEW_MAIN_APP} ${GDMLVIEW_COMPONENT_SOURCES})
target_link_libraries(gdmlview 
    ${Geant4_LIBRARIES}
    ${Geant4_INTERFACES_LIBRARY}
    ${Geant4_VIS_LIBRARIES}
    ${Geant4_VIS_ASCIITREE_LIBRARY}
    ${Geant4_VIS_DAWN_LIBRARY}
    ${Geant4_VIS_RAYTRACER_LIBRARY}
    ${Geant4_VIS_VRML_LIBRARY}
    ${Geant4_VIS_GMOCREN_LIBRARY}
    ${Geant4_VIS_HEPREP_LIBRARY}
    ${GDMLVIEW_APP_EXTRA_LIBS}
    ${Boost_PROGRAM_OPTIONS_LIBRARY})


