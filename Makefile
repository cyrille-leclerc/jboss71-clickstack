plugin_name = jboss71-plugin
publish_bucket = cloudbees-clickstack
publish_repo = testing
publish_url = s3://$(publish_bucket)/$(publish_repo)/

deps = lib/jboss.zip java

pkg_files = README LICENSE setup functions control lib java

include plugin.mk

jboss_ver = 1.1.1
jboss_src = http://s3.amazonaws.com/cloudbees-downloads/clickstack/staxboss71-plugin-$(jboss_ver).zip
jboss_md5 = 76765b5a8bf81bc85d3f6ca9a957f22f

lib/jboss.zip:
	mkdir -p lib
	curl -fLo lib/jboss.zip "$(jboss_src)"
	echo "$(jboss_md5)  lib/jboss.zip" | md5sum --check

java_plugin_gitrepo = git://github.com/CloudBees-community/java-clickstack.git

java:
	git clone $(java_plugin_gitrepo) java
	rm -rf java/.git
	cd java; make clean; make deps
