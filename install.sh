#!/bin/bash
#判断用户是否为root
#if [ $UID -ne 0 ];then
#	echo "please use root user running script!!"
#	exit 1
#fi
#声明回滚函数和卸载函数
rollback(){
rm -rf ~/.winetemp
}
uninstall(){
rm -rf ~/.deepinwine
rm -rf ~/.wine
}
#菜单函数
function main_menu()
{
cat << EOF
============================
|    Deepin-Wine-Ubuntu    |
|          V0.1.1          | 
| xinchen.luan@transwarp.io|
============================
`echo -e " 1) 安装"`
`echo -e " 2) 卸载"`
`echo -e " Q) 退出"`
EOF
read -p "请选择操作：" num1
case $num1 in
	1)
		echo -e ">>>安装"
		install_menu;;
	2)
		echo -e ">>>卸载"
		uninstall_menu;;
#	3)
#		echo -e ">>>更新"
#		update;;
	Q|q)
		echo -e "----------退出----------"
		exit 0;;
	*)
		echo -e "error:请输入正确的值！"
		main_menu;;
esac
}
function install_menu()
{
cat << EOF
---------------------------
>deepinwine>主菜单>安装
`echo -e " 1) 安装deepin-wine依赖环境和组件（必须）"`
`echo -e " 2) 安装企业微信兼容版"`
`echo -e " 3) 安装微信兼容版"`
`echo -e " X) 返回主菜单"`
EOF
read -p "请选择操作：" num2
case $num2 in
        1)
                echo -e ">>>安装deepin-wine"
                echo "Creating cache directory....."
                mkdir ~/.winetemp
                chmod 755 install/deepin-wine-ubuntu-v2.18-12-ubuntu2.tar.gz
                tar -zxvf install/deepin-wine-ubuntu-v2.18-12-ubuntu2.tar.gz -C ~/.winetemp
        	echo "Release file:Done"
		~/.winetemp/install.sh
		#判断安装结果
		if [ `dpkg -l | grep deepin.wine |wc -l` -ge 8 ];then
			whiptail --title "deepin-wine" --msgbox "安装完成，可以开始安装容器！" 10 60
		else
			whiptail --title "deepin-wine" --msgbox "安装失败，请检查安装程序！" 10 60
		fi
		rollback;
		install_menu;;
        2)
                echo -e ">>>安装企业微信"
                sudo dpkg -i install/deepin.com.weixin.work_2.4.16.1347deepin1_i386.deb
                echo -e "\033[41;37m 安装完成，请打开企业微信，在设置中关闭自动更新！！！ \033[0m"
                read -p "按Enter键继续...."
		install_menu;;
        3)
                echo -e ">>>安装微信"
                sudo dpkg -i install/deepin.com.wechat_2.6.2.31deepin0_i386.deb
                echo -e "\033[41;37m 安装完成，请打开微信，在设置中关闭自动更新！！！ \033[0m"
                read -p "按Enter键继续...."
		install_menu;;
        X|x)
                echo -e "--------返回主菜单---------"
                main_menu;;
        *)
                echo -e "error:请输入正确的值！"
                install_menu;;
esac
}
function uninstall_menu()
{
cat << EOF
---------------------------
>deepinwine>主菜单>卸载
`echo -e " 1) 仅卸载企业微信容器"`
`echo -e " 2) 仅卸载微信容器"`
`echo -e " 3) 完全卸载deepin-wine环境和已安装容器"`
`echo -e " X) 返回主菜单"`
EOF
read -p "请选择操作：" num3
case $num3 in
        1)
                echo -e ">>>卸载企业微信"
		sudo apt remove deepin.com.weixin.work -y
		rm -rf ~/.deepinwine/Deepin-WXWork
                echo -e ">>>卸载完成"
                uninstall_menu;;
        2)
                echo -e ">>>卸载微信"
		sudo apt remove deepin.com.wechat -y
		rm -rf ~/.deepinwine/Deepin-WeChat
                echo -e ">>>卸载完成"
                uninstall_menu;;
        3)
                echo -e ">>>完全卸载deepin-wine"
                sudo apt remove *deepin*wine* udis86 -y
		echo -e ""
                sudo apt remove deepin.com.weixin.work deepin.com.wechat
                uninstall;
                echo -e ">>>卸载完成"
                uninstall_menu;;

        X|x)
                echo -e "--------返回主菜单---------"
                main_menu;;
        *)
                echo -e "error:请输入正确的值！"
                uninstall_menu;;
esac
}
function update()
{
cat << EOF
---------------------------
>deepinwine>主菜单>更新
`echo -e " 1) 更新企业微信"`
`echo -e " 2) 更新微信"`
`echo -e " X) 返回主菜单"`
EOF
read -p "请选择操作：" num4
case $num4 in
        1)
                echo -e ">>>更新企业微信"
                whiptail --title "更新完成" --msgbox "更新完成，请打开企业微信，在设置中关闭自动更新！" 10 60 
                update_menu;;
        2)
                echo -e ">>>更新微信"
                WINEPREFIX=~/.deepinwine/Deepin-WeChat deepin-wine update/Wechat.update.exe
                echo -e "\033[41;37m 更新完成，请打开微信，在设置中关闭自动更新！！！ \033[0m"
                
                read -p "按Enter键继续...."
                update_menu;;
        X|x)
                echo -e "--------返回主菜单---------"
                main_menu;;
        *)
                echo -e "error:请输入正确的值！"
                main_menu;;
esac
}
main_menu
