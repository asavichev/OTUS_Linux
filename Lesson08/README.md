yum -y install ypel-release
yum -y install prm-build rpmdevtools maven chromium chromedriver java-1.8.0-opengdk`

Приложен vagrantfile для сборки программы мониторинга WEB с ипользованием SELENIUM.

Протокол сборки:
================
[root@otuslinux SPECS]# rpmbuild -bb selenium.spec
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.3YAjjU
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd /root/rpmbuild/BUILD
+ rm -rf sel_parser-1.0
+ /usr/bin/tar -xf /root/rpmbuild/SOURCES/sel_parser-1.0.tar
+ cd sel_parser-1.0
+ /usr/bin/chmod -Rf a+rX,u+w,g-w,o-w .
+ exit 0
Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.dCf0iC
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd sel_parser-1.0
+ mvn install
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building sel_parser 1.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-resources-plugin:2.5:resources (default-resources) @ sel_parser ---
[debug] execute contextualize
[WARNING] Using platform encoding (ANSI_X3.4-1968 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.6.1:compile (default-compile) @ sel_parser ---
[INFO] Changes detected - recompiling the module!
[WARNING] File encoding has not been set, using platform encoding ANSI_X3.4-1968, i.e. build is platform dependent!
[INFO] Compiling 11 source files to /root/rpmbuild/BUILD/sel_parser-1.0/target/classes
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,28] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,29] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,30] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,31] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,32] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,33] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,34] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,35] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,36] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,37] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,38] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,39] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,40] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,41] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,42] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,43] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,45] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,46] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,47] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,48] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,49] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,50] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,51] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,52] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,53] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,54] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,55] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,56] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,57] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,58] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,59] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,60] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,61] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,62] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,63] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,64] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,65] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[84,66] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,102] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,103] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,104] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,105] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,106] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,107] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,108] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,109] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,110] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,111] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,112] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,113] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,114] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,115] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,116] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,117] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,118] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,119] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,120] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,121] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,122] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,123] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,124] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,125] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,127] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,128] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,129] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,130] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,131] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,132] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,133] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,134] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,135] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,136] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,137] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[85,138] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,62] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,63] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,64] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,65] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,66] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,67] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,68] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,69] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,70] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,71] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,72] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,73] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,74] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,75] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,76] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,77] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,78] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,79] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,80] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,81] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,82] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,83] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,84] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,85] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,87] unmappable character for encoding ASCII
[ERROR] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/sel_parser.java:[90,88] unmappable character for encoding ASCII
[INFO] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/CCommand.java: Some input files use unchecked or unsafe operations.
[INFO] /root/rpmbuild/BUILD/sel_parser-1.0/src/main/java/CCommand.java: Recompile with -Xlint:unchecked for details.
[INFO]
[INFO] --- maven-resources-plugin:2.5:testResources (default-testResources) @ sel_parser ---
[debug] execute contextualize
[WARNING] Using platform encoding (ANSI_X3.4-1968 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /root/rpmbuild/BUILD/sel_parser-1.0/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.6.1:testCompile (default-testCompile) @ sel_parser ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.10:test (default-test) @ sel_parser ---
[INFO] No tests to run.
[INFO] Surefire report directory: /root/rpmbuild/BUILD/sel_parser-1.0/target/surefire-reports

-------------------------------------------------------
 T E S T S
-------------------------------------------------------

Results :

Tests run: 0, Failures: 0, Errors: 0, Skipped: 0

[INFO]
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ sel_parser ---
[INFO] Building jar: /root/rpmbuild/BUILD/sel_parser-1.0/target/sel_parser-1.0-SNAPSHOT.jar
[INFO]
[INFO] --- executable-packer-maven-plugin:1.0.1:pack-executable-jar (default) @ sel_parser ---
[INFO] Dependency JAR files will be placed in 'lib/'
[INFO] Including dependency selenium-java-3.4.0.jar
[INFO] Including dependency selenium-chrome-driver-3.4.0.jar
[INFO] Including dependency selenium-edge-driver-3.4.0.jar
[INFO] Including dependency selenium-ie-driver-3.4.0.jar
[INFO] Including dependency selenium-opera-driver-3.4.0.jar
[INFO] Including dependency selenium-remote-driver-3.4.0.jar
[INFO] Including dependency selenium-safari-driver-3.4.0.jar
[INFO] Including dependency selenium-support-3.4.0.jar
[INFO] Including dependency cglib-nodep-3.2.4.jar
[INFO] Including dependency commons-exec-1.3.jar
[INFO] Including dependency commons-lang3-3.5.jar
[INFO] Including dependency commons-codec-1.10.jar
[INFO] Including dependency commons-io-2.5.jar
[INFO] Including dependency commons-logging-1.2.jar
[INFO] Including dependency sac-1.3.jar
[INFO] Including dependency cssparser-0.9.22.jar
[INFO] Including dependency gson-2.8.0.jar
[INFO] Including dependency guava-21.0.jar
[INFO] Including dependency hamcrest-core-1.3.jar
[INFO] Including dependency htmlunit-2.26.jar
[INFO] Including dependency htmlunit-core-js-2.26.jar
[INFO] Including dependency neko-htmlunit-2.25.jar
[INFO] Including dependency httpclient-4.5.3.jar
[INFO] Including dependency httpcore-4.4.6.jar
[INFO] Including dependency httpmime-4.5.3.jar
[INFO] Including dependency jetty-io-9.4.1.v20170120.jar
[INFO] Including dependency jetty-util-9.4.1.v20170120.jar
[INFO] Including dependency jna-4.1.0.jar
[INFO] Including dependency jna-platform-4.1.0.jar
[INFO] Including dependency junit-4.12.jar
[INFO] Including dependency phantomjsdriver-1.4.0.jar
[INFO] Including dependency htmlunit-driver-2.26.jar
[INFO] Including dependency javax.servlet-api-3.1.0.jar
[INFO] Including dependency websocket-api-9.4.3.v20170317.jar
[INFO] Including dependency websocket-client-9.4.3.v20170317.jar
[INFO] Including dependency jetty-client-9.4.3.v20170317.jar
[INFO] Including dependency jetty-http-9.4.3.v20170317.jar
[INFO] Including dependency websocket-common-9.4.3.v20170317.jar
[INFO] Including dependency serializer-2.7.2.jar
[INFO] Including dependency xalan-2.7.2.jar
[INFO] Including dependency xercesImpl-2.11.0.jar
[INFO] Including dependency xml-apis-1.4.01.jar
[INFO] Including dependency selenium-api-3.4.0.jar
[INFO] Including dependency selenium-firefox-driver-3.4.0.jar
[INFO] Including dependency json-simple-1.1.1.jar
[INFO] Building jar: /root/rpmbuild/BUILD/sel_parser-1.0/target/sel_parser-1.0-SNAPSHOT-pkg.jar
[INFO]
[INFO] --- maven-install-plugin:2.3.1:install (default-install) @ sel_parser ---
[INFO] Installing /root/rpmbuild/BUILD/sel_parser-1.0/target/sel_parser-1.0-SNAPSHOT.jar to /root/.m2/repository/sel_parser/sel_parser/1.0-SNAPSHOT/sel_parser-1.0-SNAPSHOT.jar
[INFO] Installing /root/rpmbuild/BUILD/sel_parser-1.0/pom.xml to /root/.m2/repository/sel_parser/sel_parser/1.0-SNAPSHOT/sel_parser-1.0-SNAPSHOT.pom
[INFO] Installing /root/rpmbuild/BUILD/sel_parser-1.0/target/sel_parser-1.0-SNAPSHOT-pkg.jar to /root/.m2/repository/sel_parser/sel_parser/1.0-SNAPSHOT/sel_parser-1.0-SNAPSHOT-pkg.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 7.121s
[INFO] Finished at: Sat Aug 25 09:18:45 UTC 2018
[INFO] Final Memory: 19M/136M
[INFO] ------------------------------------------------------------------------
+ exit 0
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.OZLPwN
+ umask 022
+ cd /root/rpmbuild/BUILD
+ '[' /root/rpmbuild/BUILDROOT/sel_parser-1.0-1.x86_64 '!=' / ']'
+ rm -rf /root/rpmbuild/BUILDROOT/sel_parser-1.0-1.x86_64
++ dirname /root/rpmbuild/BUILDROOT/sel_parser-1.0-1.x86_64
+ mkdir -p /root/rpmbuild/BUILDROOT
+ mkdir /root/rpmbuild/BUILDROOT/sel_parser-1.0-1.x86_64
+ cd sel_parser-1.0
+ rm -rf /root/rpmbuild/BUILDROOT/sel_parser-1.0-1.x86_64
+ mkdir -p /root/rpmbuild/BUILDROOT/sel_parser-1.0-1.x86_64/opt/selenium
+ install -p -m 644 /root/rpmbuild/BUILDROOT/sel_parser-1.0-1.x86_64/../../BUILD/sel_parser-1.0/target/sel_parser-1.0-SNAPSHOT-pkg.jar /root/rpmbuild/BUILDROOT/sel_parser-1.0-1.x86_64/opt/selenium/selenium.jar
+ install -m 644 /root/rpmbuild/SOURCES/property.cfg /root/rpmbuild/BUILDROOT/sel_parser-1.0-1.x86_64/opt/selenium/property.cfg
+ /usr/lib/rpm/find-debuginfo.sh --strict-build-id -m --run-dwz --dwz-low-mem-die-limit 10000000 --dwz-max-die-limit 110000000 /root/rpmbuild/BUILD/sel_parser-1.0
/usr/lib/rpm/sepdebugcrcfix: Updated 0 CRC32s, 0 CRC32s did match.
+ '[' '%{buildarch}' = noarch ']'
+ QA_CHECK_RPATHS=1
+ case "${QA_CHECK_RPATHS:-}" in
+ /usr/lib/rpm/check-rpaths
+ /usr/lib/rpm/check-buildroot
+ /usr/lib/rpm/redhat/brp-compress
+ /usr/lib/rpm/redhat/brp-strip-static-archive /usr/bin/strip
+ /usr/lib/rpm/brp-python-bytecompile /usr/bin/python 1
+ /usr/lib/rpm/redhat/brp-python-hardlink
+ /usr/lib/rpm/redhat/brp-java-repack-jars
Processing files: sel_parser-1.0-1.x86_64
Provides: sel_parser = 1.0-1 sel_parser(x86-64) = 1.0-1
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Requires(pre): /usr/sbin/groupadd /usr/sbin/useradd
Processing files: sel_parser-debuginfo-1.0-1.x86_64
Provides: sel_parser-debuginfo = 1.0-1 sel_parser-debuginfo(x86-64) = 1.0-1
Requires(rpmlib): rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1 rpmlib(CompressedFileNames) <= 3.0.4-1
Checking for unpackaged file(s): /usr/lib/rpm/check-files /root/rpmbuild/BUILDROOT/sel_parser-1.0-1.x86_64
Wrote: /root/rpmbuild/RPMS/x86_64/sel_parser-1.0-1.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/sel_parser-debuginfo-1.0-1.x86_64.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.0EyKFp
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd sel_parser-1.0
+ exit 0
[root@otuslinux SPECS]#

Установка из репозитория
========================
[root@otuslinux myrepo]# yum install sel_parser
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
epel/x86_64/metalink                                     |  31 kB     00:00
 * base: dedic.sh
 * epel: fedora-mirror01.rbc.ru
 * extras: mirror.sale-dedic.com
 * updates: mirror.sale-dedic.com
base                                                     | 3.6 kB     00:00
extras                                                   | 3.4 kB     00:00
mylocal                                                  | 2.9 kB     00:00
updates                                                  | 3.4 kB     00:00
mylocal/primary_db                                         | 1.6 kB   00:00
Resolving Dependencies
--> Running transaction check
---> Package sel_parser.x86_64 0:1.0-1 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package              Arch             Version          Repository         Size
================================================================================
Installing:
 sel_parser           x86_64           1.0-1            mylocal            16 M

Transaction Summary
================================================================================
Install  1 Package

Total download size: 16 M
Installed size: 16 M
Is this ok [y/d/N]: y
Downloading packages:
Package sel_parser-1.0-1.x86_64.rpm is not signed


