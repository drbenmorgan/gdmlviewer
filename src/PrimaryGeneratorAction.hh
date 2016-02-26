#ifndef LATTE_PRIMARYGENERATORACTION_HH
#define LATTE_PRIMARYGENERATORACTION_HH

//=============================================================================
// Author     : Ben Morgan
// Company    : University of Warwick
// Description: Core primary event generator action
//
// Copyright (c) 2010 Ben Morgan, University of Warwick
//
// Redistribution and use is allowed according to the terms of the  license.
//=============================================================================


#include "G4VUserPrimaryGeneratorAction.hh"

class G4Event;
class G4VPrimaryGenerator;
class G4String;

namespace latte {
    namespace generator {

        class PrimaryGeneratorAction : public G4VUserPrimaryGeneratorAction
        {
            public:
                PrimaryGeneratorAction();
                virtual ~PrimaryGeneratorAction();

                virtual void GeneratePrimaries(G4Event* anEvent);

                // Make primary generator selectable
                void SelectPrimaryGenerator(const G4String& id);

            private:
                G4VPrimaryGenerator* Create(const G4String& id);


            private:
                G4VPrimaryGenerator* pGunImpl_;
        };

    } // namespace generator
} // namesapce latte

#endif // LATTE_PRIMARYGENERATORACTION_HH_
