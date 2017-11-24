
ifeq ($(ws_version), )
	# @echo "===version is null, version is latest==="
	ws_version := latest
else
	ws_version := $(ws_version)
endif

ifeq ($(ml_version), )
@echo "===version is null, version is latest==="
	ml_version := latest
else
@echo "===version is null, version is latest==="
	ml_version := $(ml_version)
endif


ifeq ($(spider_version), )
	# @echo "===version is null, version is latest==="
	spider_version := latest
else
	spider_version := $(spider_version)
endif

build_py27_ws:
	echo $(ws_version)
	cd py27-ws && \
		make buildimage ws_version=$(ws_version)

build_py27_ml:
	echo $(ml_version)
	cd py27-ml && \
		make buildimage ml_version=$(ml_version)


build_py27_spider:
	cd py27-spider && \
		make buildimage spider_version=$(spider_version)

#build_all: build_py27_ml build_py27_ws build_py27_spider
