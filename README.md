This repository hosts the source code of my iJulia notebook files. 

## Static html view

In order to view notebooks as rendered html output, simply access them
on
[nbviewer](http://nbviewer.ipython.org/github/cgroll/ijuliaNb/tree/master/).

## Formatted output

Some of the notebooks exist in richer output formats e.g. as html
slides. You can find them on my [github
homepage](http://cgroll.github.io/). 

## Interactive view

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
or mount the current working directory in order to by able to keep
any changes made even outside of the container:

````
docker run -p 8888:8888 -v $PWD:/home/jovyan/mount/ -w \
  /home/jovyan/mount/ juliafinmetrix/jfinm_stable 
````

Note: Don't forget to switch the jupyter kernel to Julia.

## Testing

- required for new notebooks
- automatically called during `juliafinmetrix/jfinm_stable` build

Since the repository serves as a requirement for the
`juliafinmetrix/jfinm_stable` image, it comes with a `Makefile` that
allows running all notebooks as batch jobs:

````
make tests
````

This will take any `.jl` file from a given list as target. Then, it
finds its respective `.ipynb` source file, converts it to `.py`, moves
it to folder `test` and runs all files in `test` with your local Julia
install.

In general, there should be no need for you to personally run all
tests, since I will automatically run them during the building of
`juliafinmetrix/jfinm_stable`, and hence all notebooks should be bug
free in combination with this docker container.

However, the test suite is called during each build of
`juliafinmetrix/jfinm_stable`. Therefore, the local version is mounted
into the container, in order to be able to re-use already downloaded
data inside of git submodules. Then, the Makefile will be run inside
the container:

````
docker run --rm -v $PWD:/home/jovyan/mount/ -w \
  /home/jovyan/mount/ juliafinmetrix/jfinm_stable make
````

## Adding notebooks

- add file with `.jl` extension to Makefile list of tests
- add directory to Makefile `vpath`
- add automatic publishing to `slides` repository's Makefile 

In order to interactively develop a new notebook, use
`juliafinmetrix/jfinm_stable` as development environment:

````
docker run -p 8888:8888 -v $PWD:/home/jovyan/mount/ -w \
  /home/jovyan/mount/ juliafinmetrix/jfinm_stable 
````

Once the notebook is finished, add it to the Makefile so that it
becomes part of the test suite that needs to pass for the creation of
a new `juliafinmetrix/jfinm_stable` image.

Re-run tests with `juliafinmetrix/jfinm_stable`:

````
docker run --rm -v $PWD:/home/jovyan/mount/ -w \
  /home/jovyan/mount/ juliafinmetrix/jfinm_stable make
````

## Publishing

If the notebook file should be published in other rich formats as well
include the respective commands to the `slides` repository's Makefile.


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



      
