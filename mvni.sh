
function scpSLF4J() {

    echo ${ARGS}
    SOURCE=/home/ceki/slf4j-site/target/site

    pushd $SOURCE
    #i=0;
    for file in ${ARGS} 
    do
        echo "scp ${file} yvo.qos.ch:/var/www/www.slf4j.org/htdocs/${file}";
        scp ${file} ge.qos.ch:/var/www/www.slf4j.org/htdocs/${file};
        #i=$((i + 1));
    done
    popd
}

function doRsync() {
    echo 'ssh root@exo1.qos.ch "rsync -r -p -z -l --exclude=log/ --delete rsync://ge.qos.ch/www/www.slf4j.org /var/www"'
    ssh root@exo1.qos.ch "rsync -r -p -z -l --exclude=log/ --delete rsync://ge.qos.ch/www/www.slf4j.org /var/www"
}


ARGS="${@}"

#echo "a0=${0}"
#echo "a1=${1}"
#echo "a2=${2}"
echo "ARGS=${ARGS}"

echo "This is triggered command. Triggered by ${ARGS}"

echo "JAVA_HOME=$JAVA_HOME"
echo "MAVEN_HOME=${MAVEN_HOME}"  #=/java/maven-3.5.2/


MVN_COMMAND=${MAVEN_HOME}/bin/mvn

pushd ~/slf4j-site

echo "======================" 
${MVN_COMMAND} install
scpSLF4J;
doRsync;

popd

exit



