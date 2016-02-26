#ifndef GDMLGEOMETRYCONSTRUCTOR_HH
#define GDMLGEOMETRYCONSTRUCTOR_HH

#include "IGeometryConstructor.hh"
#include "G4String.hh"

namespace latte {
    class GDMLGeometryConstructorMessenger;

    class GDMLGeometryConstructor : public latte::geometry::IGeometryConstructor
    {
        public:
            GDMLGeometryConstructor();
            virtual ~GDMLGeometryConstructor();

            G4VPhysicalVolume* Construct();

            void Read(const G4String& gdmlFile);
            void SelectSetup(const G4String& setupName);

        private:
            G4String gdmlFile_;
            G4String setupName_;
            GDMLGeometryConstructorMessenger* pMessenger_;
    };

}
#endif
