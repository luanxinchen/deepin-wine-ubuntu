#Deepin-Wine-Ubuntu
------
Deepin-Wine-Ubuntu是wszqkzqk同学将deepin内置的wine环境完美移植到Ubuntu上的一个项目,使用它可以在Ubuntu上近乎完美的运行win应用,从而避免了使用原生wine模拟应用时的各种BUG、崩溃等。
此脚本基于deepin-wine-ubuntu，将企业微信和桌面微信整合，可以直接进行安装、卸载、更新等操作。

##开始
解压包并执行`./install.sh`
若提示权限不足,请执行
```
chmod +x install.sh
```
###安装
**必须执行第1项安装deepin-wine依赖环境和组件后才能进行下一步操作！**
> * 安装deepin-wine（必须）
执行此项安装deepin-wine依赖环境和组件
> * 安装企业微信桌面版
执行此项开始安装deepin发布的企业微信容器（2.4.16版本）
> * 安装微信桌面版
执行此项开始安装deepin发布的微信容器（2.6.2版本）

安装完成后在应用程序中搜索对应软件名称即可

###卸载

> * 仅卸载企业微信桌面版
执行此项卸载已安装的企业微信容器，保留deepin-wine环境和其他软件容器
> * 仅卸载微信桌面版
执行此项卸载已安装的微信容器，保留deepin-wine环境和其他软件容器
> * 完全卸载deepin-wine
执行此项将卸载deepin-wine环境及已安装的所有容器，谨慎操作

-----
##软件更新
把更新包down到本地，退出需要更新的软件，执行dpkg -i即可，例：
```
sudo dpkg -i deepin.com.wechat_2.6.7.57deepin0_i386.deb
```

##降级说明
需要降级请先执行卸载命令apt remove {包名}
```
微信包名：deepin.com.wechat
企业微信包名：deepin.com.weixin.work
```
卸载后再安装旧版deb即可

##已知BUG
1. 微信截图快捷键无法使用，软件设置中将截图快捷键修改为Ctrl+A即可
2. ubuntu1804微信登录后有黑色小方块，聊天窗口输入可弹出表情提示框的字符，如666、ok等，黑框消失
3. 企业微信打开工作台或点击工作台内应用崩溃：终端执行``
WINEPREFIX=~/.deepinwine/Deepin-WXWork deepin-wine winecfg``
在窗口中将windows模式调整为windowsXP即可。
