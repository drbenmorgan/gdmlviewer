#include "PrimaryGeneratorAction.hh"
#include "G4GeneralParticleSource.hh"

namespace latte {
    namespace generator {

        PrimaryGeneratorAction::PrimaryGeneratorAction() : G4VUserPrimaryGeneratorAction(), pGunImpl_(0)
                                                           //(new G4GeneralParticleSource)
        {
            //----- Default Constructor
            pGunImpl_ = new G4GeneralParticleSource();
        }


        PrimaryGeneratorAction::~PrimaryGeneratorAction()
        {
            //----- Destructor
            delete pGunImpl_;
        }


        void PrimaryGeneratorAction::GeneratePrimaries(G4Event* anEvent)
        {
            //----- add primary particles to the supplied G4Event
            pGunImpl_->GeneratePrimaryVertex(anEvent);
        }


        void PrimaryGeneratorAction::SelectPrimaryGenerator(const G4String& id)
        {
            // Change to a new primary generator
            // Use internal Create method as proxy for full Factory method
            G4VPrimaryGenerator* pNewPG = this->Create(id);

            if(pNewPG) {
                delete pGunImpl_;
                pGunImpl_ = pNewPG;
            }

            return;
        }


        G4VPrimaryGenerator* PrimaryGeneratorAction::Create(const G4String& id)
        {
            return new G4GeneralParticleSource();
        }
                

    } // namespace generator
} // namespace latte
