#ifndef IGEOMETRYCONSTRUCTOR_HH
#define IGEOMETRYCONSTRUCTOR_HH

//=============================================================================
// Author     : Ben Morgan
// Company    : University of Warwick
// Description: PABC for objects constructing geometries
//
// Copyright (c) 2010 Ben Morgan, University of Warwick
//
// Redistribution and use is allowed according to the terms of the  license.
//=============================================================================

class G4VPhysicalVolume;

namespace latte {
    namespace geometry {

        class IGeometryConstructor {
            public:
                IGeometryConstructor() {;}
                virtual ~IGeometryConstructor() {;}

                virtual G4VPhysicalVolume* Construct()=0;
        };

    } // namespace geometry
} //namespace latte
#endif // IGEOMETRYCONSTRUCTOR_HH
