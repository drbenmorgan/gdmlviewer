#ifndef GDMLGEOMETRYCONSTRUCTORMESSENGER_HH_
#define GDMLGEOMETRYCONSTRUCTORMESSENGER_HH_

#include "G4UImessenger.hh"

class G4UIcommand;
class G4UIdirectory;
class G4UIcmdWithAString;

namespace latte
{
    class GDMLGeometryConstructor;

    class GDMLGeometryConstructorMessenger : public G4UImessenger
    {
        public:
            GDMLGeometryConstructorMessenger(GDMLGeometryConstructor* messengedObject);
            virtual ~GDMLGeometryConstructorMessenger();

            void SetNewValue(G4UIcommand* cmd, G4String args);

        private:
            GDMLGeometryConstructor*       pMessengedDetector_;

            G4UIcmdWithAString*   pReadFileCmd_;

    };
}
#endif /*GDMLGEOMETRYCONSTRUCTORMESSENGER_HH_*/
