#include "GdmlCmdLineParser.hh"
#include "RandomizePolicy.hh"
#include "UISessionFactory.hh"
#include "DetectorConstructor.hh"
#include "ExN01PhysicsList.hh"
#include "PrimaryGeneratorAction.hh"


#include "G4RunManager.hh"
#include "G4VisExecutive.hh"

int main(int argc, char** argv)
{
    //----- Parse command line args.
    GdmlCmdLineParser psr(argc,argv);
    psr.parse();

    //----- Check for interactive session, and start if needed
    std::string userSession(psr.shell_name());

    std::string userGdmlFile;

    try {
        userGdmlFile = psr.gdml_file();
    }
    catch (boost::bad_any_cast) {
        std::cerr<<"gdmlview: missing file operand"<<std::endl;
        std::cerr<<"Try `gdmlview --help' for more information."<<std::endl;
        return 1;
    }

    boost::shared_ptr<G4UIsession> session;

    if(userSession != "") {
        latte::UISessionFactory uif = latte::BuildUISessionFactory();
        session = boost::shared_ptr<G4UIsession>(uif.CreateProduct(userSession,argc,argv));
        if(!session) {
            std::cerr<<"gdmlview does not recognize the session \""<<userSession<<"\""<<std::endl;
            exit(EXIT_FAILURE);
        }
    }

    //----- Initialize random number generation.
    latte::random::DefaultRandomizePolicy::configure();

    //----- Setup Kernel and user modules.
    boost::shared_ptr<G4RunManager> rm(new G4RunManager());
    rm->SetUserInitialization(new latte::geometry::DetectorConstructor);
    rm->SetUserInitialization(new ExN01PhysicsList);
    rm->SetUserAction(new latte::generator::PrimaryGeneratorAction);

    
    //----- We should now be able to open the session and initialize everything
    // We want visualization...
    boost::shared_ptr<G4VisManager> pVisManager(new G4VisExecutive);

    // But make it shut the hell up.
    //pVisManager->SetVerboseLevel(G4VisManager::quiet);
    pVisManager->Initialize();

    // Pre apply commands needed to start up, open supplied gdmlfile
    // and fire up visualization
    G4UImanager* uiMan = G4UImanager::GetUIpointer();
    uiMan->ApplyCommand("/gdmlview/read "+userGdmlFile);
    uiMan->ApplyCommand("/gdmlview/update");
    rm->Initialize();

    uiMan->ApplyCommand("/vis/scene/create");
    if (userSession == "qt") {
        uiMan->ApplyCommand("/vis/open OGLSQt 800 600");
    }
    else {
        uiMan->ApplyCommand("/vis/open OGLSX 800 600");
    }
    uiMan->ApplyCommand("/vis/viewer/flush");
    uiMan->ApplyCommand("/vis/scene/add/trajectories");

    // Start the session
    session->SessionStart();
    

    //----- Cleanup and finish
    return 0;
}


