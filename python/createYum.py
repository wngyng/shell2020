#! /usr/bin/python3
# label:wang
# date:22-10-17
#this is createyum

import os


def createMount():
    print("========创建光驱挂载置========")
    cdromPath = "/media/cdrom"
    if os.path.exists(cdromPath):
        print(cdromPath + "目录已存在")
    else:
        os.mkdir(cdromPath)
    print("========开始挂载虚拟光驱========")
    
    if os.path.ismount(cdromPath):
        print("已挂载")
    else:
        os.


if __name__ == '__main__':
    createMount()
    
