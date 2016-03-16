#!/usr/bin/env python
#-*- coding:utf-8 -*-

import MySQLdb
import os
import zipfile
import logging
import datetime
import subprocess

BACKUP_PATH = './'       # sql文件导出的目录
LOGFILE = 'db_backup.log'       # 日志输入文件
DBHOST = 'localhost'
DBPORT = 3306
DBUSER = 'root'
DBPSWD = ''
DBCHARSET = 'utf8'

# 排除不备份的数据库
EXCLUDE_DATABASE = [
    'mysql', 'information_schema', 'performance_schema'
]

DBCONN = None

logging.basicConfig(filename=LOGFILE, filemode='a',
                    format='[%(asctime)s] %(levelname)s %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S', level=logging.DEBUG)


# 连接数据库　
def mysql_connect():
    global DBCONN
    if not DBCONN:
        try:
            DBCONN = MySQLdb.connect(host=DBHOST, port=DBPORT, user=DBUSER,
                                     passwd=DBPSWD, charset=DBCHARSET)
        except Exception as e:
            print(e)
            exit(1)
    else:
        try:
            DBCONN.ping()
        except Exception as e:
            print(e)
            exit(1)
    return DBCONN


# 关闭数据库连接
def mysql_close():
    if DBCONN:
        try:
            DBCONN.close()
        except Exception:
            pass


def record_log(msg, level=logging.INFO):
    logging.log(level, "%s" % (msg))


def dump_data(dbname):
    now = datetime.datetime.now()
    folder_name = now.strftime('%Y%m%d')
    backup_path = os.path.join(BACKUP_PATH, folder_name)
    try:
        if not os.path.exists(backup_path):
            os.makedirs(backup_path)
    except Exception as e:
        record_log(str(e))
        return

    sql_file = "%s.%s.sql" % (dbname, now.strftime('%Y%m%d_%H%M%S'))
    zip_file = os.path.join(
        backup_path, "%s.%s.zip" % (dbname, now.strftime('%Y%m%d_%H%M%S')))
    outfile = os.path.join(backup_path, sql_file)
    if DBPSWD:
        cmd = "mysqldump -h%s -P%s -u%s -p%s %s > %s" % (
            DBHOST, DBPORT, DBUSER, DBPSWD, dbname, outfile)
    else:
        cmd = "mysqldump -h%s -P%s -u%s %s > %s" % (
            DBHOST, DBPORT, DBUSER, dbname, outfile)
    try:
        p = subprocess.Popen(cmd, shell=True)
        p.wait()
    except Exception as e:
        record_log("dump data '%s' failed! %s" % (dbname, str(e)), logging.ERROR)
        return
    if p.returncode != 0:
        record_log("dump data '%s' failed!" % (dbname), logging.ERROR)
        return

    record_log("dump data '%s' succeeded!" % (dbname))
    try:
        with zipfile.ZipFile(zip_file, 'w', zipfile.ZIP_DEFLATED) as myzip:
            myzip.write(outfile, sql_file)
    except Exception, e:
        record_log("create '%s' failed!" % (zip_file), logging.ERROR)
        return

    os.unlink(outfile)


def main():
    conn = mysql_connect()
    cur = conn.cursor()
    cur.execute('show databases')
    for db in cur.fetchall():
        if db[0] in EXCLUDE_DATABASE:
            continue
        dump_data(db[0])
    cur.close()

if __name__ == '__main__':
    main()
    mysql_close()
