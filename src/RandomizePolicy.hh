#ifndef RANDOMIZEPOLICY_HH
#define RANDOMIZEPOLICY_HH

//=============================================================================
// Author     : Ben Morgan
// Company    : University of Warwick
// Description: Policies for configuring the random number generator used
//              in Geant4 simulations.
//
// Copyright (c) 2010 Ben Morgan, University of Warwick
//
// Redistribution and use is allowed according to the terms of the GPL license.
//=============================================================================

#include "Randomize.hh"

namespace latte {
    namespace random {

        struct SeedOnSystemTime
        {
            static void configure()
            {
                CLHEP::HepRandom::setTheEngine(new CLHEP::RanecuEngine);

                long seeds[2];
                time_t systime(time(NULL));

                seeds[0] = static_cast<long>(systime);
                seeds[1] = static_cast<long>(systime*G4UniformRand());

                CLHEP::HepRandom::setTheSeeds(seeds);
            }
        };

    } // namespace random

    namespace random {
        typedef SeedOnSystemTime DefaultRandomizePolicy;
        
    } // namespace random
    
} // namespace latte


#endif // RANDOMIZEPOLICY_HH

