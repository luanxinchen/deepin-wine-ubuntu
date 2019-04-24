su用户执行：
```
dpkg -X *.deb extract/ #解deb包到extract目录
dpkg -e *.deb extract/DEBIAN #解deb包安装信息到extract下DEBIAN目录
chown -R transwarp extract/ #将extract目录所有者更改为$user,否则没有替换权限
#修改extract包内容
#修改DEBIAN/control安装信息
dpkg-deb -b extract/ build/ #将extract目录文件封包成deb到build目录
dpkg -i *.deb #安装
```