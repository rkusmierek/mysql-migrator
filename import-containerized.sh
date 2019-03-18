BASEDIR=$(readlink -f $(dirname "$0") )
ENV_FILE=${BASEDIR}/env-dst

[ -f ${ENV_FILE} ] || {
    echo "Configuration file missing: ${ENV_FILE}"
    exit 1
}

. ${ENV_FILE}

[ "$1" ] || {
    echo "Data filename is missing!"
    exit 1
}

FILENAME=$1

[ -f ${FILENAME} ] || {
    echo "File ${FILENAME} does not exist!"
    exit 2
}

gzip -dc ${FILENAME} | \
docker run -i --rm \
    naqoda/mysql-client \
    mysql --protocol=tcp --host=${DB_HOST} --port=${DB_PORT} --database=${DB_NAME} --user=${DB_USER} --password=${DB_PASS}
