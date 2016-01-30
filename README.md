# docker-offline

Docker 离线化安装包,可以离线安装Docker

支持操作系统

* Ubuntu 14.04 (Working)
* Centos 7 (Working)


## 发布方法

编辑`version`文件。控制docker版本

	make

可以得到

* docker-offline-all-<docker-version>.tar.gz
* docker-offline-ubuntu-14.04-<docker-version>.tar.gz
* docker-offline-centos-7-<docker-version>.tar.gz

	
可以发布到 github

	make github-tag (试图创建tag)
	make github-release

需要安装github-release
需要环境变量 GITHUB_TOKEN

## 使用方法

	tar -zxvf docker-offline-all-<docker-version>.tar.gz
	./docker-offline/install.sh
	

