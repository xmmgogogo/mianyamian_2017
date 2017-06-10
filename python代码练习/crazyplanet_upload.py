#-*- coding:utf-8 -*-
import time
import re
import json
import os
import sys
from ftplib import FTP

# FTP文件操作


def ftpClass(type, baseFile, serverFile, devName):
    # 配置设置
    host = '172.17.5.168'
    user = 'td-vikingage'
    pwd = 'td2015'

    # 上传目录设置
    basePath = 'D:/'
    serverPath = '/www/'

    ftp = FTP()
    ftp.connect(host)
    ftp.login(user, pwd)

    # 这里写死为1，因为强制让运维修改为ftp而非使用sftp (去掉注释可兼容sftp)
    cur_version = 1

    if not os.path.exists(baseFile):
        baseFile = basePath + baseFile

    serverFile = serverPath + serverFile
    # print baseFile, os.path.exists(baseFile)

    # 验证是否存在本地文件
    if not os.path.exists(baseFile):
        print '[' + baseFile + '] not exists!'
        sys.exit()

    if type == 'up':
        if os.path.isfile(baseFile):
            ftpUp(ftp, baseFile, serverFile, devName, cur_version)
        if os.path.isdir(baseFile):
            fNames = os.listdir(baseFile)

            for fName in fNames:
                if fName != '.svn':
                    ftpUp(ftp, baseFile + '/' + fName, serverFile +
                          '/' + fName, devName, cur_version)

    if type == 'down':
        ftpDown(ftp, baseFile, serverFile, devName, cur_version)

    if cur_version == 1:
        ftp.close()
    else:
        ftp.close()


# FTP文件上传
def ftpUp(ftp, baseFile, serverFile, devName, cur_version):
    if cur_version == 1:
        f = open(baseFile, 'r')
        result = ftp.storlines('STOR %s' % ('/' + serverFile), f)
        f.close()
    else:
        result = ftp.put(baseFile, serverFile)

    print "UPLOAD SUCCESS -> " + serverFile


# FTP文件下载
def ftpDown(ftp, baseFile, serverFile, devName, cur_version):
    if cur_version == 1:
        f = open(baseFile, 'wb')
        result = ftp.retrbinary('RETR %s' % ('/' + serverFile), f.write)
        f.close()
    else:
        result = ftp.get(baseFile, serverFile)

    print "DOWNLOAD SUCCESS -> " + baseFile


if __name__ == "__main__":
    # 上传
    # sheetName = 'down_ag_icon.py'

    args = len(sys.argv)
    if args < 2:
        print "Please Select The Upload File."
        sys.exit()

    print os.getcwd()

    sheetName = sys.argv[1]
    ftpClass('up', sheetName, sheetName, '')
