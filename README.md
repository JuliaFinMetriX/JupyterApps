This repository hosts the source code of my IJulia notebook files. 

## Viewing options
#### Static html view

In order to view notebooks as rendered html output, simply access them
on
[nbviewer](http://nbviewer.ipython.org/github/cgroll/ijuliaNb/tree/master/).

#### Formatted output

Some of the notebooks exist in richer output formats e.g. as html
slides. You can find them under section *slides* on my [github
homepage](http://cgroll.github.io/). 

#### Interactive view: using docker

If you want to interactively run the notebook yourself, in order to be
able to modify code blocks and text, simply use the
[juliafinmetrix/jfinm_stable](https://registry.hub.docker.com/u/juliafinmetrix/jfinm_stable/)
docker container as virtual environment to do so. This container is
regularly updated, and any new version usually is only published if
all notebooks in this repository and some other repositories run
without errors out of the box.

You can either start the docker container right away with
````
apt-get install docker.io
docker run -p 8888:8888 juliafinmetrix/jfinm_stable
````
or mount the current working directory in order to be able to keep
any changes made even outside of the container. Therefore, make
notebook directory your present working directory, and run

````
docker run -p 8888:8888 -v $PWD:/home/jovyan/mount/ -w \
  /home/jovyan/mount/ juliafinmetrix/jfinm_stable 
````

Note: Don't forget to switch the jupyter kernel to Julia.

## Testing

- new notebooks can be tested against local, stable or dev julia
  versions 
- all notebooks can be tested together
  - required for docker image testing
  - for more details, take a look at the docker images' *Makefile*

`make` defaults to testing the current notebook target with the
`jfinm_stable` docker image.

Any test will take all `.jl` files from a given list as target. Then,
the respective `.ipynb` source files are converted to `.py` and moved
to folder `test`. All these files then can be tested either
individually or simultaneously together, with either your local Julia
install or docker images *jfinm_stable* or *jfinm_dev*.

You can manually run tests for all listed notebooks together. For
example, simply run `make test_stable` to test all notebooks with the
stable docker image. However, for a given docker image usually all
notebook files should already have been tested, so that you should
need to run tests only for the current target in this repository.

The comprehensive test suite for all notebook files will be called
during the creation of any docker images.


## Adding notebooks

- add file directory to Makefile `vpath` (then: only file stem needed)
- during development: 
  - make file with `.jl` extension the current target
- after development:
  - add file with `.jl` extension to Makefile list of tests 
  - add automatic publishing to `slides` repository's Makefile
    (calling `make` there will pull, convert and publish notebook
    file)

In order to interactively develop a new notebook, use
`juliafinmetrix/jfinm_stable` as development environment. With this
directory as current directory, call:

````
jup_stable
````

This resolves to:
````
docker run -p 8888:8888 -v $PWD:/home/jovyan/mount/ -w \
  /home/jovyan/mount/ juliafinmetrix/jfinm_stable 
````

If problems occur with current package releases use `jup_dev` as
development environment.


## Publishing

If the notebook file should be published in other rich formats as well
include the respective commands to the `slides` repository's Makefile.
All publishing activities (conversion, upload) will happen there.

## Notes on reproducability

Different meanings of reproduction:
- allow reproduction of original notebook output, perfectly matching
  text and descriptions
  - keep data in version control:
    - data/input
    - data/results
  - keep original code on notebook in version control
  - show exact state of software (versioninfo)
  - keep random seed
- repeating analysis with current and recent software
  - notebook always needs to run without errors in current stable
    docker image
  - data needs to be downloaded again instead of using private data
    submodule from version control



      
