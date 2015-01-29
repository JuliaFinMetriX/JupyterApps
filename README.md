This repository hosts the source code of my iJulia notebook files. To
view them as rendered output, simply access them on
[nbviewer](http://nbviewer.ipython.org/github/cgroll/ijuliaNb/tree/master/).

# Notes on reproducability

- allow to run notebooks with more recent julia installation and
  packages
- enable testing: running notebooks as batch jobs:
  - convert each notebook to .py file
  - move .py file to common directory of same layer (otherwise
    relative paths will not match)
  - rename .py files to .jl files
  - run all notebooks

- different meanings of reproduction:
  - allow reproduction of original notebook output, perfectly matching
    text and descriptions
    - keep data in version control
    - keep original code on notebook in version control
    - show exact state of software
    - keep random seed
  - repeating analysis with current and recent software:
    - notebook always needs to run without errors in current stable
      docker image
    - data needs to be downloaded again instead of using private data
      submodule from version control

data/input
data/results


      
