clean-cluster:
	/bin/bash ./cluster/delete.sh

build-docker:
	/bin/bash ./cluster/build-docker.sh

local-cluster: build-docker clean-cluster
	/bin/bash ./cluster/build.sh
