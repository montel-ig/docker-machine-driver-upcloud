# UpCloud Docker Machine Driver

[![CircleCI](https://circleci.com/gh/montel-ig/docker-machine-driver-upcloud/tree/develop.svg?style=svg)](https://circleci.com/gh/montel-ig/docker-machine-driver-upcloud/tree/develop)

A `docker-machine` driver for [UpCloud](https://www.upcloud.com/)

Updated and maintained by [Montel Intergalactic](https://www.montel.fi)

Originally developed by [Hanzo Studio](https://hanzo.es/)

## How to get it

### The binary way

Download the latest
[binary](https://github.com/montel-ig/docker-machine-driver-upcloud/releases/latest/download/docker-machine-driver-upcloud) from the
[releases](https://github.com/montel-ig/docker-machine-driver-upcloud/releases) page,
place it somewhere in your path, like `/usr/local/bin/` and make sure the binary is executable.

### The go way

_You must first have a working go development environment to get it this way._

1. Download the code
```bash
$ git clone git@github.com:montel-ig/docker-machine-driver-upcloud
```

2. Make sure the dependencies are installed and everything is in order
```bash
$ dep ensure
```

3. Compile the code
```bash
$ make build
```

This will compile the file at `./bin/docker-machine-driver-upcloud` and create a symlink at `/usr/local/bin/` so the driver can be used. You can change that path to any directory which is available via `$PATH` on the `Makefile`.

### How to use it

_An UpCloud account with api access is needed to use this driver_

Options:

```bash
$ docker-machine create --driver upcloud

...

  --upcloud-user                                             upcloud api access user [$UPCLOUD_USER]
  --upcloud-passwd                                           upcloud api access user's password [$UPCLOUD_PASSWD]
  --upcloud-plan "1xCPU-1GB"                                 upcloud plan [$UPCLOUD_PLAN]
  --upcloud-ssh-user "root"                                  SSH username [$UPCLOUD_SSH_USER]
  --upcloud-storage 25                                       specify the storage available for the server [$UPCLOUD_STORAGE]
  --upcloud-template "01000000-0000-4000-8000-000030080200"  upcloud template [$UPCLOUD_TEMPLATE]
  --upcloud-use-private-network                              set this flag to use private networking [$UPCLOUD_USE_PRIVATE_NETWORK]
  --upcloud-use-private-network-only                         set this flag to only use private networking [$UPCLOUD_USE_PRIVATE_NETWORK_ONLY]
  --upcloud-userdata                                         path to file with cloud-init user-data [$UPCLOUD_USERDATA]
  --upcloud-zone "de-fra1"                                   upcloud zone [$UPCLOUD_ZONE]

...

```

Example run:

```bash
$ docker-machine create \
--driver upcloud \
--upcloud-user "user" \
--upcloud-passwd "password"
machine_name
```

## Developing
The repository includes a `Makefile` with the commands required to develop the project.

To test the driver locally, run
```bash
$ make install
```
This will compile the driver and copy it to your `$GOPATH/bin` directory, so it's accessible to Docker via `$PATH`.

After this, you can run it normally with `docker-machine`
```bash
$ docker-machine create --driver upcloud #...
```

If you want to remove the installed driver, run
```bash
$ make uninstall
```
This will remove the compiled driver from `$GOPATH/bin`.

### Releasing
A command for building different versions is also included to simplify the distribution of the driver to different platforms.

To build the driver for release, run
```bash
$ make build-all
```
This will compile the driver for MacOS, Linux, and Windows, for the `368` and `amd64` architectures. If you need to compile to a different target, you can modify the `TARGET_OS` or `TARGET_ARCH` variables on the `Makefile`.

To make the distribution easier, the build will also create a directory with the compressed driver for each platform. You can find those under `dist/compressed`.

### Issues, contributions and comments.

Issues, contributions, and comments are always welcome. Feel free to submit an issue or pull request with your contributions.

---

Made with :heart: from :finland:
