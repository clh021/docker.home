#!/usr/bin/env python
#-*- coding:utf-8 -*-

# 需要先安装 python 的 mysql 模块
# apt-get install python-mysqldb

import os
import MySQLdb
import subprocess
import zipfile

DBINIT_PATH = './'       # sql文件所处的目录
DBHOST = 'localhost'
DBPORT = 3306
DBUSER = 'root'
DBPSWD = ''
DBCHARSET = 'utf8'

DBCONN = None


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


# 导入sql文件
def restore_sql(sql_file, dbname):
    if not os.path.exists(sql_file) or not dbname:
        return
    conn = mysql_connect()
    try:
        conn.query('create database if not exists %s charset=%s;' % (dbname, DBCHARSET))
        conn.select_db(dbname)
    except Exception as e:
        print("创建数据库 '%s' 失败！" % (dbname))
        print(e)
        return

    # 考虑到sql文件可能会很大，因此调用外部mysql命令来导入
    #with open(sql_file) as fp:
    #    conn.query(fp.read())
    #    conn.commit()
    if DBPSWD:
        cmd = "mysql -h%s -P%s -u%s -p%s -D%s < %s" % (
            DBHOST, DBPORT, DBUSER, DBPSWD, dbname, sql_file)
    else:
        cmd = "mysql -h%s -P%s -u%s -D%s < %s" % (
            DBHOST, DBPORT, DBUSER, dbname, sql_file)

    print("import '%s' to '%s'..." % (sql_file, dbname))
    try:
        p = subprocess.Popen(cmd, shell=True)
        p.wait()
    except Exception as e:
        print("import '%s' to '%s' failed!" % (sql_file, dbname))
        print(e)
        return

    if p.returncode != 0:
        print("import '%s' to '%s' failed!" % (sql_file, dbname))
        return

    try:
        os.unlink(sql_file)
    except Exception as e:
        print("warnning: 删除'%s'文件出错" % (sql_file))
        print(e)


def main():
    for zip_file in os.listdir(DBINIT_PATH):
        if os.path.splitext(zip_file)[1] != '.zip':         # 只处理zip文件
            continue
        if not zipfile.is_zipfile(os.path.join(DBINIT_PATH, zip_file)):
            continue
        file_name = zip_file.split('.')
        if len(file_name) != 3:                             # 文件名格式不对
            continue
        try:
            # 解压缩
            myzip = zipfile.ZipFile(os.path.join(DBINIT_PATH, zip_file))
            myzip.extractall(DBINIT_PATH)
        except Exception as e:
            print(e)
            continue
        sql_file = os.path.splitext(zip_file)[0] + '.sql'
        restore_sql(os.path.realpath(os.path.join(DBINIT_PATH, sql_file)),file_name[0])

if __name__ == '__main__':
    main()
    mysql_close()
