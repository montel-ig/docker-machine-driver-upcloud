package main

import (
    "github.com/docker/machine/libmachine/drivers/plugin"
    "github.com/montel-ig/docker-machine-driver-upcloud/driver"
)

func main() {
	plugin.RegisterDriver(upcloud.NewDriver("", ""))
}
