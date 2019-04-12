BIN_PATH = /usr/local/bin

build: clean
		mkdir -p ./bin
		go build -o ./bin/docker-machine-driver-upcloud
		ln -f ./bin/docker-machine-driver-upcloud $(BIN_PATH)/docker-machine-driver-upcloud

clean:
		rm -f $(BIN_PATH)/docker-machine-driver-upcloud
		rm -rf ./bin