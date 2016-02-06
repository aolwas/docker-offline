# docker-offline

Docker offline installation package

Supported operating systems:

* Ubuntu 14.04 (Working)
* Centos 7 (Working)


## Build package

An installed Docker engine is needed to build packages

Edit `version` file to specify docker version, then run:

```
make
```

to generates the following archives:

* docker-offline-all-<docker-version>.tar.gz
* docker-offline-ubuntu-14.04-<docker-version>.tar.gz
* docker-offline-centos-7-<docker-version>.tar.gz

## Publish to Github	

Use the following command to publish to github:

```
make github-tag (create tag)
make github-release
```

In order to use this functionality, github-release should be availble on the system.

Be sur to set the GITHUB_TOKEN environment variable

## Install a package

```
tar -zxvf docker-offline-all-<docker-version>.tar.gz
./docker-offline/install.sh
```	

