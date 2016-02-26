#ifndef GDMLCMDLINEPARSER_HH
#define GDMLCMDLINEPARSER_HH

//=============================================================================
// Author     : Ben Morgan
// Company    : University of Warwick
// Description: Boost Program Options command line parser for the gdmlview
//              application.
//
// Copyright (c) 2010 Ben Morgan, University of Warwick
//
// Redistribution and use is allowed according to the terms of the GPL license.
//=============================================================================


#include <boost/program_options.hpp>
namespace bpo = boost::program_options;

class GdmlCmdLineParser 
{
    public:
        GdmlCmdLineParser(int argc, char** argv);
        ~GdmlCmdLineParser();

        void parse();

        //----- Functions for clients to access information
        std::string gdml_file() const;
        std::string shell_name() const;

    private:
        void display_help();
        void post_process();

    private:
        int argC_;
        char** argV_;

        bpo::options_description options_;
        bpo::positional_options_description pos_options_;
        bpo::variables_map       variables_;
};



#endif // GDMLCMDLINEPARSER_HH

