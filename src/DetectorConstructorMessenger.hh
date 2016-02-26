#ifndef DETECTORCONSTRUCTORMESSENGER_HH
#define DETECTORCONSTRUCTORMESSENGER_HH

//=============================================================================
// Author     : Ben Morgan
// Company    : University of Warwick
// Description: User interface for DetectorConstructor
//
// Copyright (c) 2010 Ben Morgan, University of Warwick
//
// Redistribution and use is allowed according to the terms of the  license.
//=============================================================================

#include "G4UImessenger.hh"

class G4UIcommand;
class G4UIdirectory;
class G4UIcmdWithoutParameter;

namespace latte {
    namespace geometry {

        class DetectorConstructor;

        class DetectorConstructorMessenger : public G4UImessenger
        {
            public:
                DetectorConstructorMessenger(DetectorConstructor* messengedObject);
                virtual ~DetectorConstructorMessenger();

                void SetNewValue(G4UIcommand* cmd, G4String args);

            private:
                DetectorConstructor*       pMessengedDetector_;

                G4UIdirectory*		       pRootDirectory_;
                G4UIcmdWithoutParameter*   pUpdateCmd_;
        };
    } // namespace geometry
} // namespace latte
#endif // DETECTORCONSTRUCTORMESSENGER_HH
