## tell make where to look for targets and dependencies
## vpath %.jl testFiles
vpath %.ipynb julia:basic_statistics:worldBankData
vpath %.jl julia:basic_statistics:worldBankData

## list of targets
JL_FILES := iterators_comprehensions_and_map.jl \
				julia_features.jl \
				NA_missing_observations.jl

CURRENT := dynAssMgmt/dynamic_asset_management.jl

# path to tested notebook files
NBS_PATH := $(HOME)/research/ijuliaNb
DOCK_STABLE := juliafinmetrix/jfinm_stable
DOCK_DEV := juliafinmetrix/jfinm_stable
DOCK_HOME := /home/jovyan
DOCK_MOUNT := $(DOCK_HOME)/mount

default: current_stable

current_local: $(CURRENT)
	julia -e 'cd("testFiles"); include("$<"); cd("..")'

current_stable: $(CURRENT)
	docker run --rm -v $(NBS_PATH):$(DOCK_MOUNT) -w $(DOCK_MOUNT)/testFiles $(DOCK_STABLE) julia -e 'include("$<")'

current_dev: $(CURRENT)
	docker run --rm -v $(NBS_PATH):$(DOCK_MOUNT) -w $(DOCK_MOUNT)/testFiles $(DOCK_DEV) julia -e 'include("$<")'

test_local: $(JL_FILES)
	julia -e 'cd("test"); include("runall.jl")'

test_stable: $(JL_FILES)
	docker run --rm -v $(NBS_PATH):$(DOCK_MOUNT) -w $(DOCK_MOUNT)/test $(DOCK_STABLE) julia -e 'include("runall.jl")';

test_dev: $(JL_FILES)
	docker run --rm -v $(NBS_PATH):$(DOCK_MOUNT) -w $(DOCK_MOUNT)/test $(DOCK_DEV) julia -e 'include("runall.jl")';

INFO_TEXT := make allows testing with three different versions: local Julia version \(default\), jfinm_stable and jfinm_dev. In any case, make first converts all listed notebook files to julia files in directory testFiles/.

info:
	echo $(INFO_TEXT) \
	& echo \
	& echo

CONVERTED_AND_MOVED: 

clean:
	cd testFiles; rm *; cd -

%.jl: %.ipynb clean
	jupyter nbconvert --to python $<; \
	mv $(basename $(<D)/$(<F)).py testFiles/$(*F).jl

