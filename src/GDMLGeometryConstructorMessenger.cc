#include "GDMLGeometryConstructorMessenger.hh"

#include "GDMLGeometryConstructor.hh"
#include "G4UIdirectory.hh"
#include "G4UIcmdWithAString.hh"

namespace latte
{
    GDMLGeometryConstructorMessenger::GDMLGeometryConstructorMessenger(GDMLGeometryConstructor* messengedObject) : G4UImessenger(), pMessengedDetector_(messengedObject),
    pReadFileCmd_(0)
    {
        //----- Default Constructor


        pReadFileCmd_ = new G4UIcmdWithAString("/gdmlview/read",this);
        pReadFileCmd_->SetGuidance("read a GDML file to use as geometry");
        pReadFileCmd_->SetParameterName("file", true);
        pReadFileCmd_->AvailableForStates(G4State_PreInit, G4State_Idle);

    }

    GDMLGeometryConstructorMessenger::~GDMLGeometryConstructorMessenger()
    {
        //----- Destructor
        delete pReadFileCmd_;
    }


    void GDMLGeometryConstructorMessenger::SetNewValue(G4UIcommand* cmd, G4String args)
    {
        //----- Messenge object
        if ( cmd == pReadFileCmd_) {
            pMessengedDetector_->Read(args);
        }
    }
}
