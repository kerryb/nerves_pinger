.PHONY: setup burn assets firmware ui burn upload
all: build upload
setup:
	export MIX_ENV=prod && \
	  cd ui && \
	  mix deps.get && \
	  cd assets && \
	  npm install
build: firmware ui
assets:
	export MIX_ENV=prod && \
	  cd ui/assets && \
	  node_modules/brunch/bin/brunch build --production && \
	  cd ../ && \
	  mix phx.digest
firmware:
	# Compiling certifi because of https://github.com/benoitc/hackney/issues/528
	export MIX_ENV=prod && \
	  export MIX_TARGET=rpi2 && \
	  cd firmware && \
	  mix deps.get && \
	  mix deps.compile certifi && \
	  mix firmware
ui: assets
	export MIX_ENV=prod && \
	  cd ui && \
	  mix deps.get && \
	  mix
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
