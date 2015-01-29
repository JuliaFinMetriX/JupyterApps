This repository hosts the source code of my iJulia notebook files. 

## Static html view

In order to view notebooks as rendered html output, simply access them
on
[nbviewer](http://nbviewer.ipython.org/github/cgroll/ijuliaNb/tree/master/).

## Interactive view

If you want to interactively run the notebook yourself, in order to be
able to modify code blocks and text, simply use the
[juliafinmetrix/jfinm_stable](https://registry.hub.docker.com/u/juliafinmetrix/jfinm_stable/)
docker container as virtual environment to do so. This container is
regularly updated, and any new version usually is only published if
all notebooks in this repository and some other repositories run
without errors out of the box.

Simply start a new docker container from the present working
directory, and it will be mounted at `$HOME/mount`.

````
sudo apt-get install docker.io

cd /path/to/repository

docker run -p 8888:8888 -v $PWD:/home/jovyan/mount/ -w \
  /home/jovyan/mount/ juliafinmetrix/jfinm_stable 
````

As the present directory is mounted to the docker container your
changes to the files will be visible outside the container, too.

Note: Don't forget to switch the kernel to Julia.

## Testing

In order to run all notebooks as batch jobs with your local julia
install simply run 
````
make tests
````

This will take any .jl file from a list as target. Then, it finds its
respective .ipynb source file, converts it to .py, moves it to folder
`test` and runs all files in `test` with your local julia install.

In general, there should be no need for you to personally run all
tests, since I will automatically run them during the build of
`juliafinmetrix/jfinm_stable`, and hence all notebooks should be bug
free in combination with this docker container.

Personal note: to test all notebooks with the current version of
`juliafinmetrix/jfinm_stable`, its Makefile will run this repository's
Makefile from within the container:

````
docker run --rm -v $PWD:/home/jovyan/mount/ -w \
  /home/jovyan/mount/ juliafinmetrix/jfinm_stable make
````

## Adding notebooks

In order to interactively develop a new notebook, use
`juliafinmetrix/jfinm_stable` as development environment:

````
cd /path/to/repository

docker run -p 8888:8888 -v $PWD:/home/jovyan/mount/ -w \
  /home/jovyan/mount/ juliafinmetrix/jfinm_stable 
````

Once the notebook is finished, add it to the Makefile so that it
becomes part of the test suite that needs to pass for the creation of
a new `juliafinmetrix/jfinm_stable` image:

- add the file with .jl extension to the target list
- add its directory to vpath

Re-run tests with `juliafinmetrix/jfinm_stable`:

````
docker run --rm -v $PWD:/home/jovyan/mount/ -w \
  /home/jovyan/mount/ juliafinmetrix/jfinm_stable make
````

## Publishing

Convert --to slides, --to html

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


      
