//=============================================================================
// Author     : Ben Morgan
// Company    : University of Warwick
// Description: Boost Program Options parser for gdmlview application
//
// Copyright (c) 2010 Ben Morgan, University of Warwick
//
// Redistribution and use is allowed according to the terms of the GPL license.
//=============================================================================

#include "GdmlCmdLineParser.hh"
#include <string>
#include <cstdlib>
#include <iostream>

GdmlCmdLineParser::GdmlCmdLineParser(int argc, char** argv) : argC_(argc), argV_(argv), options_("gdmlview options"), pos_options_(), variables_()
{
    //----- Constructor - just add options to the description
    options_.add_options()
        ("help,h", "print help message")
        ("shell,s",bpo::value<std::string>()->default_value("qt"), "start interactive session")
        ("gdml-file,f",bpo::value<std::string>(), "open GDML file");


    pos_options_.add("gdml-file", -1);
}


GdmlCmdLineParser::~GdmlCmdLineParser()
{;}


void GdmlCmdLineParser::parse()
{
    //----- Parse the command line supplied

    //try and parse, fail and exit if we don't recognize an option
    try {
        bpo::store(bpo::command_line_parser(argC_,argV_).options(options_).positional(pos_options_).run(), variables_);
    }
    catch (bpo::unknown_option) {
        this->display_help();
        exit(EXIT_FAILURE);
    }

    //We parsed o.k., so store and then perform any post-processing needed
    bpo::notify(variables_);
    this->post_process();
}


std::string GdmlCmdLineParser::gdml_file() const
{
    return variables_["gdml-file"].as<std::string>();
}

std::string GdmlCmdLineParser::shell_name() const
{
    return variables_["shell"].as<std::string>();
}



void GdmlCmdLineParser::display_help()
{
    //----- Output options description to stderr
    std::cerr<<options_<<std::endl;
}

void GdmlCmdLineParser::post_process()
{
    //----- Check whether help was requested

    if(variables_.count("help")) {
        this->display_help();
        exit(EXIT_SUCCESS);
    }
}


