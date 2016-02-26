# - Find Geant4
# This module can be used to find Geant4.
# It will also detect if GDML support, user interfaces (UI) and visualization
# drivers are supported.
#
# Because of the various ways Geant4 can be built, the module will only
# find the most 'reasonable' choice - global shared libraries with a flat
# directory for headers. This should be the prefered case for most user and 
# system installs, though the module will be improved to take account of static # libraries and perhaps multilayer headers and granular libraries later.
#
# Usage of this module is as follows
#
#   FIND_PACKAGE(Geant4 9.2.1 [EXACT] [QUIET] [REQUIRED|COMPONENTS])
#
# Note that you should enter the version number by converting Geant4's x.y.pz 
# format to x.y.z.
#
# Variables used by this module, which can change the default behaviour and
# need to be set before calling find_package:
#
#
#   Geant4_ROOT_DIR             Root directory to Geant4 installation. Should
#                               be equivalent to G4INSTALL environment variable.
#                               At present, changing this between runs of cmake
#                               will NOT update other cached variables. This
#                               awaits support for dependent cache variables.
#                         
# 
#   Geant4_MAX_VERSION          Set this variable to maximum version number
#                               required, in the format "x.y.z" or "x.y". This
#                               is used with any version number supplied to
#                               FIND_PACKAGE to do a range check on the
#                               discovered version.
#
# The module uses MACRO_VERIFY_VERSION to perform version checking.
#
# This module defines a number of key variables once it has run.
#
#   Geant4_USE_FILE - path to a CMake file that can be used to compile
#                     Geant4 applications and libraries.
#
# The file pointed to by Geant4_USE_FILE will set up the compile environment
# by adding include directories, creating a 'geant4_config.hh' file containing
# needed #define statements, and populating a Geant4_LIBRARIES variable 
# containing all the Geant4 libraries needed and any dependencies. 
# By default the core Geant4 libraries:
#
#   G4global
#   G4intercoms
#   G4graphics_reps
#   G4materials
#   G4geometry
#   G4particles
#   G4track
#   G4digits_hits
#   G4processes
#   G4parmodels
#   G4tracking
#   G4event
#   G4run
#   G4error_propagation
#   G4readout
#   G4physicslists
#
# are added to Geant4_LIBRARIES by this module. Extra libraries and directives 
# for using the persistency, user interfaces and visualization drivers may be 
# added by setting one or more of the following variables to True prior to 
# doing INCLUDE(${Geant4_USE_FILE})
#
#   Geant4_USE_DIRECTIVES - Add preprocessor directives to compile environment
#                           rather than creating a geant4_config.hh file
#                           (provided for backward compatibility with Geant4)
#
#   Geant4_USE_PERSISTENCY - Enable use of G4persistency library
#
#   Geant4_UI_USE_TCSH - Enable use of tcsh user interface (NOT Win32 only)
#   Geant4_UI_USE_XAW  - Enable use of Xaw user interface
#   Geant4_UI_USE_XM   - Enable use of Xm user interface
#   Geant4_UI_USE_QT   - Enable use of Qt user interface
#   Geant4_UI_USE_WIN32- Enable use of Win32 user interface (Win32 only)
#
#   Geant4_VIS_USE_CORE        - Enable use of builtin visualization drivers
#                                (ASCIITree, HepRep, HepRepFile, VisXXX, 
#                                 DAWNFile, VRML1File, VRML2File, RayTracer)
#   Geant4_VIS_USE_FUKUI       - Enable use of Fukui Renderer visualization 
#                                driver.
#   Geant4_VIS_USE_RAYTRACERX  - Enable use of X11 version of RayTracer
#                                visualization driver
#   Geant4_VIS_USE_VRMLN       - Enable use of VRML1/2 visualization driver
#   Geant4_VIS_USE_OPENGLX     - Enable use of OpenGL X11 visualization driver
#   Geant4_VIS_USE_OPENGLXM    - Enable use of OpenGL Xm visualization driver
#   Geant4_VIS_USE_OPENGLQT    - Enable use of OpenGL Qt visualization driver
#   Geant4_VIS_USE_OPENGLWIN32 - Enable use of OpenGL Win32 visualization driver
#   Geant4_VIS_USE_OPENINVENTOR- Enable use of OpenInventor visualization driver
#
# The file pointed to by Geant4_USE_FILE will warn if any of these options
# have been selected but are not supported by the Geant4 installation found.
# It will not take any further action though.
#
# DEPENDENCIES!!! Though we have dependencies linked into shared libs, may
# have static, so should follow Cmake discussions on this. FindQt4 provides an
# example of this. 
# SO MAY NEED FindXaw, FindMotif etc, AND resolve dependencies among these if
# they don't do it...
# FOR NOW, only worry about shared libs, but try and set things up as much
# as possible to support static libs...
#
# Include the geant4_config.hh file to any project files that need it, and add 
# the Geant4_LIBRARIES variable to your TARGET_LINK_LIBRARIES. Typical usage
# would be something like
#
#   FIND_PACKAGE(Geant4)
#   SET(Geant4_UI_USE_TCSH True)
#   INCLUDE(${Geant4_USE_FILE})
#   ADD_EXECUTABLE(myexe main.cpp)
#   TARGET_LINK_LIBRARIES(myexe ${Geant4_LIBRARIES})
#
#
#
# Once finished, this module will define the following variables
#
#   Geant4_FOUND        - True if Geant4 core libraries and headers were found
#   Geant4_INCLUDE_DIRS - The Geant4 include directory(s)
#   Geant4_LIBRARIES    - The Geant4 core libraries.
#   Geant4_VERSION_OK   - True if discovered version satisfies versioning 
#                         requirements.
#
#   Geant4_HAVE_GDML    - True if G4persistency library supports GDML 
#
#   Geant4_UI_FOUND      - True if G4interfaces UI library found
#   Geant4_UI_LIBRARY    - The G4interfaces library
#   Geant4_UI_HAVE_TCSH  - True if G4UItcsh component found
#   Geant4_UI_HAVE_XAW   - True if G4UIXaw component found
#   Geant4_UI_HAVE_XM    - True if G4UIXm component found
#   Geant4_UI_HAVE_QT    - True if G4UIQt component found
#   Geant4_UI_HAVE_WIN32 - True if G4UIWin32 component found
#
#
#   Geant4_VIS_FOUND               - True if core visualization libraries found
#   Geant4_VIS_LIBRARIES           - the core libraries needed to use the Geant4
#                                    visualization system
#
#   Geant4_VIS_TREE_FOUND          - True if G4Tree library found
#   Geant4_VIS_TREE_LIBRARY        - The G4Tree library
#
#   Geant4_VIS_HEPREP_FOUND        - True if G4visHepRep library found
#   Geant4_VIS_HEPREP_LIBRARY      - The G4visHepRep library
#
#   Geant4_VIS_XXX_FOUND           - True if G4visXXX driver found
#   Geant4_VIS_XXX_LIBRARY         - The G4visXXX library
#
#   Geant4_VIS_DAWN_FOUND          - True if G4FR (DAWN) library found
#   Geant4_VIS_DAWN_HAVE_FR        - True if G4FR supports FukuiRenderer 
#                                    component
#   Geant4_VIS_DAWN_LIBRARY        - The G4FR (DAWN) library
#
#   Geant4_VIS_RAYTRACER_FOUND     - True if G4RayTracer library found
#   Geant4_VIS_RAYTRACER_HAVE_X11  - True if G4RayTracer supports X11 
#                                    component
#   Geant4_VIS_RAYTRACER_LIBRARY   - The G4RayTracer library
#
#   Geant4_VIS_VRML_FOUND          - True if G4VRML library found
#   Geant4_VIS_VRML_HAVE_VRMLN     - True if G4VRML supports VRML1/2 component
#   Geant4_VIS_VRML_LIBRARY        - The G4VRML library
#
#   Geant4_VIS_OPENGL_FOUND        - True if G4OpenGL library found
#   Geant4_VIS_OPENGL_HAVE_X11     - True if G4OpenGL supports X11 component
#   Geant4_VIS_OPENGL_HAVE_XM      - True if G4OpenGL supports Xm component
#   Geant4_VIS_OPENGL_HAVE_QT      - True if G4OpenGL supports Qt component
#   Geant4_VIS_OPENGL_HAVE_WIN32   - True if G4OpenGL supports Win32 component
#   Geant4_VIS_OPENGL_LIBRARY      - The G4OpenGL library
#
#   Geant4_VIS_OPENINVENTOR_FOUND      - True if G4OpenInventor library found
#   Geant4_VIS_OPENINVENTOR_HAVE_X11   - True if G4OpenInventor supports X11 
#                                        component
#   Geant4_VIS_OPENINVENTOR_HAVE_WIN32 - True if G4OpenInventor supports Win32
#                                        component
#   Geant4_VIS_OPENINVENTOR_LIBRARY    - The G4OpenInventor library
#
# Copyright (c) 2009, Ben Morgan, <Ben.Morgan@warwick.ac.uk>
#
# COPYING_INFO_TO_GO_HERE

include(ResolveCompilerPaths)
include(MacroEnsureVersion)
include(CheckCXXSourceCompiles)


#
# Helper Macros
#
macro(CHECK_GEANT4_CLASS_EXISTS _result _source _extra_defs _extra_includes _extra_libs)
    # save current CMAKE_REQUIRED_<name>
    set(_save_CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS})
    set(_save_CMAKE_REQUIRED_DEFINITIONS ${CMAKE_REQUIRED_DEFINITIONS})
    set(_save_CMAKE_REQUIRED_INCLUDES ${CMAKE_REQUIRED_INCLUDES})
    set(_save_CMAKE_REQUIRED_LIBRARIES ${CMAKE_REQUIRED_LIBRARIES})

    # use supplied data to set flags
    set(CMAKE_REQUIRED_DEFINITIONS ${CMAKE_REQUIRED_DEFINITIONS} ${_extra_defs})
    set(CMAKE_REQUIRED_INCLUDES ${CMAKE_REQUIRED_INCLUDES} ${_extra_includes})
    set(CMAKE_REQUIRED_LIBRARIES ${CMAKE_REQUIRED_LIBRARIES} ${_extra_libs})

    # Check source builds...
    check_cxx_source_compiles("${_source}" ${_result})

    # restore CMAKE_REQUIRED_<name>
    set(CMAKE_REQUIRED_FLAGS ${_save_CMAKE_REQUIRED_FLAGS})
    set(CMAKE_REQUIRED_DEFINITIONS ${_save_CMAKE_REQUIRED_DEFINITIONS})
    set(CMAKE_REQUIRED_INCLUDES ${_save_CMAKE_REQUIRED_INCLUDES})
    set(CMAKE_REQUIRED_LIBRARIES ${_save_CMAKE_REQUIRED_LIBRARIES})
endmacro()


#
# Cache dependencies here!
#


if (Geant4_FOUND)
    # We already found Geant4
    # For now ignore different versioning between calls - yes makes no sense
    # for subcalls to recheck?
    set(Geant4_FIND_QUIETLY TRUE)

else ()
    #
    # If Geant4_ROOT_DIR not set, fall back to G4INSTALL environment variable 
    # to locate root directory of installation, and then fail if that's not 
    # there
    #
    if (NOT Geant4_ROOT_DIR)
        set(Geant4_ROOT_DIR $ENV{G4INSTALL})

        if (NOT Geant4_ROOT_DIR)
            message(FATAL_ERROR "Geant4 root directory cannot be determined. You need to set Geant4_ROOT_DIR in CMake, or set the G4INSTALL environment variable appropriately")
        endif ()
    endif()

    message(STATUS "Found Geant4 root directory: ${Geant4_ROOT_DIR}")


    #
    # Determine G4SYSTEM, if not set by environment variable
    #
    set(Geant4_SYSTEM_NAME $ENV{G4SYSTEM})

    if (NOT Geant4_SYSTEM_NAME)
        # Should attempt to 'canonicalize' (in G4 terms) system and
        # compiler, but for now fatalize it..
        message(FATAL_ERROR "Geant4 System cannot be determined, you need to have G4SYSTEM set in your environment")
    endif()

    message(STATUS "Found Geant4 Arch-Compiler: ${Geant4_SYSTEM_NAME}")
       

    # Reset vars before proceeding
    set(Geant4_LIBRARIES)
    set(Geant4_INCLUDE_DIRS)
    set(Geant4_VERSION_OK)

    # If we find a root dir for Geant4...
    if (Geant4_ROOT_DIR)
        # We MUST have CLHEP (need versioning check strictly...)
        find_package(CLHEP REQUIRED)

        # Find include path - G4Version.hh is our guide (but not foolproof)
        find_path(Geant4_INCLUDE_DIR 
            NAMES G4Version.hh 
            PATHS ${Geant4_ROOT_DIR} 
            PATH_SUFFIXES include include/Geant4 
            NO_DEFAULT_PATH)

        # Read G4Version.hh to extract version info, which for Geant4
        # version x.y.z, will appear as the line '#define G4VERSION_NUMBER xyz'
        file(READ 
            "${Geant4_INCLUDE_DIR}/G4Version.hh" 
            _geant4_G4VERSIONHH_CONTENTS)

        string(REGEX REPLACE 
            ".*#define G4VERSION_NUMBER[ ]*([0-9])([0-9])([0-9]).*" 
            "\\1.\\2.\\3" 
            Geant4_DISCOVERED_VERSION 
            "${_geant4_G4VERSIONHH_CONTENTS}")

        message(STATUS "Detected Geant4 version: ${Geant4_DISCOVERED_VERSION}")

        # VERSIONING CHECK
        # At the end of this section, Geant4_VERSION_OK will be true if
        # discovered version satisfies requirements
        MACRO_VERIFY_VERSION(Geant4_VERSION_OK 
            MIN_VERSION ${Geant4_FIND_VERSION}
            MAX_VERSION ${Geant4_MAX_VERSION}
            FOUND_VERSION ${Geant4_DISCOVERED_VERSION}
            FIND_EXACT ${Geant4_FIND_VERSION_EXACT})
        message(STATUS "Verification of Geant4 version: ${Geant4_VERSION_OK}")



        # Now to check for libraries, basing suffixes off of system name...
        # First thing to do is check for global libs, don't work with granular.
        # Existence of G4global lib is sufficient for this. 
        # We need all 'Core' libraries, then check separately for libs that
        # may not exist, or those that have optional components that we need
        # to check for
        set(Geant4_LIBRARY_DIR_SUFFIXES 
            lib
            lib/${Geant4_SYSTEM_NAME})
        
        find_library(Geant4_GLOBAL_LIBRARY 
            NAMES G4global
            PATHS ${Geant4_ROOT_DIR} 
            PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
            DOC "Path to Geant4 Global library"
            NO_DEFAULT_PATH)
        mark_as_advanced(Geant4_GLOBAL_LIBRARY)

        # Now find core libraries
        set(Geant4_CORE_LIBRARY_NAMES
            G4intercoms
            G4graphics_reps
            G4materials
            G4geometry
            G4particles
            G4track
            G4digits_hits
            G4processes
            G4parmodels
            G4tracking
            G4event
            G4run
            G4error_propagation
            G4readout
            G4physicslists
            G4persistency)

        foreach(G4LIB ${Geant4_CORE_LIBRARY_NAMES})
            string(TOUPPER ${G4LIB} UPPERG4LIB)
            find_library(Geant4_${UPPERG4LIB}_LIBRARY
                NAMES ${G4LIB}
                PATHS ${Geant4_ROOT_DIR}
                PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
                DOC "Path to Geant4 ${G4LIB} library"
                NO_DEFAULT_PATH)
            mark_as_advanced(Geant4_${UPPERG4LIB}_LIBRARY)
        endforeach()

        #
        # Now search for Interfaces lib
        #
        find_library(Geant4_INTERFACES_LIBRARY
            NAMES G4interfaces
            PATHS ${Geant4_ROOT_DIR}
            PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
            DOC "Path to Geant4 Interfaces library"
            NO_DEFAULT_PATH)
        mark_as_advanced(Geant4_INTERFACES_LIBRARY)


        #
        # Finally, check for visualization libs
        #
        # These are divided into the 'core' management/general libs and the
        # actual driver libs
        # 
        # We search for the general libs first, as these can be present even
        # if the drivers are not.
        find_library(Geant4_VIS_MODELING_LIBRARY
            NAMES G4modeling
            PATHS ${Geant4_ROOT_DIR}
            PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
            DOC "Path to Geant4 Visualization Modeling library"
            NO_DEFAULT_PATH)
        mark_as_advanced(Geant4_VIS_MODELING_LIBRARY)

        find_library(Geant4_ZLIB_LIBRARY
            NAMES G4zlib
            PATHS ${Geant4_ROOT_DIR}
            PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
            DOC "Path to Geant4 internal zlib library"
            NO_DEFAULT_PATH)
        mark_as_advanced(Geant4_ZLIB_LIBRARY)

        # Find vis management library - this is present if visualization was
        # built
        find_library(Geant4_VIS_MANAGEMENT_LIBRARY
            NAMES G4vis_management
            PATHS ${Geant4_ROOT_DIR}
            PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
            DOC "Path to Geant4 visualization management library"
            NO_DEFAULT_PATH)
        mark_as_advanced(Geant4_VIS_MANAGEMENT_LIBRARY)


        # If we did find vis management library, we did find visualization
        if (Geant4_VIS_MANAGEMENT_LIBRARY)
            set(Geant4_VIS_FOUND True)
        endif (Geant4_VIS_MANAGEMENT_LIBRARY)

        set(Geant4_VIS_LIBRARIES 
            ${Geant4_VIS_MODELING_LIBRARY}
            ${Geant4_ZLIB_LIBRARY}
            ${Geant4_VIS_MANAGEMENT_LIBRARY}
        )


        # Because try_compile checks require all Geant4 libs, and dependencies,
        # merge core libraries into single list.
        set(Geant4_CORE_LIBRARIES ${Geant4_GLOBAL_LIBRARY})
        foreach(G4LIB ${Geant4_CORE_LIBRARY_NAMES})
            string(TOUPPER ${G4LIB} UPPERG4LIB)
            set(Geant4_CORE_LIBRARIES ${Geant4_CORE_LIBRARIES} ${Geant4_${UPPERG4LIB}_LIBRARY})
        endforeach()


        #
        # Check for GDML support in G4persistency library
        # Need Xerces-C to perform check, but don't require it, because if it
        # isn't found GDML won't work anyway...
        #
        find_package(XercesC)
        CHECK_GEANT4_CLASS_EXISTS(Geant4_HAVE_GDML
            "#include \"G4GDMLParser.hh\"
            int main()
            {
                G4GDMLParser a;
            }"
            "-DG4_USE_GDML" 
            "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};${XERCESC_INCLUDE_DIRS}" 
            "${Geant4_CORE_LIBRARIES};${Geant4_PERSISTENCY_LIBRARY};${CLHEP_LIBRARIES};${XERCESC_LIBRARIES}")




        # 
        # Check for the following components in the interfaces library, if
        # that was found
        #
        # G4UIQt,
        # G4UIWin32 (WIN32 only)
        # G4UIXaw
        # G4UIXm
        # G4UItcsh

        if (Geant4_INTERFACES_LIBRARY)
            # Find Qt and X11 needed to check for support (only headers...)
            #
            # Qt4 or Qt3, prefer Qt4 if found. Not guaranteed that Geant4 was
            # built using Qt4, but if Qt4 is on the system, that was PROBABLY
            # used.
            find_package(Qt4 QUIET COMPONENTS QtCore QtGui)
            include(${QT_USE_FILE})

            # X11
            #find_package(X11 QUIET)

            # 
            # G4UIQt component
	        CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_UI_QT 
	            "#include \"G4UIQt.hh\"
	            int main(int argc, char** argv)
	            {
	                G4UIQt a(argc,argv);
	            }"
	            "-DG4UI_USE_QT" 
	            "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};${QT_INCLUDES}" 
	            "${Geant4_CORE_LIBRARIES};${XERCESC_LIBRARIES};${Geant4_INTERFACES_LIBRARY};${CLHEP_LIBRARIES}")

            #
            # G4UIXaw component
            #
	        CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_UI_XAW
	            "#include \"G4UIXaw.hh\"
	            int main(int argc, char** argv)
	            {
	                G4UIXaw a(argc,argv);
	            }"
	            "-DG4UI_USE_XAW" 
	            "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};${X11_Xt_INCLUDE_PATH}" 
	            "${Geant4_CORE_LIBRARIES};${Geant4_INTERFACES_LIBRARY};${CLHEP_LIBRARIES}")

            #
            # G4UIXm component
            #
	        CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_UI_XM 
	            "#include \"G4UIXm.hh\"
	            int main(int argc, char** argv)
	            {
	                G4UIXm a(argc,argv);
	            }"
	            "-DG4UI_USE_XM" 
	            "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};${X11_Xt_INCLUDE_PATH}" 
	            "${Geant4_CORE_LIBRARIES};${Geant4_INTERFACES_LIBRARY};${CLHEP_LIBRARIES}")

            #
            # G4UItcsh component
            #
	        CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_UI_TCSH 
	            "#include \"G4UItcsh.hh\"
	            int main(int argc, char** argv)
	            {
	                G4UItcsh a;
	            }"
	            "-DG4UI_USE_TCSH" 
	            "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};" 
	            "${Geant4_CORE_LIBRARIES};${XERCESC_LIBRARIES};${Geant4_INTERFACES_LIBRARY};${CLHEP_LIBRARIES}")

            #
            # G4UIWin32 - only needed on Win32!!
            #
	        if (WIN32)
                # Any checks needed here? G4UIWin32 needs windows.h and
                # windowsx.h?
	            CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_UI_WIN32 
	                "#include \"G4UIWin32.hh\"
	                int main(int argc, char** argv)
	                {
	                    G4UIWin32 a(argc,argv);
	                }"
	                "-DG4UI_USE_WIN32" 
	                "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS}" 
	                "${Geant4_CORE_LIBRARIES};${Geant4_INTERFACES_LIBRARY};${CLHEP_LIBRARIES}")
            endif (WIN32)

        endif (Geant4_INTERFACES_LIBRARY)




        # Internal Vis libs are relatively straightforward 
        # (but watch for these getting cached...)
        # We only need to check for these if G4vis_management lib found
        if (Geant4_VIS_MANAGEMENT_LIBRARY)
            message(STATUS "Check for supported graphics drivers")
	       
	       #
	       # Fukui Renderer (DAWN)
	       #
	       find_library(Geant4_VIS_DAWN_LIBRARY 
	           NAMES G4FR 
	           PATHS ${Geant4_ROOT_DIR} 
	           PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
	           DOC "Path to Geant4 DAWN (FR) visualization library"
	           NO_DEFAULT_PATH)

	       # - Check existence of FukuiRenderer in G4FR
	       CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_VIS_FUKUI 
	           "#include \"G4FukuiRenderer.hh\"
	           int main(int argc, char** argv)
	           {
	               G4FukuiRenderer a;
	           }"
	           "-DG4VIS_USE_DAWN" 
	           "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};" 
	           "${Geant4_CORE_LIBRARIES};${CLHEP_LIBRARIES};${Geant4_VIS_LIBRARIES};${Geant4_VIS_DAWN_LIBRARY}")



           #
	       # VRML
           #
	       find_library(Geant4_VIS_VRML_LIBRARY
	           NAMES G4VRML
	           PATHS ${Geant4_ROOT_DIR}
	           PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
	           DOC "Path to Geant4 VRML visualization library"
	           NO_DEFAULT_PATH)

           # - Check existence of VRML1 - this should be sufficient to detect
           # VRML2 as both are built
	       CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_VIS_VRML 
	           "#include \"G4VRML1.hh\"
	           int main(int argc, char** argv)
	           {
	               G4VRML1 a;
	           }"
	           "-DG4VIS_USE_VRML" 
	           "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};" 
	           "${Geant4_CORE_LIBRARIES};${CLHEP_LIBRARIES};${Geant4_VIS_LIBRARIES};${Geant4_VIS_VRML_LIBRARY}")


           #
	       # RayTracer
           #
	       find_library(Geant4_VIS_RAYTRACER_LIBRARY
	           NAMES G4RayTracer
	           PATHS ${Geant4_ROOT_DIR}
	           PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
	           DOC "Path to Geant4 RayTracer visualization library"
	           NO_DEFAULT_PATH)

           # - Check existence of RayTracerX
	       CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_VIS_RAYTRACERX
	           "#include \"G4RayTracerX.hh\"
	           int main(int argc, char** argv)
	           {
	               G4RayTracerX a;
	           }"
	           "-DG4VIS_USE_RAYTRACERX" 
	           "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};" 
	           "${Geant4_CORE_LIBRARIES};${XERCESC_LIBRARIES};${CLHEP_LIBRARIES};${Geant4_VIS_LIBRARIES};${Geant4_VIS_RAYTRACER_LIBRARY}")


           #
	       # ASCIITree
           #
	       find_library(Geant4_VIS_ASCIITREE_LIBRARY
	           NAMES G4Tree
	           PATHS ${Geant4_ROOT_DIR}
	           PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
	           DOC "Path to Geant4 ASCIITree visualization library"
	           NO_DEFAULT_PATH)

           #
	       # HepRep
           #
	       find_library(Geant4_VIS_HEPREP_LIBRARY
	           NAMES G4visHepRep
	           PATHS ${Geant4_ROOT_DIR}
	           PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
	           DOC "Path to Geant4 HepRep visualization library"
	           NO_DEFAULT_PATH)

           #
           # VisXXX
           #
	       find_library(Geant4_VIS_VISXXX_LIBRARY
	           NAMES G4visXXX
	           PATHS ${Geant4_ROOT_DIR}
	           PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
	           DOC "Path to Geant4 visXXX visualization library"
	           NO_DEFAULT_PATH)

           #
           # gMocren
           #
           #
	       find_library(Geant4_VIS_GMOCREN_LIBRARY
	           NAMES G4GMocren
	           PATHS ${Geant4_ROOT_DIR}
	           PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
	           DOC "Path to Geant4 gMocren visualization library"
	           NO_DEFAULT_PATH)


           #
           # gl2ps
           # Because OpenGL needs this...
           #
           find_library(Geant4_VIS_GL2PS_LIBRARY
               NAMES G4gl2ps
               PATHS ${Geant4_ROOT_DIR}
               PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
               DOC "Path to Geant4 gl2ps visualization library"
               NO_DEFAULT_PATH)

           #
           # OpenGL
           #
	       find_library(Geant4_VIS_OPENGL_LIBRARY
	           NAMES G4OpenGL
	           PATHS ${Geant4_ROOT_DIR}
	           PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
	           DOC "Path to Geant4 OpenGL visualization library"
	           NO_DEFAULT_PATH)

           # - Lots of possible components to this - need to check them all!!
           # Note that we have to include interfaces lib
	       CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_VIS_OPENGLX
	           "#include \"G4OpenGLImmediateX.hh\"
	           int main(int argc, char** argv)
	           {
	               G4OpenGLImmediateX a;
	           }"
	           "-DG4VIS_USE_OPENGLX" 
	           "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};" 
	           "${Geant4_CORE_LIBRARIES};${Geant4_INTERFACES_LIBRARY};${XERCESC_LIBRARIES};${CLHEP_LIBRARIES};${Geant4_VIS_LIBRARIES};${Geant4_VIS_GL2PS_LIBRARY};${Geant4_VIS_OPENGL_LIBRARY}")

	       CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_VIS_OPENGLXM
	           "#include \"G4OpenGLImmediateXm.hh\"
	           int main(int argc, char** argv)
	           {
	               G4OpenGLImmediateXm a;
	           }"
	           "-DG4VIS_USE_OPENGLXM" 
	           "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};" 
	           "${Geant4_CORE_LIBRARIES};${Geant4_INTERFACES_LIBRARY};${CLHEP_LIBRARIES};${Geant4_VIS_LIBRARIES};${Geant4_VIS_OPENGL_LIBRARY}")

	       CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_VIS_OPENGLQT
	           "#include \"G4OpenGLImmediateQt.hh\"
	           int main(int argc, char** argv)
	           {
	               G4OpenGLImmediateQt a;
	           }"
	           "-DG4VIS_USE_OPENGLQT" 
	           "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};" 
	           "${Geant4_CORE_LIBRARIES};${Geant4_INTERFACES_LIBRARY};${CLHEP_LIBRARIES};${XERCESC_LIBRARIES};${Geant4_VIS_LIBRARIES};${Geant4_VIS_GL2PS_LIBRARY};${Geant4_VIS_OPENGL_LIBRARY}")

           if (WIN32)
    	       CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_VIS_OPENGLWIN32
	               "#include \"G4OpenGLImmediateWin32.hh\"
	               int main(int argc, char** argv)
	               {
	                   G4OpenGLImmediateWin32 a;
	            }"
	            "-DG4VIS_USE_OPENGLWIN32" 
	            "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};" 
                "${Geant4_CORE_LIBRARIES};${Geant4_INTERFACES_LIBRARY};${CLHEP_LIBRARIES};${Geant4_VIS_LIBRARIES};${Geant4_VIS_OPENGL_LIBRARY}")
           endif (WIN32)

           #
           # OpenInventor
           #
	       find_library(Geant4_VIS_OPENINVENTOR_LIBRARY
	           NAMES G4OpenInventor
	           PATHS ${Geant4_ROOT_DIR}
	           PATH_SUFFIXES ${Geant4_LIBRARY_DIR_SUFFIXES}
	           DOC "Path to Geant4 OpenInventor visualization library"
	           NO_DEFAULT_PATH)

           # - Check for components of G4OpenInventor
           if (NOT WIN32)
	        CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_VIS_OPENINVENTORX
	               "#include \"G4OpenInventorX.hh\"
	                int main(int argc, char** argv)
	                {
	                       G4OpenInventorX a;
	                }"
	                "-DG4VIS_USE_OIX" 
	                "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};" 
	                "${Geant4_CORE_LIBRARIES};${CLHEP_LIBRARIES};${Geant4_VIS_LIBRARIES};${Geant4_VIS_OPENINVENTOR_LIBRARY}")

            else (NOT WIN32)
    	       CHECK_GEANT4_CLASS_EXISTS(HAVE_GEANT4_VIS_OPENINVENTORWIN32
	               "#include \"G4OpenInventorWin32.hh\"
	               int main(int argc, char** argv)
	               {
	                   G4OpenInventorWin32 a;
	            }"
	            "-DG4VIS_USE_OIWIN32" 
	            "${Geant4_INCLUDE_DIR};${CLHEP_INCLUDE_DIRS};" 
                "${Geant4_CORE_LIBRARIES};${CLHEP_LIBRARIES};${Geant4_VIS_LIBRARIES};${Geant4_VIS_OPENGL_LIBRARY}")
           endif (NOT WIN32)

           #
           # Mark all vis driver libs as advanced
           #
           mark_as_advanced(
               Geant4_VIS_DAWN_LIBRARY
               Geant4_VIS_RAYTRACER_LIBRARY
               Geant4_VIS_ASCITREE_LIBRARY
               Geant4_VIS_HEPREP_LIBRARY
               Geant4_VIS_VISXXX_LIBRARY
               Geant4_VIS_OPENGL_LIBRARY
               Geant4_VIS_OPENINVENTOR_LIBRARY
           )

        endif (Geant4_VIS_MANAGEMENT_LIBRARY)

    endif (Geant4_ROOT_DIR)
endif ()

#
# Form final library lists indicating if Geant4 was found - only core for
# now.
# We'll need to implement a COMPONENTS type structure for the vis and UI...
#
set(Geant4_LIBRARIES ${Geant4_CORE_LIBRARIES} ${CLHEP_LIBRARIES})

if(Geant4_HAVE_GDML)
    list(APPEND Geant4_LIBRARIES ${XERCESC_LIBRARIES})
endif()

set(Geant4_INCLUDE_DIRS ${Geant4_INCLUDE_DIR} ${CLHEP_INCLUDE_DIRS})



include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Geant4 "Failed to find Geant4"
    Geant4_VERSION_OK Geant4_LIBRARIES Geant4_INCLUDE_DIRS)

