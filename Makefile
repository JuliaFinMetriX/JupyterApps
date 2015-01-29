## tell make where to look for targets and dependencies
vpath %.jl test
vpath %.ipynb julia:basic_statistics

## list of targets
JL_FILES := iterators_comprehensions_and_map.jl \
				linear_model.jl \
				julia_features.jl

all: tests

tests: $(JL_FILES)
	julia -e 'include("runall.jl")'

%.jl: %.ipynb
	ipython nbconvert --to python $<; \
	mv $(*F).py test/$(*F).jl

clean:
	cd test; rm *