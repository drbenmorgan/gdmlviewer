#ifndef DETECTORCONSTRUCTOR_HH
#define DETECTORCONSTRUCTOR_HH

//=============================================================================
// Author     : Ben Morgan
// Company    : University of Warwick
// Description: Partially pluggable user detector construction class.
//
// Copyright (c) 2010 Ben Morgan, University of Warwick
//
// Redistribution and use is allowed according to the terms of the  license.
//=============================================================================

#include "G4VUserDetectorConstruction.hh"

namespace latte {
    namespace geometry {

        class IGeometryConstructor;
        class DetectorConstructorMessenger;

        class DetectorConstructor : public G4VUserDetectorConstruction
        {
            public:
                //----- Constructor/Destructor
                DetectorConstructor();
                virtual ~DetectorConstructor();

                //----- World Construction method
                G4VPhysicalVolume* Construct();

                //----- Update geometry when changed
                void UpdateDetector();

            private:
                //Clean geometry tree
                void CleanGeometry();

            private:
                DetectorConstructorMessenger* pMessenger_;
                IGeometryConstructor*         pGeometryImpl_;
        };

    } // namespace geometry
} // namespace latte

#endif // DETECTORCONSTRUCTOR_HH
