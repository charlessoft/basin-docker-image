ifeq ($(base_image_spider_version), )
	# @echo "===version is null, version is latest==="
	base_image_spider_version := latest
else
	base_image_spider_version := $(base_image_spider_version)
endif
buildimage:
	# 编译镜像版本
	@echo "build base_image py27-spider $(base_image_spider_version)"
	docker build -t basin/py27-spider:$(base_image_spider_version)  .
