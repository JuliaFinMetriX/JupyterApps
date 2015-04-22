## tell make where to look for targets and dependencies
## vpath %.jl test
vpath %.ipynb julia:basic_statistics:worldBankData

## list of targets
JL_FILES := iterators_comprehensions_and_map.jl \
				linear_model.jl \
				julia_features.jl \
				world_bank_data.jl

CURRENT := world_bank_data.jl

# path to tested notebook files
NBS_PATH := $(HOME)/research/ijuliaNb
DOCK_STABLE := juliafinmetrix/jfinm_stable
DOCK_DEV := juliafinmetrix/jfinm_stable
DOCK_HOME := /home/jovyan
DOCK_MOUNT := $(DOCK_HOME)/mount

default: current_stable

current_local: $(CURRENT)
	julia -e 'cd("test"); include("$<"); cd("..")'

current_stable: $(CURRENT)
	docker run --rm -v $(NBS_PATH):$(DOCK_MOUNT) -w $(DOCK_MOUNT)/test $(DOCK_STABLE) julia -e 'include("$<")'

current_dev: $(CURRENT)
	docker run --rm -v $(NBS_PATH):$(DOCK_MOUNT) -w $(DOCK_MOUNT)/test $(DOCK_DEV) julia -e 'include("$<")'

test_local: $(JL_FILES)
	julia -e 'cd("test"); include("test/runall.jl"); cd("..")'

test_stable: $(JL_FILES)
	docker run --rm -v $(NBS_PATH):$(DOCK_MOUNT) -w $(DOCK_MOUNT)/test $(DOCK_STABLE) julia -e 'include("../runall.jl")';

test_dev: $(JL_FILES)
	docker run --rm -v $(NBS_PATH):$(DOCK_MOUNT) -w $(DOCK_MOUNT)/test $(DOCK_DEV) julia -e 'include("../runall.jl")';

INFO_TEXT := make allows testing with three different versions: local Julia version \(default\), jfinm_stable and jfinm_dev. In any case, make first converts all listed notebook files to julia files in directory test/.

info:
	echo $(INFO_TEXT) \
	& echo \
	& echo

%.jl: %.ipynb
	ipython nbconvert --to python $<; \
	mv $(*F).py test/$(*F).jl

clean:
	cd test; rm *
