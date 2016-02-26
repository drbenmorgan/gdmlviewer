#include "DetectorConstructor.hh"
#include "DetectorConstructorMessenger.hh"

#include "IGeometryConstructor.hh"

#include "G4RunManager.hh"
#include "G4GeometryManager.hh"
#include "G4PhysicalVolumeStore.hh"
#include "G4LogicalVolumeStore.hh"
#include "G4SolidStore.hh"

//----- TEMP HACK
// provide default geometry impl
#include "GDMLGeometryConstructor.hh"
typedef latte::GDMLGeometryConstructor DefaultGeometry;

namespace latte {
    namespace geometry {

        DetectorConstructor::DetectorConstructor() : G4VUserDetectorConstruction(),
        pMessenger_(0), pGeometryImpl_(0)
        {
            //Default Constructor
            pMessenger_ = new DetectorConstructorMessenger(this);
            pGeometryImpl_ = new DefaultGeometry();
        }


        DetectorConstructor::~DetectorConstructor()
        {
            //Destructor
            delete pGeometryImpl_;
            delete pMessenger_;
        }

        G4VPhysicalVolume* DetectorConstructor::Construct()
        {
            //Construct physical volume for world and return it
            this->CleanGeometry();
            return pGeometryImpl_->Construct();
        }


        void DetectorConstructor::UpdateDetector()
        {
            //----- Refresh detector geometry
            G4RunManager::GetRunManager()->DefineWorldVolume(this->Construct());
        }


        void DetectorConstructor::CleanGeometry()
        {
            //----- clean the geometry tree
            //
            G4GeometryManager::GetInstance()->OpenGeometry();
            G4PhysicalVolumeStore::GetInstance()->Clean();
            G4LogicalVolumeStore::GetInstance()->Clean();
            G4SolidStore::GetInstance()->Clean();
        }
    } // namespace geometry    
} // namespace latte
