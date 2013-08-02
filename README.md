tagmanager
==========

A simple tag manager for directories written in *bash*.

Matches directory and empty file (tags) names to a list of input strings, 
prints bottom directories containing all input tags to stdout. Tags must
be empty files, simple to create using e. g. *touch*.

Example
---
A year/month ordered directory structure from the current directory:

    .
    2012/
    2012/01/Simulation/result
    2013/01/
    2013/01/Simulation/
    2013/01/Simulation/result
    2013/01/Preparation/result
    2013/02/Simulation/result
    
Finding folders that are tagged by the label file 'result' and January 2013
is done by:

    $ ./tags.sh 2013 01 result
    .2013/01/Simulation/result
    .2013/01/Preparation/result
