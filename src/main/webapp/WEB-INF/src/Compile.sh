#!/bin/bash

JAVA_DIR=/usr/local/jdk/bin 
TARGET_DIR=/usr/local/jboss-eap-4.3/jboss-as/server/pay/deploy/jboss-web.deployer/ROOT.war/WEB-INF/classes
SQLMAP=/usr/local/jboss-eap-4.3/jboss-as/server/pay/deploy/jboss-web.deployer/ROOT.war/WEB-INF/lib/xpg_client.jar
IBATIS=/usr/local/jboss-eap-4.3/jboss-as/server/pay/lib/ibatis-2.3.4.726.jar
JAVAX=/usr/local/jboss-eap-4.3/jboss-as/lib/servlet-api.jar
BASE64Codec=/usr/local/jboss-eap-4.3/jboss-as/server/pay/lib/commons-codec-1.3.jar

usage()
{
	echo "Need to set Java FILE_NAME"
	echo "them in command line : "
	echo 'Usage: ./Compile.sh [FILE_NAME] or compileh [FILE_NAME]'
	echo "for example : "
	echo 'Compile.sh test.java or compilep test.java'
	exit 1
}

if [ $# = 0 ]; then
	if [ "x$FILE_NAME" = "x" ]; then
		usage
	fi
elif [ $# = 1 ]; then
	FILE_NAME=$1
else
	usage
fi

$JAVA_DIR/javac -classpath .:$TARGET_DIR:$SQLMAP:$IBATIS:$JAVAX:$BASE64Codec -d $TARGET_DIR -Xlint:unchecked $FILE_NAME
