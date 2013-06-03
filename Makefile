plugin_name = jboss71-plugin
publish_bucket = cloudbees-clickstack
publish_repo = testing
publish_url = s3://$(publish_bucket)/$(publish_repo)/

deps = lib lib/jboss.zip

pkg_files = README LICENSE setup functions control lib java

include plugin.mk

jboss_ver = 1.1.2
jboss_src = http://s3.amazonaws.com/cloudbees-downloads/clickstack/staxboss71-plugin-$(jboss_ver).zip
jboss_md5 = 8a86e74614858c4fccb70050d474cc62

lib:
	mkdir -p lib

lib/jboss.zip: lib java 
	mkdir -p lib
	curl -fLo lib/jboss.zip "$(jboss_src)"
	$(call check-md5,lib/jboss.zip,$(jboss_md5))

java_plugin_gitrepo = git://github.com/CloudBees-community/java-clickstack.git

java:
	git clone $(java_plugin_gitrepo) java
	rm -rf java/.git
	cd java; make clean; make deps
