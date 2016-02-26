#include "DetectorConstructorMessenger.hh"

#include "DetectorConstructor.hh"
#include "G4UIdirectory.hh"
#include "G4UIcmdWithoutParameter.hh"

namespace latte {
    namespace geometry {
    
        DetectorConstructorMessenger::DetectorConstructorMessenger(DetectorConstructor* messengedObject) : G4UImessenger(), pMessengedDetector_(messengedObject), pRootDirectory_(0), pUpdateCmd_(0)
        {
            //----- Default Constructor

            pRootDirectory_ = new G4UIdirectory("/gdmlview/");
            pRootDirectory_->SetGuidance("UI commands to control detector geometry");

            pUpdateCmd_ = new G4UIcmdWithoutParameter("/gdmlview/update",this);
            pUpdateCmd_->SetGuidance("clean and reconstruct geometry");
            pUpdateCmd_->SetGuidance("must be performed after any changes to geometry and before beamOn");
            pUpdateCmd_->AvailableForStates(G4State_Idle);

        }

        DetectorConstructorMessenger::~DetectorConstructorMessenger()
        {
            //----- Destructor
            delete pUpdateCmd_;
            delete pRootDirectory_;
        }


        void DetectorConstructorMessenger::SetNewValue(G4UIcommand* cmd, G4String args)
        {
            //----- Messenge object
            if ( cmd == pUpdateCmd_) {
                pMessengedDetector_->UpdateDetector();
            }
        }
    } // namespace geometry
} // namespace latte
