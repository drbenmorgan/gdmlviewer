#include "GDMLGeometryConstructor.hh"
#include "GDMLGeometryConstructorMessenger.hh"

#include "G4GDMLParser.hh"
#include "G4LogicalVolume.hh"

namespace latte
{

    GDMLGeometryConstructor::GDMLGeometryConstructor() : latte::geometry::IGeometryConstructor(), gdmlFile_(), setupName_("Default"), pMessenger_(0)
    {
        //----- Default constructor
        pMessenger_ = new GDMLGeometryConstructorMessenger(this);
    }

    GDMLGeometryConstructor::~GDMLGeometryConstructor()
    {
        //----- Destructor
        delete pMessenger_;
    }

    G4VPhysicalVolume* GDMLGeometryConstructor::Construct()
    {
        //----- Construct world volume
        //parser is only needed for the lifetime of this method.
        G4GDMLParser parser_;
        parser_.Read(gdmlFile_);

        G4VPhysicalVolume* pWorld = parser_.GetWorldVolume(setupName_);
        //----- GDML parser makes world invisible, this is a hack to make it
        //visible again...
        G4LogicalVolume* pWorldLogical = pWorld->GetLogicalVolume();
        pWorldLogical->SetVisAttributes(0);
        return pWorld;
    }

    void GDMLGeometryConstructor::Read(const G4String& gdmlFile)
    {
        //----- read from the supplied gdml file
        gdmlFile_ = gdmlFile;
    }

}
