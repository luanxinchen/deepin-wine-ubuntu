#!/bin/bash
whiptail --title "Deepin-Wine-Ubuntu V0.1.1" --msgbox "此脚本仅供星环内部使用，未经允许请勿散布" 10 60  
rollback(){
rm -rf ~/.winetemp
}
function main_menu(){
option1=$(whiptail --title "Deepin-Wine-Ubuntu" --clear --menu "请选择" 12 50 4 \
    "1" "安装Deepin-Wine(必须)" \
    "2" "安装windows程序" \
    "3" "更新windows程序" \
    "4" "卸载" \
    3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    case $option1 in
    1)
	    if(whiptail --title "安装确认" --yesno "确认开始安装Deepin-wine-ubuntu吗?" 10 50)then
				install_wine
			else
				main_menu
			fi;;
		2)
			install_menu;;
		3)
			update_menu;;
		4)
			uninstall_menu;;
    esac
else
    whiptail --title "deepin-wine提示" --msgbox "感谢使用! \ 如有疑问或建议请及时与我联系! \ xinchen.luan@transwarp.io" 10 50
    exit 1
fi
}
function install_wine(){
	{
    sleep 1
    echo 5
    mkdir ~/.winetemp >/dev/null
    sleep 1
    echo 10
    chmod 755 install/deepin-wine-ubuntu-v2.18-12-ubuntu2.tar.gz >/dev/null
    sleep 1
    echo 15
    tar -zxvf install/deepin-wine-ubuntu-v2.18-12-ubuntu2.tar.gz -C ~/.winetemp >/dev/null
    sleep 1
    echo 30
    #添加32位支持
    sudo dpkg --add-architecture i386 >/dev/null
    sleep 1
    echo 40
    #刷新apt缓存
    sudo apt-get update >/dev/null
    sleep 1
    echo 60
    sudo dpkg -i ~/.winetemp/*.deb >/dev/null
    sleep 1
    echo 95
    #自动安装依赖
    sudo apt-get install -f -y >/dev/null
    sleep 5
	} |  whiptail --gauge "正在安装Deepin-wine-ubuntu,过程可能需要几分钟请稍候.........." 6 60 0 && 
	#判断安装结果
		if [ `dpkg -l | grep deepin.wine |wc -l` -ge 8 ];then
			whiptail --title "deepin-wine" --msgbox "安装完成，可以开始安装程序！" 10 60
			rollback;
		else
			whiptail --title "deepin-wine" --msgbox "安装失败，请进入~/.winetemp目录尝试手动执行install.sh" 10 60
		fi
	main_menu;
}
function install_menu(){
option2=$(whiptail --title "安装Windows程序" --clear --menu "请选择" 12 50 3 \
    "1" "安装企业微信2.7.8" \
    "2" "安装微信2.6.8" \
    "x" "运行其他window程序（beta）" \
    3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    case $option2 in
    1)
	    if(whiptail --title "安装确认" --yesno "请确保Deepin-Wine已经安装!!! 确认开始安装企业微信2.7.8吗?" 10 50)then
				{
					sleep 1
					echo 5
					#判断包是否准备就绪
					if [ ! -f "install/deepin.com.weixin.work_2.7.8.1239deepin1_i386.deb" ];then
					wget -q http://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.weixin.work/deepin.com.weixin.work_2.4.16.1347deepin1_i386.deb -P install/ >/dev/null 
					fi
					sleep 1
					echo 55
					sudo dpkg -i install/deepin.com.weixin.work_2.7.8.1239deepin1_i386.deb >/dev/null
					sleep 10
				} | whiptail --gauge "正在安装企业微信2.7.8，过程可能需要几分钟请稍候........." 6 60 0 &&
				if [ `dpkg -l | grep deepin.com.weixin.work |wc -l` -ne 0 ];then
				whiptail --title "deepin-wine" --msgbox "安装完成，请打开程序，在设置中关闭自动更新！" 10 60
				else
				whiptail --title "deepin-wine" --msgbox "安装失败，请进入install目录尝试手动安装！" 10 60
				fi
				install_menu;
			else
				main_menu;
			fi;;
		2)
			if(whiptail --title "安装确认" --yesno "请确保Deepin-Wine已经安装!!! 确认开始安装微信2.6.8吗?" 10 50)then
				{
					sleep 1
					echo 5
					if [ ! -f "install/deepin.com.wechat_2.6.8deepin0_i386.deb" ];then
					wget -q http://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.wechat/deepin.com.wechat_2.6.2.31deepin0_i386.deb -P install/ >/dev/null 
					fi
					sleep 1 
					echo 55
					sudo dpkg -i install/deepin.com.wechat_2.6.8deepin0_i386.deb >/dev/null 
					sleep 10
				} | whiptail --gauge "正在安装微信2.6.8，过程可能需要几分钟请稍候........." 6 60 0 &&
				if [ `dpkg -l | grep deepin.com.wechat |wc -l` -ne 0 ];then
				whiptail --title "deepin-wine" --msgbox "安装完成，请打开程序，在设置中关闭自动更新！" 10 60
				else
				whiptail --title "deepin-wine" --msgbox "安装失败，请进入install目录尝试手动安装！" 10 60
				fi
				install_menu;
			else
				main_menu;
			fi;;
		x)
			whiptail --title "警告" --msgbox "Beta功能无法保证所有程序完美运行 \ 运行时有几率导致终端未响应 \ 杀死install进程或强制重启终端即可 \ 如需清除请手动执行[rm -rf ~/.winebuild]" 10 60
			EXE=$(whiptail --title "安装确认" --inputbox "请将exe程序放置在install目录下 输入程序名称,确认开始运行" 10 50 example.exe 3>&1 1>&2 2>&3)
				exitstatus=$?
				if [ $exitstatus = 0 ]; then
    				WINEPREFIX=~/.winebuild deepin-wine install/$EXE >/dev/null
    				whiptail --title "deepin-wine" --msgbox "安装完成，请尝试运行程序！" 10 60
    				install_menu;
				else
				    main_menu;
				fi
    esac
else
    main_menu;
fi
}
function update_menu(){
			whiptail --title "警告" --msgbox "请先卸载对应程序再执行更新，否则更新无效！" 10 60
			DEB=$(whiptail --title "安装确认" --inputbox "请将deb更新包放置在update目录下 输入更新包名称,确认开始更新" 10 50 example.deb 3>&1 1>&2 2>&3)
				exitstatus=$?
				if [ $exitstatus = 0 ]; then
    				sudo dpkg -i update/$DEB >/dev/null
    				whiptail --title "deepin-wine" --msgbox "更新完成，请运行程序查看！" 10 60
    				main_menu;
				else
				    main_menu;
				fi
}
function uninstall_menu(){
option3=$(whiptail --title "卸载" --clear --menu "请选择" 12 50 4 \
    "1" "卸载企业微信" \
    "2" "卸载微信" \
    "3" "卸载deepin-wine环境" \
    3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    case $option3 in
    1)
	    if(whiptail --title "卸载确认" --yesno " 确认开始卸载企业微信吗?" 10 50)then
				{
					sleep 1
					echo 5
					sudo apt-get remove -y deepin.com.weixin.work >/dev/null		
					sleep 1
					echo 55
					rm -rf ~/.deepinwine/Deepin-WXWork >/dev/null
					sleep 10
				} | whiptail --gauge "正在卸载企业微信，请稍候........." 6 60 0 &&
				if [ `dpkg -l | grep deepin.com.weixin.work |grep "^ii" |wc -l` -ge 1 ];then
				whiptail --title "deepin-wine" --msgbox "卸载失败，请尝试手动卸载！" 10 60
				else
				whiptail --title "deepin-wine" --msgbox "卸载完成！" 10 60
				fi
				uninstall_menu;
			else
				main_menu;
			fi;;
		2)
	    if(whiptail --title "卸载确认" --yesno " 确认开始卸载微信吗?" 10 50)then
				{
					sleep 1
					echo 5
					sudo apt-get remove -y deepin.com.wechat >/dev/null
					sleep 1
					echo 55
					rm -rf ~/.deepinwine/Deepin-WeChat >/dev/null	
					sleep 10
				} | whiptail --gauge "正在卸载微信，请稍候........." 6 60 0 &&
				if [ `dpkg -l | grep deepin.com.wechat | grep "^ii"|wc -l` -ge 1 ];then
				whiptail --title "deepin-wine" --msgbox "卸载失败，请尝试手动卸载！" 10 60
				else
				whiptail --title "deepin-wine" --msgbox "卸载完成！" 10 60
				fi
				uninstall_menu;
			else
				main_menu;
			fi;;
		3)
	    if(whiptail --title "卸载确认" --yesno " 确认开始卸载deepin-wine吗?" 10 50)then
				{
					sleep 1
					echo 5
					sudo apt-get remove -y *deepin*wine* udis86 >/dev/null			
					sleep 1
					echo 55
					rm -rf ~/.deepinwine >/dev/null
					rm -rf ~/.winebuild >/dev/null
					sleep 10
				} | whiptail --gauge "正在卸载deepin-wine，请稍候........." 6 60 0 &&
				if [ `dpkg -l | grep deepin.wine |grep "^ii" |wc -l` -ge 1 ];then
				whiptail --title "deepin-wine" --msgbox "卸载失败，请尝试手动卸载！" 10 60
				else
				whiptail --title "deepin-wine" --msgbox "卸载完成！" 10 60
				fi
				uninstall_menu;
			else
				main_menu;
			fi;;
		esac
else
	main_menu
fi
}
main_menu
