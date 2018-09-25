.PHONY: setup burn assets firmware burn upload
all: build upload
setup:
	export MIX_ENV=prod && \
	  cd ui && \
	  mix deps.get && \
	  cd assets && \
	  npm install
build: assets firmware
assets:
	export MIX_ENV=prod && \
	  cd ui/assets && \
	  node_modules/brunch/bin/brunch build --production && \
	  cd ../ && \
	  mix phx.digest
firmware:
	export MIX_ENV=prod && \
	  export MIX_TARGET=rpi2 && \
	  cd firmware && \
	  mix deps.get && \
	  mix firmware
burn:
	export MIX_ENV=prod && \
	  export MIX_TARGET=rpi2 && \
	  cd firmware && \
	  mix firmware.burn
upload:
	export MIX_ENV=prod && \
	  export MIX_TARGET=rpi2 && \
	  cd firmware && \
	  ./upload.sh
