
import os
import sys


a=os.listdir("/home/wang/文档")
b=os.getcwd()
#os.rmdir("data")

b=os.path.split("/home/wang/文档/shell2020/README.md")
a=os.path.exists("/home/wang")

print(a)
print(b)
#os.mkdir("data")
os.system("echo dfd")
os.system("ls -l")
print(sys.argv[0])
print(sys.getdefaultencoding())
print(sys.path)