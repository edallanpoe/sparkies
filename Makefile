prepare-fs:
	/bin/bash --debug ./src/package_py_depths.sh
	mkdir -p /tmp/scripts-volume
	chmod -R 750 /tmp/scripts-volume

clean-cluster:
	/bin/bash --debug ./cluster/delete.sh

build-docker:
	/bin/bash --debug ./cluster/build-docker.sh

local-cluster: prepare-fs build-docker clean-cluster
	/bin/bash --debug ./cluster/build.sh
