.PHONY: setup firmware burn upload publish
all: firmware
setup:
	export MIX_ENV=prod && \
	  cd ui && \
	  mix deps.get && \
	  cd assets && \
	  npm install
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
	  ./upload.sh nerves.local _build/rpi2/rpi2_prod/nerves/images/firmware.fw

publish:
	cp firmware/_build/rpi2/rpi2_prod/nerves/images/firmware.fw ui/assets/static
