BASEDIR=$(readlink -f $(dirname "$0") )
ENV_FILE=${BASEDIR}/env-src

[ -f ${ENV_FILE} ] || {
    echo "Configuration file missing: ${ENV_FILE}"
    exit 1
}

. ${ENV_FILE}

TS=`date '+%Y%m%d_%H%M%S'`

mysqldump --protocol=TCP --compress --host=${DB_HOST} --port=${DB_PORT} --user=${DB_USER} --password=${DB_PASS} ${DB_NAME} | gzip > backup_${TS}.sql.gz