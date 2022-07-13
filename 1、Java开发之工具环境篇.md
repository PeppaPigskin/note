# 1、OS——终端常用命令

## 1、mac常用命令

```bash
# 查看IP
    ipconfig
# 终端连接虚拟机
     ssh [账户名]@[服务地址]
# Mac显示“您没有权限来打开应用 eclipse”的问题
    codesign -f -s - --deep <拖动软件app到终端>
```

## 2、linux常用命令

```markdown
# 参考链接
    https://mp.weixin.qq.com/s/64m8VxQxTNvSLyoO13ccVA

# 查看linux内核版本
    cat /proc/version

# 查看Centos版本
    cat /etc/redhat-release

# 数据传输
-- 上传本地文件到服务器指定目录————scp [本地文件所在路径]/[文件名]  [账户名]@[服务地址]:[服务端指定目录]
-- 从服务器下载到本地目录————scp [账户名]@[服务地址]:[服务端文件所在路径]/[文件名]  [本地目录]
-- 从服务器下载整个目录————scp -r [账户名]@[服务地址]:[远程目录]  [本地目录]
-- 上传整个目录到服务器————scp -r   [本地目录]  [账户名]@[服务地址]:/[远程目录]

# 过滤查看所有进程
    ps aux | grep [过滤条件:svnserve]

# 查看系统上的运行的所有进程
    ps -ef |grep [过滤条件:oauth]
    -- 参数————-e————显示运行在系统上的所有进程
    -- 参数————-f————扩展显示输出

# 查看端口占用情况
    lsof -i:[端口号]

# 强行终止进程
    kill -9 [进程号]

# 查看当前所在目录
    pwd

# 实时查看服务启动日志
    tail -300f nohup.out————300设置可查看的显示行数,nohup.out为日志文件名

# 查看内存使用情况
    free -m

# 显示默认网卡信息
    ip route show

# 查看当前主机名
    hostname

# 指定新主机名
    hostnamectl set-hostname <newhostname>

# 关闭防火墙
-- 关闭firewall
    1、firewall-cmd --state————查看默认防火墙状态（关闭后显示notrunning，开启后显示running）
    2、systemctl disable firewalld.service————禁止firewall开机启动
    3、systemctl stop firewalld.service————停止firewall运行

-- iptables防火墙
    1、service iptables stop————临时关闭，即时生效，重启失效
    2、chkconfig iptables off————永久关闭，重启生效，永不失效
```

# 2、Windows——常用软件环境搭建

## 1、Win10 企业版密钥

```bash
# 密钥 1:
NG4HW-VH26C-733KW-K6F98-J8CK4
# 密钥 2:
XKY4K-2NRWR-8F6P2-448RF-CRYQH
# 密钥 3:
NTVHT-YF2M4-J9FJG-BJD66-YG667
```

## 2、Windows下使用SQLyog定时备份数据库

​        `1、在自己想要备份数据的文件目录中创建三个空文件backup.sql,backup.xml,backuplog.log，分别用于存储备份的数据脚本、配置文件、日志信息:`

<img src="image/img01/img1_2_2_1.png" style="zoom:50%;" />

​        `2、打开SQLyog，依次选择菜单项中的增强工具——>计划备份，将弹出如下窗:`

<img src="image/img01/img1_2_2_2.png" style="zoom:50%;" />

​        `3、点击下一步,在弹出的如下窗口中选择需要备份的数据库，点击下一步:`

<img src="image/img01/img1_2_2_3.png" style="zoom:50%;" />

​        `4、选择导出的对象，点击下一步:`

<img src="image/img01/img1_2_2_4.png" style="zoom:50%;" />

​        `5、选择第一步创建的以.sql为后缀的文件，并设置脚本生成方式，点击下一步:`

<img src="image/img01/img1_2_2_5.png" style="zoom:50%;" />

​        `6、选择要生成的选项，点击下一步:`

<img src="image/img01/img1_2_2_6.png" style="zoom:50%;" />

​        `7、选择备份数据的文件字符集为utf-8,点击下一步:`

<img src="image/img01/img1_2_2_7.png" style="zoom:50%;" />

​        `8、出现错误终止或者发邮件依个人需求而定，点击下一步:`

<img src="image/img01/img1_2_2_8.png" style="zoom:50%;" />

​        `9、选择执行任务的方式和第一步创建的以.log为后缀的日志文件，点击下一步:`

<img src="image/img01/img1_2_2_9.png" style="zoom:50%;" />

​        `10、选择工作文件地址（即为第一步创建的以.xml为后缀的配置文件）以及调度名称，然后点击完成:`

<img src="image/img01/img1_2_2_10.png" style="zoom:50%;" />

​        `11、点击完成后会弹出对话框，点击计划，点击新建，选择需要执行的时间点，点击确定即可:`

<img src="image/img01/img1_2_2_11.png" style="zoom:50%;" />

## 3、Windows计划任务设置数据自动备份

`1、使用记事本创建文本文件，并设置其内容如备注内容:`

```bash
@echo off
:: 该行代码的意思是将位于【源文件路径：C:\Downloads\SourceFolder】下的内容复制到【目标文件路径：D:\TargetFolder】中，其中：【/e：拷贝所有子目录，包括空子目录】、【/I： 如果目标文件或目录不存在且拷贝的文件数多于一，则假设目标为目录】、【/d：只拷贝文件日期与在目标文件后的文件（即修改过的源文件）】、【/h：同时拷贝隐藏文件和系统文件】、【/r：拷贝并覆盖只读文件】、【/y： 复制文件审核设置（不显示已有文件覆盖确认）】
xcopy "C:\Downloads\SourceFolder" "D:\TargetFolder" /e/I/d/h/r/y
Exit
```

`2、将设置好的文本文件保存关闭。并重新设置其扩展名为.bat，如图所示:`

<img src="image/img01/img1_2_3_1.png" style="zoom:50%;" />

`3、依次打开控制面板——>管理工具——>任务计划程序，打开后界面如图所示:`

<img src="image/img01/img1_2_3_2.png" style="zoom:50%;" />

`4、在弹出界面操作模块中，点击创建基本任务选项，如图红框所示:`

<img src="image/img01/img1_2_3_3.png" style="zoom:50%;" />

`5、在弹出的创建基本任务向导窗口中设置自己想要的名称和描述信息，点击下一步:`

<img src="image/img01/img1_2_3_4.png" style="zoom:50%;" />

`6、设置触发器内容，根据自身需求选择要备份的频次，点击下一步:`

<img src="image/img01/img1_2_3_5.png" style="zoom:50%;" />

`7、设置每次备份的开始时间以及间隔，点击下一步:`

<img src="image/img01/img1_2_3_6.png" style="zoom:50%;" />

`8、此处选择启动程序选项，点击下一步:`

<img src="image/img01/img1_2_3_7.png" style="zoom:50%;" />

`9、点击浏览,选择第二步创建的xxx.bat文件，点击下一步，然后点击完成即可:`

<img src="image/img01/img1_2_3_8.png" style="zoom:50%;" />

# 3、Mac——常用软件环境搭建

## 1、iTerm2 + Oh My Zsh 终端

```bash
1、zsh安装
    1)zsh安装命令
        brew install zsh
    2)查看是否已安装
        zsh --version
    3)设置为默认
        chsh -s /usr/local/bin/zsh
2、iterm2安装
    1)iterm2安装命令
        brew install iterm2
    2)设置其为默认
        iTerm2 -> Make ITerm2 Default Term
3、oh-my-zsh安装/卸载
    1)安装方式一
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    2)安装方式二
        sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/ohmyzsh/ohmyzsh/tools/install.sh)"
    3)卸载方式
        uninstall_oh_my_zsh
    4)出现[oh-my-zsh] 提示检测到不安全的完成相关目录，解决方式
4、配置主题【https://github.com/ohmyzsh/ohmyzsh/wiki/Themes】
    ZSH_THEME="agnoster" # 以agnoster为例，编辑【~/.zshrc】文件，修改【ZSH_THEME】配置
5、设置字体
    1)大部分主题用到的字体【Meslo for Powerline】
    【字体文件,详见————[附件——Meslo LG S Regular for Powerline.ttf]】
    2)agnoster还需要额外安装字体【Powerline Fonts】
    【https://github.com/powerline/fonts】  
    3)选择字体
    【iTerm -> Preferences -> Profiles -> Text -> Change Font】
6、命令自动补全功能【zsh-autosuggestions】
    1)克隆代码到$ZSH_CUSTOM/plugins（默认位于~/.oh-my-zsh/custom/plugins）
        git clone https://gitee.com/imirror/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    2)下载该插件到.oh-my-zsh/plugins目录
        git clone git://github.com/zsh-users/zsh-autosuggestions 
    3)在Oh My Zsh配置启用插件，打开~/.zshrc，找到plugins，追加zsh-autosuggestions
        plugins=(git zsh-autosuggestions)
    4)执行source ~/.zshrc生效
    5)如果有看不到补全到问题，确保以下两个颜色不是相近的：
        iTerm > Preferences > Profiles > Colors > ANSI Colors > Bright > Black
        iTerm > Preferences > Profiles > Colors > Basic Colors > Background
7、语法高亮【zsh-syntax-highlighting】
    1)克隆代码到$ZSH_CUSTOM/plugins（默认位于~/.oh-my-zsh/custom/plugins）
        git clone https://gitee.com/imirror/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    2)在Oh My Zsh配置启用插件，打开【~/.zshrc】，找到plugins，追加zsh-autosuggestions
        plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
    3)执行【source ~/.zshrc】生效
```

[附件——Meslo LG S Regular for Powerline.ttf](attachments/iTerm2/Meslo LG S Regular for Powerline.ttf)

## 2、Brew 安装和卸载

```markdown
# 安装命令
    /bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"

# 卸载命令
    /bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/HomebrewUninstall.sh)"

# brew常用命令
  -- brew install formulae————安装软件
  -- brew uninstall formulae————卸载软件
  -- brew info／home formulae————查看软件信息
  -- brew update————升级 brew 自身和包(formulae),建议安装前输入
  -- brew outdated————查找本机版本已经落后的包
  -- brew upgrade————升级所有版本落后的包
  -- brew upgrade formulae————单独升级指定包
  -- brew pin formulae————锁定指定包的版本,不允许升级
  -- brew unpin formulae————解锁指定包,允许升级
  -- brew cleanup————清理全部版本过期的包
  -- brew doctor————当你的 brew 运行不正常,试试这个
  -- brew search ruby————搜索和 ruby 相关的包
  -- brew list————显示本机已经安装的包
  -- man brew————显示更多brew命令帮助
  -- brew deps————显示包依赖

# 安装指定版本的软件
    1、brew官网搜索指定包名————https://brew.sh/
    2、通过Cask code on GitHub,找到其在GitHub的仓库对应的xxx.rb文件————单击Cask code超链接
    3、查看其历史提交记录————点击History按钮
    4、找到对应版本的历史提交记录单机进入吃,查看详细————单击View at this point in the history按钮
    5、终端输入以下命令创建指定文档————touch xxx.rb
    6、终端输入以下命令打开并编辑文档————open -e goland.rb
    7、将第4步的详细内容拷贝到创建的指定文档
    8、执行如下命令进行安装————brew install xxx.rb

# 完全清除安装包相关文件
    1、卸载指定软件————brew方式采用[brew uninstall 包名]进行卸载,[.app]安装包通过图标进行卸载,并删除.app文件
    2、删除如下目录下的App名称目录
        1)~/Library/Preferences/
        2)~/Library/Caches/
        3)~/Library/Application Support/
        4)~/Library/Logs/
    3、同理，如果想要初始化配置啥的，也可以删除对应的目录，重启即可
```

## 3、Mac OS 环境搭建

```bash
# 解决brew安装软件检测不安全
# 取消安全检测
sudo spctl --master-disable
Security & Privacy->Anywhere
# 开启安全检测
sudo spctl --master-enable
# 说明
 --disable
          Disable one or more rules in the assessment rule database.  Dis-
          abled rules are not considered when performing assessment, but
          remain in the database and can be re-enabled later.
 --enable
          Enable rule(s) in the assessment rule database, counteracting
          earlier disabling.
```

## 4、VMware Fusion 12pro 密钥

```bash
# 许可证密钥一:
ZF3R0-FHED2-M80TY-8QYGC-NPKYF
# 许可证密钥二:
YF390-0HF8P-M81RQ-2DXQE-M2UT6
# 许可证密钥三:
ZF71R-DMX85-08DQY-8YMNC-PPHV8
```

## 5、远程控制工具sunloginclient

```bash
1、说明
    向日葵是一款阳光的远程控制软件。您可在任何可连入互联网的地方，轻松访问和控制安装了向日葵客户端的设备，且目前支持电脑、手机等多种控制端的方式进行远控。
2、安装
    brew install sunloginclient
3、问题处理
    # mac授权问题————
        -- 进入终端su账户
            sudo su
        -- 执行命令
            tccutil reset Accessibility
        -- 重启电脑
        -- 进行授权
            系统偏好设置——>安全性与隐私——>隐私——>进行相应权限的授权
            授权说明——https://service.oray.com/question/10558.html
```

## 6、终端工具Tabby

```markdown
1、说明
2、安装
    brew install tabby
```

## 7、虚拟机连接工具finalshell

```markdown
# 说明
    FinalShell 是一款免费的国产的集 SSH 工具、服务器管理、远程桌面加速的良心软件，同时支持 Windows,macOS,Linux，它不单单是一个 SSH 工具，完整的说法应该叫一体化的的服务器，网络管理软件，在很大程度上可以免费替代 XShell，是国产中不多见的良心产品，具有免费海外服务器远程桌面加速，ssh 加速，双边 tcp 加速，内网穿透等特色功能。

# 安装
    brew install finalshell

# 官方地址
    http://www.hostbuf.com/t/988.html
```

## 8、安卓模拟器noxappplayer

```markdown
# 说明
    Nox App Player是一个免费的Android操作系统模拟器,可让您在PC上运行Android应用程序。也提供单独的Mac版本。

# 安装
    brew install --cask noxappplayer
```

## 9、设置VPN

```markdown
# MacOS客户端配置方法
-- 1.系统偏好设置————>网络————>选择“+”添加
    接口设置为————VPN
    VPN类型选择————L2TP/IPSec
    服务名————随意

-- 2.设置基本信息如下:
    配置————默认
    服务器地址设置为————124.2xx.x.xxx
    帐户名设置为————个人账户名

-- 3.点击“认证设置“,进行如下设置,点击保存:
    用户认证————>密码————输入个人密码
    机器认证————>共享的密钥————输入共享密钥

-- 4.点击“高级”,进行如下设置,其他默认:
    选项————勾选————通过VPN连接发送所有流量
    TCP/IP————配置IPv4(设置为关闭)/配置IPv6(设置为自动)
    DNS————DNS服务器列表添加————192.168.x.xxx（这样连上VPN后可以通过域名访问SVN、CRM、Mail等系统）
    代理————选择一个协议进行配置——————自动发现代理

-- 5.点击链接进行测试使用
    终端执行命令,判断是否能够ping通外网————ping www.baidu.com
    连接上vpn,判断是否能够正常使用

# windows7客户端配置方法
-- 1.打开网络和共享中心————>选设置新的连接或网络

-- 2.点击————>连接到工作区————>使用我的internet连接VPN,输入Internet地址如下,目标名称随便:
    124.2xx.x.xxx

-- 3.输入账号名————密码————连接————点击跳过
    账户名设置为————个人账户名
    密码为————个人密码

-- 4.进入更改适配器设置————>VPN右键属性————>安全————>VPN类型选择如下:
    使用IPSEC的第2层隧道协议（L2TP/IPSec）

-- 5.点高级设置————>使用预共享的秘钥作身份验证————>秘钥xxxxxx————>存退出

-- 6.点击VPN右键连接————>输入用户名密码————>属性————>网络————>DNS设置如下:
    192.168.x.xxx（这样连上VPN后可以通过域名访问SVN、CRM、Mail等系统）

-- 7.Ipsec协议(一个公网IP只允许连接一个vpn账号登录)多人在一个公网的网络使用vpn账号登录pptp协议,在vpn属性————>安全————>VPN类型选择如下:
    点对点隧道协议（PPTP）

# windows10客户端配置方法
-- 1.点开选择网络设置————>点击VPN

-- 2.击左侧“+”号————>新建VPN

-- 3.设置如下内容项，配置完点击保存————点击————>连接
    VPN提供商————windows(内置)
    连接名称————随意设置
    服务器名称或地址————124.2xx.x.xxx
    VPN类型————使用与之共享密钥的L2TP/IPSec
    预共享秘钥————xxxxxx
    账户名称————根据提供的填写

-- 4.点击VPN右键连接————>输入用户名密码————>属性————>网络————>DNS设置如下:
    192.168.x.xxx（这样连上VPN后可以通过域名访问SVN、CRM、Mail等系统）

-- 5.Ipsec协议(一个公网IP只允许连接一个vpn账号登录)多人在一个公网的网络使用vpn账号登录pptp协议,VPN类型选择如下:
    点对点隧道协议（PPTP）
```

## 10、屏幕录制及截图软件iShot

```markdown
# 说明
    Mac截图/长截图/全屏带壳截图/贴图/标注/取色/录屏/录音/OCR，九合一工具

# 安装
    AppStore安装
```

## 11、windows远程桌面工具

```markdown
# 说明
    Mac用于连接windows远程桌面的工具

# 安装
    brew install microsoft-remote-desktop
```

## 12、在线绘图工具

```markdown
# 说明
    它是一款在线画图工具，功能非常强大， 它里面支持流程图、思维导图、原型图、UML、网络拓扑、组织结构等多种类型，非常丰富，唯一的缺点就是只能免费保存9张图，想要保存更多的，需要进行付费升级。

# 使用
-- 进入如下地址,直接开始绘图
    https://excalidraw.com/
```

# 4、Java——开发环境搭建

## 1、JDK安装与配置

```markdown
# 安装
-- 获取 Homebrew 历史版本库
        brew tap homebrew/cask-versions
-- 使用 brew install xxx 命令安装对应版本jdk
    1、安装 jdk6，执行如下命令，其将安装到【/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home】下
        brew install java6
    2、安装 jdk8，执行如下命令，其将安装到【/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home】下
        brew install adoptopenjdk8

# 环境配置
-- 如果安装了zsh,会导致【~/.bash_profile】不会被执行
    解决方式————执行命令【vim ~/.zshrc】打开【zshrc】文件,并添加【source ~/.bash_profile】,此时【~/.bash_profile】配置的环境变量将有效
-- 执行命令【vim ~/.bash_profile】改【bash_profile】文件,添加如下内容:
  #配置 jdk 环境
  export JAVA_6_HOME=/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
  export JAVA_8_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
  #编辑一个命令 jdk6，输入则转至 jdk1.6
  alias jdk6="export JAVA_HOME=$JAVA_6_HOME"
  #编辑一个命令 jdk8，输入则转至 jdk1.8
  alias jdk8="export JAVA_HOME=$JAVA_8_HOME"
  #最后安装的版本，这样当自动更新时，始终指向最新版本
  export JAVA_HOME=`/usr/libexec/java_home`

# 查看JDK版本
    java -version
```

## 2、IDEA安装与配置

```markdown
# 说明
    IDEA 全称 IntelliJ IDEA，是java编程语言开发的集成环境。IntelliJ在业界被公认为最好的java开发工具，尤其在智能代码助手、代码自动提示、重构、JavaEE支持、各类版本工具(git、svn等)、JUnit、CVS整合、代码分析、 创新的GUI设计等方面的功能可以说是超常的。IDEA是JetBrains公司的产品，这家公司总部位于捷克共和国的首都布拉格，开发人员以严谨著称的东欧程序员为主。它的旗舰版本还支持HTML，CSS，PHP，MySQL，Python等。免费版只支持Java,Kotlin等少数语言。

# 安装
    brew install intellij-idea

# 注册激活
-- 插件激活(建议————版本太新好像不支持,本人2021.2可以)
    1、设置第三方插件仓库地址[https://plugins.zhile.io]
            IntelliJ IDEA——>Preferences——>Plugins——>设置图标——>Manage Plugin Repositories...——>添加第三方插件仓库地址
    2、下载安装IDE Eval Reset插件
            IntelliJ IDEA——>Preferences——>Plugins——>Marketplace——>搜索[IDE Eval Reset]
    3、设置每次开启自动重置注册信息
            Help——>Eval Reset——>勾选[Auto reset before per restart]项

-- 注册码激活
        -- 石墨文档————https://shimo.im/docs/XvW3WpHgHdRHVXgV/read
        -- 文档获取————https://docs.qq.com/doc/DTVh3bkxWSEpvVm5N
        -- 网址激活————http://www.lookdiv.com/————输入[7788]获取激活码

# 常用设置————https://blog.csdn.net/qq_38586496/article/details/109382560

# IDEA风格配置导出文件详见————[附件——settings.zip]

# 常用插件
-- Lombok————简化你的实体类不再写get/set方法，还能快速的实现builder模式，以及链式调用方法，总之就是为了简化实体类而生的插件

-- Free Mybatis Plugin————一个提高mybatis编码的插件。实现了dao层跳转到xml层的跳转功能

-- Mybatis-log-plugin————根据mybatis输出的sql日志，转换为拼接好参数的sql

-- Jrebel————一款比较好用的热部署插件，省去了一直重启的麻烦，尤其适合项目比较大的，能够节省不少时间
    1、详情参考1————https://blog.csdn.net/top_explore/article/details/107321541
    1、详情参考2————https://blog.csdn.net/seanxwq/article/details/89892614

-- RestfulToolkit
    1、根据 URL 直接跳转到对应的方法定义 ( Ctrl \ or Ctrl Alt N );
    2、提供了一个 Services tree 的显示窗口;
    3、一个简单的 http 请求工具;
    4、在请求方法上添加了有用功能: 复制生成 URL;,复制方法参数...
    5、其他功能: java 类上添加 Convert to JSON 功能，格式化 json 数据 ( Windows: Ctrl + Enter; Mac: Command + Enter )

-- redis————redis客户端工具，不需要再去安装第三方客户端，相对方便许多

-- Vuesion Theme————一款皮肤插件.非常适中的UI颜色,漂亮的代码高亮主题

-- Atom Material ICons————一款ICON插件.解决了idea在macOs下,感觉在拖动滚动条或是鼠标中键滚屏时有点卡顿

-- File Expander————能在Idea里直接打开Jar包,并且反编译代码查看.甚至于能打开tar.gz,zip等压缩格式

-- GitToolBox————能在项目上提示你还有多少文件没提交,远程还有多少文件没更新下来,还能在每一行代码上提示上次提交的时间,查版本提交问题的时候尤其方便

-- Maven Helper————可视化依赖书,可以清晰的知道,哪个Jar包传递依赖了什么,哪个jar包什么版本和什么版本冲突了.排查Jar包依赖等问题用这个简直是神器

-- GsonFormat————超级实用的一个插件，对接第三方接口，通常需要将对方的json字符串转实体类，搞的很是头疼。使用GsonFormat我们只需要创建一个类，然后把要转换的json字符串复制进去，点击OK它就会给我们生成相应的实体对象。

-- Translation————不需要你切换窗口,直接一个快捷键就可以翻译整段文本了.这个插件的翻译引擎可以与多个翻译接口集成对接，支持google翻译，有道翻译，百度翻译，阿里翻译。实时进行精准快速的翻译，自动识别语言。帮助你在阅读源码里的英文时理解的更加透彻。

-- arthas idea————阿里开源的一款强大的java在线诊断工具.有了arthas这种神器可以线上输出日志，但是watch语法还是不够简单，因此Idea arthas 插件就此横空出世，插件安装成功后，只需要将光标放置在具体的类、字段、方法上面 右键选择需要执行的命令，部分会有窗口弹出、根据界面操作获取命令；部分直接获取命令复制到了剪切板 ，自己启动arthas 后粘贴即可执行。

-- Search In Repository————平时我们如果要依赖一个第三方jar包，但是不知道它的maven/gradle的坐标。搓点的做法基本上就是baidu了，稍微高级点的就是到中央仓库去查下，最新版本的坐标是什么。然后复制下来，贴到pom里去。这款插件，无需你来回跳转，直接把中央仓库的查找集成到了Idea里面。你只需要打开这款插件，输入jar包的名字或者gav关键字，就能查到到这个jar包所有的版本，然后可以直接复制gav坐标。方便又快捷，干净又卫生！

-- VisualGC————Idea堆栈的可视化工具，和Idea深度集成。直接显示所有进程，双击即可打开JVM的堆栈可视化界面。堆栈和垃圾收集情况一目了然！

-- Zoolytic————一款zookeeper节点的查看分析插件。其实第三方也有一些zk的节点信息查看工具，但是我都觉得不够方便，直到我发现了这款插件。
```

[附件——settings.zip](attachments/IDEA/settings.zip)

## 3、域名访问环境

​        IP访问规则

​            `浏览器输入访问地址————>查看系统内部域名映射规则(有映射:网卡将请求转到映射的域名;没有映射:去网络上的DNS解析域名,DNS公网保存了每一个域名对应的IP地址)`

​        switchhosts用于将本地网路请求转发到指定地址(模拟域名跳转).

​        开发环境结合Nginx实现对域名访问环境的搭建.通过将浏览器发送的请求域名全部转发到指定nginx的对应虚拟机IP地址.生产环境就需要`购买指定域名————>进行注册使用`,开发环境配置如下:

```bash
1、下载安装修改hosts文件的软件
    brew install switchhosts
2、通过该软件修改hosts文件
    1)配置格式如下
        虚拟机IP地址 请求域名
    1)默认规则
    ##
    # Host Database
    #
    # localhost is used to configure the loopback interface
    # when the system is booting. Do not change this entry.
    ##
    127.0.0.1 localhost
    255.255.255.255 broadcasthost
    ::1 localhost
    2)配置示例
        #idea屏蔽更新
    127.0.0.1 account.jetbrains.com
    127.0.0.1 jrebel.npegeek.com
    127.0.0.1 oauth.account.jetbrains.com
    127.0.0.1 SteveCode.jetbrains.com

    #pigskin_mall
    192.168.56.101 pigskinmall.com
    192.168.56.101 search.pigskinmall.com
    192.168.56.101 item.pigskinmall.com
    192.168.56.101 auth.pigskinmall.com
    192.168.56.101 cart.pigskinmall.com
    192.168.56.101 order.pigskinmall.com

    #单点登录演示修改域名
    127.0.0.1 ssoserver.com
    127.0.0.1 client1.com
    127.0.0.1 client2.com
3、测试,请求就会跳转到指定的IP地址
     http://pigskinmall.com:5601/ ————就会成功跳转到虚拟机中的指定端口
```

## 4、性能测试工具

```bash
1、下载
brew install VisualVM
2、使用
```

## 5、压力测试工具

```markdown
# 下载
    https://archive.apache.org/dist/jmeter/binaries/

# 安装
    解压下载的压缩包————apache-jmeter-5.2.1.tgz

# 启动
    -- 进入指定目录————cd MyInstall/apache-jmeter-5.2.1/bin/
    -- 运行————jmeter.bat/终端————执行sh jmeter
```

## 6、Git 环境配置

```markdown
# 注册码云账号————https://gitee.com/

# 下载安装git————https://git-scm.com/
    brew install git
# 进入git控制台,配置用户名和邮箱
-- 配置用户名————git config --global user.name "PeppaPigskin"
-- 配置邮箱————git config --global user.email "178xxxx932@qq.com"

# 配置ssh免密登录————https://gitee.com/help/articles/4181#article-header0

# 测试是否配置成功————ssh -T git@gitee.com
```

## 7、Tomcat 安装与配置

```markdown
# 安装命令
    brew install tomcat@8

# 安装完提示信息
  Configuration files: /usr/local/etc/tomcat@8

  tomcat@8 is keg-only, which means it was not symlinked into /usr/local,
  because this is an alternate version of another formula.

  If you need to have tomcat@8 first in your PATH, run:
    echo 'export PATH="/usr/local/opt/tomcat@8/bin:$PATH"' >> ~/.zshrc


  To restart tomcat@8 after an upgrade:
    brew services restart tomcat@8
  Or, if you don't want/need a background service you can just run:
    /usr/local/opt/tomcat@8/bin/catalina run

# 配置
    1、执行命令———— echo 'export PATH="/usr/local/opt/tomcat@8/bin:$PATH"' >> ~/.zshrc
    2、重启服务———— brew services restart tomcat@8
    3、查看安装文件所在目录————brew list tomcat@8
```

## 8、Mysql 安装与配置

### 1、安装mysql@5.7

```bash
1、安装mysql@5.7
    brew install mysql@5.7
2、配置使用【vim ~/.bash_profile】打开，添加以下内容，使用【source ~/.bash_profile】保存
    export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
3、修改密码，使用命令【mysql -uroot -p】
    brew services start mysql@5.7 # 启动 mysql
    set password for 'root'@'localhost'=PASSWORD('root123'); # 修改密码
4、刷新修改结果
    FLUSH PRIVILEGES;
```

### 2、安装mysql 8.0.26

```bash
1、安装mysql 8.0.26
    brew install mysql
2、配置使用【vim ~/.bash_profile】打开，添加以下内容，使用【source ~/.bash_profile】保存
    export PATH="/usr/local/opt/mysql@8.0/bin:$PATH"
3、修改密码，使用命令【mysql -uroot -p】
    brew services start mysql # 启动 mysql
    ALTER USER 'root'@'localhost' IDENTIFIED BY 'root123';
4、刷新修改结果
    FLUSH PRIVILEGES;
```

## 9、Nacos环境搭建

```bash
1、下载
    https://github.com/alibaba/nacos/releases
2、启动:进入bin目录,执行以下命令
    sh startup.sh -m standalone
3、网页登陆
    http://127.0.0.1:8848/nacos/# /login
4、终端测试是否启动成功
    curl http://127.0.0.1:8848/nacos
5、关闭：进入bin目录，执行以下命令
    sh shutdown.sh
6、命令关闭不了的情况下，使用杀死进程方式
    1)查看端口占用进程
        lsof -i:8848
    2)终止制定进程
        kill -9 xxx 
```

## 10、Webpack安装

```bash
1、安装
    npm install webpack@4.16.5 -g
    npm i webpack -D
    npm i webpack-cli -D
    npm install  webpack-cli@3.1.0 -g 
2、打包css需安装插件
    npm install --save-dev style-loader@0.19.1 css-loader@0.28.3
3、卸载
    npm uninstall -g webpack webpack-cli
    npm uninstall webpack webpack-cli --save-dev
```

## 11、Node环境搭建(npm同时也会安装好)

```bash
1、安装nvm
    brew install nvm 
2、配置nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  #  This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  #      This loads nvm bash_completion
3、查看所有node版本
    nvm ls-remote
4、下载安装指定版本node
    nvm install v10.14.2
    # 安装完提示信息
  node@14 is keg-only, which means it was not symlinked into /usr/local,
  because this is an alternate version of another formula.
  If you need to have node@14 first in your PATH, run:
    echo 'export PATH="/usr/local/opt/node@14/bin:$PATH"' >> ~/.zshrc
  For compilers to find node@14 you may need to set:
    export LDFLAGS="-L/usr/local/opt/node@14/lib"
    export CPPFLAGS="-I/usr/local/opt/node@14/include"
5、环境配置(nvm安装的不用配置)
    1)进入配置目录
        cd /etc/profile
    2)添加配置
        export NODE_HOME="node安装路径(bin路径的父级路径)" 
        export PATH=$PATH:$NODE_HOME/bin
```

## 12、Apifox安装与配置

```bash
1、说明
    Apifox是 API 文档、API 调试、API Mock、API 自动化测试一体化协作平台，定位 Postman + Swagger + Mock + JMeter。通过一套系统、一份数据，解决多个系统之间的数据同步问题。只要定义好 API 文档，API 调试、API 数据 Mock、API 自动化测试就可以直接使用，无需再次定义；API 文档和 API 开发调试使用同一个工具，API 调试完成后即可保证和 API 文档定义完全一致。高效、及时、准确！
2、使用文档
    https://www.apifox.cn/help/
```

## 13、SVN环境搭建

```markdown
# 安装示例
    https://www.jianshu.com/p/79116c6f8f72

# 安装
    brew install subversion

# 配置
-- 1、使用如下命令创建一个SVN的代码仓库（目录改成你想要创建的目录）
        svnadmin create /Users/pigskin/Desktop/CTJ/SZNK/SVN

-- 2、打开conf文件夹,备份[authz、password、svnserve.conf]三个文件

-- 3、svnserve.conf文件的配置————去除如下四部分注释信息
    1、anon-access = read————代表匿名访问可读，可以将其进行修改修改为anon-access = none代表不允许匿名访问。
    2、auth-access = write————代表认证之后可写
    3、passwd-db = passwd————代表密码数据库是passwd文件
    4、authz-db = authz————代表授权数据库为authz文件

-- 4、passwd文件的配置(根据个人SVN账户决定)————[users]下添加用户名和密码,格式如下
    username = password

-- 5、authz文件的配置(根据个人SVN账户决定)————[groups]下创建组,[路径]指定路径下的访问用户或组
  [groups]
  admin = wangwu # 将wangwu用户添加到admin组中
  test = zhangsan,lisi # 将zhangsan,lisi用户添加到test组中

  [/] # 允许访问全部目录，也可以自己修改指定目录
  @admin = rw # 给admin组的成员添加read、write权限,组前要加@
  maliu = rw # 给maliu用户添加read、write权限,单个用户前不用添加@

# 开启服务
    svnserve -d -r [创建的路径:/Users/pigskin/Desktop/CTJ/SVN]

# 关闭服务
    打开[活动监视器]————>搜索[svnserve]————>选中对应服务————>删除

# 使用
-- 从本地导入代码到SVN服务器————svn import [本地文件路径] svn://localhost --username=[用户名] --password=[密码] -m "提交说明"

-- 从SVN服务器下载到本地————svn checkout svn://localhost [本地路径]

-- 提交更新过的代码到SVN服务器————svn commit -m "提交说明"

-- 更新服务器端代码到客户端————svn update

-- 删除在服务器上的文件————svn delete svn://xxx.xxx.xxx.xxx/文件的路径 -m "备注"

-- 查看svn服务器的信息————svn info

-- 版本回退————svn checkout -r [version] svn://localhost /Users/wanna/Desktop/test

# 可视化工具安装与配置
-- SmartSVN
    1、安装————执行安装命令————brew install smartsvn

-- IDEA插件
    1、安装插件————Subversion
    2、配置
        1)在idea菜单栏中进⾏以下操作————Preferences>Version Control>Subversion
        2)在第⼀栏填⼊svn路径(根据个人具体情况而定)————/usr/local/Cellar/subversion/1.14.1_4/bin/svn

# 问题及解决方式
-- E230001————由于SVNssl证书验证失败导致
    1、打开终端,执行以下命令————svn ls [svn地址]
    2、显示(R)eject, accept (t)emporarily or accept (p)ermanently?————输p
    3、根据提⽰输⼊svn账户名UserName和密码Password
    4、再重新拉取代码问题解决

-- svn账号清理
    1、IDEA账号清理
        1)打开IDEA的setting或Preferences
        2)搜索subversion
        3)点击subversion
        4)点击Clear Auth Cache按钮即可
    2、svn账号清理——mac
        1)终端运行命令————rm ~/.subversion/auth/svn.simple/*
    3、svn账号清理——windows
        1)SVN客户端中(以TortoiseSvn为例),右键->tortoisesvn->setting
        2)在弹出的“settings”窗口右侧，点击“Saved Data”
        3)点击左侧的“Authentication”后方的“clear”按钮即可
        4)另外一种方式————找到C:\Documents and Settings\administrator\Application Data\Subversion\auth目录，删除svn.simple目录下的所有文件即可
```

## 14、Go语言开发环境搭建

```bash
1、安装Golang的SDK
    # SDK安装包方式
        0)安装包下载地址:https://golang.org/dl/
        1)双击 .tar 文件，就会自动解压成名字为“go”的文件夹;拖拽到你的用户名下,记住路径;
我的路径为:/Users/pigskin/go
        2)双击pkg包，顺着指引，即可安装成功。
        3)在命令行输入 go version,验证SDK安装成功,获取到go的version，则代表安装成功。
    # 使用brew
        安装————brew install go
2、配置环境变量
    # 打开终端输入以下命令进入用户主目录————cd ~
    # 输入以下命令查看是否存在.bash_profile————ls -all
    # 存在即使用以下命令打开文件————vim .bash_profile
    # 键入以下字符进入编辑模式,并添加如下内容————i
        注意：= 前后没有空格。否则报错误(not a valid identifier)
        1)SDK安装包方式
            # 设置日常开发的根目录
            export GOPATH=/Users/pigskin/go
            # 设置GOPATH下的bin目录
            export GOBIN=$GOPATH/bin
            # 设置Path变量
            export PATH=$PATH:$GOBIN
        2)使用brew安装方式
            # 设置日常开发的根目录
            export GOPATH=/usr/local/Cellar/go/1.17.5
            # 设置GOPATH下的bin目录
            export GOBIN=$GOPATH/bin
            # 设置Path变量
            export PATH=$PATH:$GOBIN
    # 点击ESC，并输入以下命令保存并退出编辑————:wq
  # 可输入以下命令查看是否保存成功————vim .bash_profile
  # 输入以下命令完成对golang环境变量的配置，配置成功没有提示————source ~/.bash_profile 
    # 输入以下命令查看配置结果————go env
3、使用命令行调试
    # 创建工程在go的src目录下，比如我的go目录为/Users/pigskin/go，我创建文件夹 MSTest路径为/Users/pigskin/go/src/MSTest
    # 创建文件 main.go ,输入如下代码,并保存。
        package main

        import "fmt"

        func main() {
            fmt.Println("hello")
        }
  # 在命令行输入如下命令生成exec文件————go build main.go 
  # 点击这个exec 文件，会弹出命令行显示下面的运行结果————hello
4、IDE安装
    brew install goland
```

## 15、Maven环境搭建

```markdown
# 说明
    Maven 是最流行的 Java 项目构建系统，Maven项目对象模型(POM)，可以通过一小段描述信息来管理项目的构建，报告和文档的软件项目管理工具。

# Maven仓库地址
    https://mvnrepository.com/

# 前提条件
    配置好JDK开发环境————详见1、Java开发之工具环境篇-4-1、jdk安装与配置

# 下载安装maven
-- maven安装包apache-maven-3.6.3.zip
    下载位置————https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/

-- 解压下载的安装包到自己想要配置的目录
    我的位置————/Users/pigskin/MyInstall/Maven/

# 环境配置
-- 编辑maven安装位置下的settings.xml文件
    cd  /Users/pigskin/MyInstall/Maven/apache-maven-3.6.3/conf/
-- 配置maven使用阿里云镜像
    <mirrors>   
    <mirror>    
      <id>nexus-aliyun</id>   
      <mirrorOf>central</mirrorOf> 
      <name>Nexus aliyun</name>     
      <url>http://maven.aliyun.com/nexus/content/groups/public</url>  
    </mirror>
  </mirrors>
-- 配置maven使用jdk1.8编译项目
    <profiles>
    <!--自行配置maven使用jdk1.8编译项目-->  
    <profile>        
      <id>jdk-1.8</id>             
      <activation>             
        <activeByDefault>true</activeByDefault>          
        <jdk>1.8</jdk>            
      </activation>              
      <properties>                     
        <maven.compiler.source>1.8</maven.compiler.source>   
        <maven.compiler.target>1.8</maven.compiler.target>  
        <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>   
      </properties>       
    </profile>
  </profiles>

# 查看Maven版本
    mvn -v

# Idea整合maven
-- 配置idea为本地仓库————Idea——>Preferences——>Build...——>Build Tools——>Maven,如下图所示:
```

<img src="image/img01/img1_4_16_1.png" style="zoom:50%;" />

```markdown
-- 安装插件
    1、lombok————简化JavaBean的开发
    2、mybatisx————从一个mapper的方法快速定位到其对应xml文件

# 问题解决
-- 各种环境配置都没问题,但是拉取不到远程仓库的东西
    1、由于idea的Maven采用脱机工作(意思就是不读取远程仓库，只读取本地已有的仓库)选项导致解决办法如下:
        依次打开Maven设置项————Idea——>Preferences——>Build...——>Build Tools——>Maven,去掉勾选项「Work offline」,应用即可.
```

## 16、Seata环境搭建

```markdown
# 下载并安装————根据依赖导入时seata-all-x.x.x.jar的版本选择对应版本seata
-- 从 https://github.com/seata/seata/releases,下载服务器软件包，将其解压缩

# 目录文件说明,及相关配置说明
-- /conf/registry.conf————注册中心相关配置————进行对seata配置中心以及配置所在位置的配置
    registry {
    # 指定注册中心的版本——可选择项为[file 、nacos 、eureka、redis、zk、consul、etcd3、sofa]
    type = "nacos"

    nacos {
      serverAddr = "localhost:8848" # 设置nacos的主机地址
      namespace = "public"
      cluster = "default"
    }
    eureka {
      serviceUrl = "http://localhost:1001/eureka"
      application = "default"
      weight = "1"
    }
    redis {
      serverAddr = "localhost:6379"
      db = "0"
    }
    zk {
      cluster = "default"
      serverAddr = "127.0.0.1:2181"
      session.timeout = 6000
      connect.timeout = 2000
    }
    consul {
      cluster = "default"
      serverAddr = "127.0.0.1:8500"
    }
    etcd3 {
      cluster = "default"
      serverAddr = "http://localhost:2379"
    }
    sofa {
      serverAddr = "127.0.0.1:9603"
      application = "default"
      region = "DEFAULT_ZONE"
      datacenter = "DefaultDataCenter"
      cluster = "default"
      group = "SEATA_GROUP"
      addressWaitTime = "3000"
    }
    file {
      name = "file.conf"
    }
    }
  config {
    # 指定seata的配置所在的位置————file、nacos 、apollo、zk、consul、etcd3
    type = "file"

    nacos {
      serverAddr = "localhost"
      namespace = "public"
      cluster = "default"
    }
    consul {
      serverAddr = "127.0.0.1:8500"
    }
    apollo {
      app.id = "seata-server"
      apollo.meta = "http://192.168.1.204:8801"
    }
    zk {
      serverAddr = "127.0.0.1:2181"
      session.timeout = 6000
      connect.timeout = 2000
    }
    etcd3 {
      serverAddr = "http://localhost:2379"
    }
    file {
      name = "file.conf"
    }
    }

-- /conf/file.conf————注册中心配置类型为file时使用的seate配置文件
    transport {# 传输配置
    # tcp udt unix-domain-socket
    type = "TCP" # 配置使用的传输协议
    #NIO NATIVE
    server = "NIO" # 服务端模式
    #enable heartbeat
    heartbeat = true # 是否有心跳
    #thread factory for netty
    thread-factory { # 线程工厂
      boss-thread-prefix = "NettyBoss"
      worker-thread-prefix = "NettyServerNIOWorker"
      server-executor-thread-prefix = "NettyServerBizHandler"
      share-boss-worker = false
      client-selector-thread-prefix = "NettyClientSelector"
      client-selector-thread-size = 1
      client-worker-thread-prefix = "NettyClientWorkerThread"
      # netty boss thread size,will not be used for UDT
      boss-thread-size = 1
      #auto default pin or 8
      worker-thread-size = 8
    }
    shutdown {
      # when destroy server, wait seconds
      wait = 3
    }
    serialization = "seata"
    compressor = "none"
    }
    service { 
    #vgroup->rgroup
    vgroup_mapping.my_test_tx_group = "default"
    #only support single node
    default.grouplist = "127.0.0.1:8091"
    #degrade current not support
    enableDegrade = false
    #disable
    disable = false
    #unit ms,s,m,h,d represents milliseconds, seconds, minutes, hours, days, default permanent
    max.commit.retry.timeout = "-1"
    max.rollback.retry.timeout = "-1"
    }

    client { # 客户端配置
    async.commit.buffer.limit = 10000
    lock {
      retry.internal = 10
      retry.times = 30
    }
    report.retry.count = 5
    }

    ## transaction log store 事务日志存储位置
    store {
    ## store mode: file、db
    mode = "file"

    ## file store
    file {
      dir = "sessionStore"

      # branch session size , if exceeded first try compress lockkey, still exceeded throws exceptions
      max-branch-session-size = 16384
      # globe session size , if exceeded throws exceptions
      max-global-session-size = 512
      # file buffer size , if exceeded allocate new buffer
      file-write-buffer-cache-size = 16384
      # when recover batch read size
      session.reload.read_size = 100
      # async, sync
      flush-disk-mode = async
    }

    ## database store
    db {
      ## the implement of javax.sql.DataSource, such as DruidDataSource(druid)/BasicDataSource(dbcp) etc.
      datasource = "dbcp"
      ## mysql/oracle/h2/oceanbase etc.
      db-type = "mysql"
      url = "jdbc:mysql://127.0.0.1:3306/seata"
      user = "mysql"
      password = "mysql"
      min-conn = 1
      max-conn = 3
      global.table = "global_table" # 相关结构查看db_store.sql文件
      branch.table = "branch_table" # 相关结构查看db_store.sql文件
      lock-table = "lock_table" # 相关结构查看db_store.sql文件
      query-limit = 100
    }
    }
    lock {
    ## the lock store mode: local、remote
    mode = "remote"

    local {
      ## store locks in user's database
    }

    remote {
      ## store locks in the seata's server
    }
    }
    recovery {
    committing-retry-delay = 30
    asyn-committing-retry-delay = 30
    rollbacking-retry-delay = 30
    timeout-retry-delay = 30
    }

    transaction {
    undo.data.validation = true
    undo.log.serialization = "jackson"
    }

    ## metrics settings
    metrics {
    enabled = false
    registry-type = "compact"
    # multi exporters use comma divided
    exporter-list = "prometheus"
    exporter-prometheus-port = 9898
    }

-- /conf/db_store.sql————展示file.conf文件中,日志存放位置为db store时相关表的结构
    -- the table to store GlobalSession data
    drop table if exists `global_table`;
    create table `global_table` (
      `xid` varchar(128)  not null,
      `transaction_id` bigint,
      `status` tinyint not null,
      `application_id` varchar(32),
      `transaction_service_group` varchar(32),
      `transaction_name` varchar(64),
      `timeout` int,
      `begin_time` bigint,
      `application_data` varchar(2000),
      `gmt_create` datetime,
      `gmt_modified` datetime,
      primary key (`xid`),
      key `idx_gmt_modified_status` (`gmt_modified`, `status`),
      key `idx_transaction_id` (`transaction_id`)
    );

    -- the table to store BranchSession data
    drop table if exists `branch_table`;
    create table `branch_table` (
      `branch_id` bigint not null,
      `xid` varchar(128) not null,
      `transaction_id` bigint ,
      `resource_group_id` varchar(32),
      `resource_id` varchar(256) ,
      `lock_key` varchar(128) ,
      `branch_type` varchar(8) ,
      `status` tinyint,
      `client_id` varchar(64),
      `application_data` varchar(2000),
      `gmt_create` datetime,
      `gmt_modified` datetime,
      primary key (`branch_id`),
      key `idx_xid` (`xid`)
    );

    -- the table to store lock data
    drop table if exists `lock_table`;
    create table `lock_table` (
      `row_key` varchar(128) not null,
      `xid` varchar(96),
      `transaction_id` long ,
      `branch_id` long,
      `resource_id` varchar(256) ,
      `table_name` varchar(32) ,
      `pk` varchar(32) ,
      `gmt_create` datetime ,
      `gmt_modified` datetime,
      primary key(`row_key`)
        );

# 启动
--     前提
    1、nacos已经启动

-- 启动
    1、windows————双击运行/bin/seata-server.bat
    2、mac————终端/bin/下运行[./seata-server.sh -p 8091 -h 192.168.xxx.xx -m file]命令
    3、出现异常————seata can not connect to services-server
      1)seata TC注册到nacos的地址不是服务器的地址导致不能链接——————只需要启动时命令增加-h 指定ip地址 
```

## 17、Eclipse安装与配置

```markdown
# 安装
    brew install eclipse-java

# 配置
-- JDK配置
    1、打开Eclipse的偏好设置，我们需要对Eclipse做一下配置
    2、从左侧栏选择java下面的Installed JREs,然后点击Add按钮，我们要为Eclipse配置JDK
    3、选择“Standard VM”后点击“Next”按钮
    4、在Add JRE界面中点击JRE home后面的那个“Directory”按钮，选择安装JDK时的Home文件夹路径
    5、输入JRE的名称(如： JRE1_8),点击“Finish”按钮
    6、勾选这个新增的JRE，点击右下角的Apply按钮，应用该配置

-- 编码配置
    1、在左侧栏General的Workspace下确定编码为UTF-8，点击Apply应用配置(如果你看到默认的编码就是UTF－8，那就可以不管)

-- 没有Server解决办法
    1、查看Eclipse的版本号【Help】->【About Eclipse IDE】
    2、添加server插件【Help】->【Install New Software…】->点击添加【Add…】
    3、填写【Name】和【Location】,【Name】为版本号,本人的Eclipse版本为【2021-12】,【Location】为 http://download.eclipse.org/releases/2021-12,然后点击【Add】
    4、勾选【 Web, XML, Java EE and OSGi Enterprise Development 】,点击【Next >】->【Finish】

-- 集成Tomcat
    1、首先打开eclipse，选择eclipse的偏好设置，选择server--Runtime Environments
    2、然后点击Add,由于我下载的是Tomcat8版本，所以我选择tomcat8，根据自己下载的版本选择，选择后点击next
    3、配置Tomcat Server相关信息(自定义名字、tomcat文件存放路径、jre版本选择)
    3、点击，finish，然后ok保存就好了
```

## 18、Sentinel控制台环境搭建

```markdown
# 下载
-- 方式一————下载指定版本的控制台 jar 包————https://github.com/alibaba/Sentinel/releases
-- 方式二————下载最新版本的源码自行构建 Sentinel 控制台————https://github.com/alibaba/Sentinel/tree/master/sentinel-dashboard,并使用命令将代码打包成一个 fat jar————mvn clean package
-- 方式三————Sentinel1.6.3版本jar包,详见————[附件——sentinel-dashboard-1.6.3.jar]

# 启动————注意：启动 Sentinel 控制台需要 JDK 版本为 1.8 及以上版本
-- 使用如下命令启动控制台:
    java -D server.port=8333 -Dcsp.sentinel.dashboard.server=localhost:8080 -Dproject.name=sentinel-dashboard -jar sentinel-dashboard.jar
-- 说明————其中 -Dserver.port=8080 用于指定 Sentinel 控制台端口为 8080。从 Sentinel 1.6.0 起，Sentinel 控制台引入基本的登录功能，默认用户名和密码都是 sentinel。可以参考 鉴权模块文档 配置用户名和密码
-- 注意————若您的应用为 Spring Boot 或 Spring Cloud 应用，您可以通过 Spring 配置文件来指定配置，详情请参考 Spring Cloud Alibaba Sentinel 文档(https://github.com/alibaba/spring-cloud-alibaba/wiki/Sentinel)

# 访问
-- http://启动Sentinel控制台jar包的IP地址:8333/#/login
-- 默认账户和密码为[sentinel]
```

[附件——sentinel-dashboard-1.6.3.jar](attachments/sentinel/sentinel-dashboard-1.6.3.jar)

## 19、Redis环境搭建

```markdown
# 安装
-- brew本地安装
    brew install redis@3.2

# 配置环境变量
-- 我的安装完成提示信息,如下:
  redis@3.2 is keg-only, which means it was not symlinked into /usr/local,
  because this is an alternate version of another formula.

  If you need to have redis@3.2 first in your PATH, run:
    echo 'export PATH="/usr/local/opt/redis@3.2/bin:$PATH"' >> ~/.zshrc


  To restart redis@3.2 after an upgrade:
    brew services restart redis@3.2
  Or, if you don't want/need a background service you can just run:
    /usr/local/opt/redis@3.2/bin/redis-server /usr/local/etc/redis.conf --daemonize no
-- 根据安装完成后的提示信息,配置环境变量
    echo 'export PATH="/usr/local/opt/redis@3.2/bin:$PATH"' >> ~/.zshrc

# 启动
-- brew本地安装启动
    brew services restart redis@3.2
```

## 20、浏览器工具相关

```markdown
# Microsoft Edge相关
-- JSON-handle————插件
    1、说明
        自动JSON数据格式化插件
    2、安装
        依次点击:...——>扩展——>管理扩展——>获取 Microsoft Edge 扩展——>搜索[JSON-handle]——>点击获取

# Google Chrome相关————前提需要翻墙
-- FeHelper————插件
    1、说明
        集成了包括JSON格式化、二维码生成与解码、信息编解码、代码压缩、美化、页面取色、Markdown与HTML互转、网页滚动截屏、正则表达式、时间转换工具、编码规范检测、页面性能检测、Ajax接口调试、密码生成器、JSON比对工具、网页编码设置、便签笔记等各种功能
    2、安装
        依次点击:...——>更多工具——>扩展程序——>Chrome 网上应用店——>搜索[FeHelper]——>点击获取
    3、离线安装
        打开chrome扩展程序管理页面——>切换到“开发者模式”——>将.crx文件拖拽到扩展程序页——>选择附件详见————[附件——FeHelper.crx]

-- Chrome浏览器VPN插件————SetupVPN
    1、详见————[附件——SetupVPN.zip]
```

[附件——FeHelper.crx](attachments/chrome-plugin/FeHelper.crx)

[附件——SetupVPN.zip](attachments/chrome-plugin/SetupVPN.zip)

## 21、DockerDesktop安装与配置

```markdown
# 安装
    brew install --cask --appdir=/Applications docker

# 查看版本
    docker --version

# 配置镜像加速
-- 配置
    Perferences... ->Docker Engine。在配置列表中填写加速器地址即可。修改完成之后，点击 Apply&Restart 按钮，Docker 就会重启并应用配置的镜像地址了。

-- 镜像地址
    1、网易的镜像地址————"registry-mirrors": ["http://hub-mirror.c.163.com"]
    2、阿里云安装镜像————"registry-mirrors": ["https://fc3ohjfn.mirror.aliyuncs.com"]

-- 查看docker配置信息
    docker info
```

## 22、开发者边车dev-sidecar

```markdown
# 代码仓库
    https://gitee.com/docmirror/dev-sidecar

# 说明
    开发者边车，命名取自service-mesh的service-sidecar，意为为开发者打辅助的边车工具（以下简称ds).通过本地代理的方式将https请求代理到一些国内的加速通道上
```

# 5、Java——虚拟机环境搭建

## 1、VirtualBox虚拟机安装

```markdown
# 官方下载地址————https://www.virtualbox.org/

# 安装
    brew install virtualbox

# 配置
-- 调整内存大小为3G
    设置-->系统-->内存大小

-- 检查CPU中是否支持Intel VT-x,终端执行以下命令,如果看到VMX条目，那么CPU支持Intel VT-x功能，但它仍然可能被禁用:
    sysctl -a | grep machdep.cpu.features

-- 检查CPU是否同时满足VT-x和VT-d,终端执行以下命令,如果为1说明就是同时支持VT-x和VT-d。
    sysctl kern.hv_support
-- windows开启CPU虚拟化步骤如下
    BOSS——>Advanced——>CPU Configuration ——>Intel Virtualization Technology[Enable]

# 可进行备份工作
    备份[系统快照]————>生成/恢复备份

# Vmware提供四种网络连接方式
-- 桥接(Bridged)网络————直接将虚拟网卡桥接到一个物理网卡上面,和inux下一个网卡绑定两个不同地址类似,实际上是将网卡设置为混杂模式从而达到侦听多个IP的能力
    用这种方式虚拟系统的IP可设置成与本机系统在同一网段,虚拟系统相当于网络内的一台独立的机器,与本机共同插在一个Hub上,网络内其他机器可访问虚拟系统,虚拟系统也可访问网络内其他机器,当然与本机系统的双向访问也不成问题.

-- 网络地址转换(NAT)————使用同样一个IP使用端口转换
    这种方式也可以实现本机系统与虚拟系统的双向访问但网络内其他机器不能访问虚拟系统,虚拟系统可通过本机系统用NAT协议访问网络内其他机器.NAT方式的IP地址配置方法(虚拟系统先用DHCP自动获得IP地址,本系统里的Vmware services会为虚拟系统分配一个IP,之后如果想每次启动都用固定IP的话,在虚拟系统里直接设定这个IP即可)

-- 仅主机(Host-Only)网络————便于宿主机连接虚拟机
    顾名思义这种方式只能进行虚拟机和主机之间的网络通信,既网络内其他机器不能访问虚拟系统,虚拟系统也不能访问其他机器

-- Not Use方式————既不使用网络,虚拟系统为一个单机
    一般来说, Bridged方式最方便好用,但如果本机系统是win2000而网线没插(或者根本没有网卡),网络很可能不可用(大部分用PC网卡的机器都如此),此时就只能用NAT方式或host-only
```

## 2、Vagrant

```markdown
# 说明
    Vagrant 是一个基于 Ruby 的工具，用于创建和部署虚拟化开发环境。它使用 Oracle 的开源 VirtualBox 虚拟化系统，使用 Chef 创建自动化虚拟环境.

# 安装
-- 终端执行命令
    brew install vagrant

-- 安装位置,通过以下命令检查安装是否成功
    vagrant

-- 官方地址
    1、官方镜像仓库————https://app.vagrantup.com/boxes/search
    2、下载地址————https://www.vagrantup.com/downloads

# 应急网络配置————可以用来打通两边网络,进行文件导出
-- 参考链接地址————https://blog.csdn.net/weixin_43745072/article/details/111772144
    1、设置第一个网卡为NAT Network,如下图所示
```

​        <img src="image/img01/img1_5_2_1.png" alt="img" style="zoom: 50%;" />

```markdown
    2、在网络配置中，新建一个网卡2为桥接网卡,如下图所示
```

​        <img src="image/img01/img1_5_2_2.png" alt="img" style="zoom:50%;" />

```markdown
# Vagrant与VirtualBox兼容版本
-- windows建议版本组合
    vagrant_2.2.5_x86_64.msi 与 VirtualBox-6.0.10-132072-Win.exe

-- mac建议版本组合
    vagrant: 2.2.19 与 virtualbox: 6.1.32,149290

# 使用vagrant up命令启动报错问题解决
-- 异常一
    1、异常信息————原来的插件是0.30版本有问题，更换低版本插件
    The following SSH command responded with a non-zero exit status.
    Vagrant assumes that this means the command failed!

    umount /mnt

    Stdout from the command:


    Stderr from the command:

    umount: /mnt: not mounted
    2、解决方式
        1)查看插件列表————vagrant plugin list
        2)卸载不兼容的插件————vagrant plugin uninstall vagrant-vbguest
        3)安装兼容的插件版本————vagrant plugin install vagrant-vbguest --plugin-version 0.21
        4)销毁原来的镜像————vagrant destroy -f
        5)启动虚拟机————vagrant up --color
```

## 3、Linux虚拟机安装

​        本项目虚拟环境使用centos7系统.通过vagrant进行centos7的安装,具体安装步骤如下:

```bash
1、通过终端命令进入virtualbox安装路径的指定虚拟机中,执行centos7环境初始化命令:
    vagrant init centos/7
    注:virtualbox默认安装路径为「/usr/local/Caskroom/virtualbox/x x x」
2、通过命令启动初始化的centos7,初始化的centtos7默认密码为vagrent:
    vagrant up
3、通过命令连接虚拟机:
    1)vagrant ssh
    2)注:连接虚拟机出现如下警告,解决方案:
        警告信息:「-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory」
        解决方案:通过「sudo vim /etc/locale.conf」命令给配置中添加如下配置信息:
            LC_ALL=en_US.utf8
            LC_CTYPE=en_US.utf8
            LANG=en_US.utf8
4、切换到root用户:
    su root
5、Virtualbox网络设置
    1)方式一:在网络高级设置的端口转发中设置网络地址转换,具体操作步骤如下:
        指定虚拟机——>设置——>网络——>设置连接方式为「网络地址转换(NAT)」——>高级——>端口转发——>设置端口转发规则
    2)方式二(建议使用):
        修改指定虚拟机的Vagrantfile文件,具体步骤如下:
            打开私有网络配置,修改IP为virtualbox网卡地址,最后一位随便.
        重启命令
            vagrant reload
6、设置为密码登陆(虚拟机内部操作):
    1)通过命令修改sshd_config文件
        vi /etc/ssh/sshd_config
    2)修改PasswordAuthentication为yes
        PasswordAuthentication yes
    3)重启服务
        service sshd restart
7、修改网络设置(虚拟机内部操作——两边能ping通可忽略):
    1)进入网络配置目录
        cd /etc/sysconfig/network-scripts/
    2)修改对应网卡
        vi ifcfg-eth1
    3)添加配置
    #VAGRANT-BEGIN
    # The contents below are automatically generated by Vagrant. Do not modify.
    NM_CONTROLLED=yes
    BOOTPROTO=none
    ONBOOT=yes
    IPADDR=192.168.56.106
    NETMASK=255.255.255.0
      #网关配置
      GATEWAY=192.168.56.1
      #公共DNS
      DNS1=114.114.114.114
      #备用DNS
      DNS2=8.8.8.8
    DEVICE=eth1
    PEERDNS=no
    #VAHRANT-END
    4)重启网卡
        service network restart
8、查看虚拟机内存大小
    free -m
9、虚拟机必要操作及工具安装
    1)修改yum源
        #备份yum源
        mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
        #使用新yum源
        curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
        #生成缓存
        yum makecache
    1)wget————wget是Linux中的一个下载文件的工具，wget是在Linux下开发的开放源代码的软件，后来被移植到包括Windows在内的各个平台上。
        yum install wget
    2)unzip————解压工具
        yum install -y unzip ————[-y:代表默认都yes]
        #解压命令[-d指解压路径 ，不写的话默认当前目录]
        unzip file.zip -d /root
10、修改root账户密码
    1)重启Linux，三秒之内按下【回车键】，接着输入【e】
    2)切换到第二行，输入【e】进入编辑模式，追加【 single】，接着按【b】启动，就进入单用户模式
    3)接下来可以使用【passwd】命令修改root账户密码
```

## 4、Linux中Docker环境搭建

```markdown
# 安装与配置
-- 1、卸载旧的docker
  sudo yum remove docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine

-- 2、如果是Linux6,需要升级内核
    1)yum update
    2)安装ssl————yum -y install curl nss openssl
    3)查看当前内核版本————more /etc/issue————uname -a
    4)导入public key————rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
    5)安装ELRepo到CentOS-6.x中————yum install https://www.elrepo.org/elrepo-release-6.el6.elrepo.noarch.rpm
    6)安装kernel-lt（lt=long-term）/安装kernel-ml（ml=mainline）
        #长期有效————yum --enablerepo=elrepo-kernel install kernel-lt -y
        #主流版本————yum --enablerepo=elrepo-kernel install kernel-ml -y
    7)编辑grub.conf文件，修改Grub引导顺序
        ————vim /etc/grub.conf
        ————按 i 把 default=1修改为 default=0,按esc 键，输入 ：wq保存退出。
    8)重启系统，这时候你的内核就成功升级了。
        #重启————reboot
        #查看内核版本————uname -r

-- 3、安装必要的系统工具
    yum install -y yum-utils device-mapper-persistent-data lvm2

-- 4、添加软件源信息(二者选其一)
    1)阿里云安装镜像————yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    2)本身镜像————yum-config-manager --add-repo   https://download.docker.com/linux/centos/docker-ce.repo
    3)查看docker版本
        yum list docker-ce.x86_64  --showduplicates |sort -r

-- 5、安装docker相关[docker引擎社区版、操作docker的客户端、docker容器]
    1)制作缓存
        # 针对Linux6————yum makecache fast
        # 针对Linux8————yum makecache  
    2)执行安装
    - 最新版本————sudo yum install -y docker-ce docker-ce-cli containerd.io    
        - 指定版本———— sudo yum install -y docker-ce-18.06.3.ce-3.el7 docker-ce-cli-1:18.09.9-3.el7 containerd.io-1.3.9-3.1.el7

-- 6、第四步采用了对应镜像就不用了,配置镜像加速(https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)
    1)创建目录
        sudo mkdir -p /etc/docker
    2)配置镜像加速器地址
        sudo tee /etc/docker/daemon.json <<-'EOF'
        {
          "registry-mirrors": ["https://fc3ohjfn.mirror.aliyuncs.com"]
        }
        EOF
    3)重启docker伴随线程
        sudo systemctl daemon-reload
    4)重启docker服务
        sudo systemctl restart docker

-- 7、测试是否安装成功————docker -v

-- 8、设置docker开机启动
    systemctl enable docker

-- 9、删除————https://blog.csdn.net/qq_18948359/article/details/102715729
    1)切换到 /etc/yum.repos.d 目录下，将所有 docker 相关的 repo全部删掉
    2)sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

## 5、Docker中安装mysql

​        docker中安装步骤如下:

```markdown
# 说明
    MySQL是一个关系型数据库管理系统，由瑞典MySQL AB公司开发，属于Oracle旗下产品。MySQL 是最流行的关系型数据库管理系统之一，在 WEB应用方面，MySQL是最好的 RDBMS(Relational Database Management System，关系数据库管理系统) 应用软件之一。

# 安装与配置
-- 1、镜像仓库搜索mysql,获取下载命令:
    https://hub.docker.com/

-- 2、使用命令下载指定版本的mysql:
    sudo docker pull mysql:5.7

-- 3、查看所有镜像:
    sudo docker images

-- 4、创建实例并启动
  docker run -p 3306:3306 --name mysql \
  -v /Users/pigskin/mydata/mysql/log:/var/log/mysql \
  -v /Users/pigskin/mydata/mysql/data:/var/lib/mysql \
  -v /Users/pigskin/mydata/mysql/conf:/etc/mysql \
  -e MYSQL_ROOT_PASSWORD=root \
  -d mysql:5.7

    参数说明
  -p 3306:3306————将容器的3306端口映射到主机的3306端口
  -v /mydata/mysql/conf:/etc/mysql————将配置文件夹挂在到主机
  -v /mydata/mysql/log:/var/log/mysql————将日志文件夹挂载到主机
  -v /mydata/mysql/data:/var/lib/mysql————将数据文件夹挂载到主机
  -e MYSQL_ROOT_PASSWORD=root————初始化root用户的密码    
  -d ————以后台方式运行指定对应镜像

-- 5、进入容器内部
     docker exec -it 容器名/id /bin/bash

-- 6、查看安装目录(容器内部)
     whereis mysql

-- 7、通过挂载配置文件修改配置文件
    1)创建并编辑mysql配置文件
        vi /mydata/mysql/conf/my.cnf
    2)添加如下配置
        [client]
        default-character-set=utf8

        [mysql]
        default-character-set=utf8

        [mysqld]
        init_connect='SET collation_connection = utf8_unicode_ci'
        init_connect='SET NAMES utf8'
        character-set-server=utf8
        collation-server=utf8_unicode_ci
        skip-character-set-client-handshake
        #必须加,不然连接很慢
        skip-name-resolve

-- 8、重启
    docker restart mysql

-- 9、设置开机自启
    sudo docker update mysql --restart=always
```

## 6、Docker中安装redis

```markdown
# 说明
    Redis（Remote Dictionary Server )，即远程字典服务，是一个开源的使用ANSI C语言编写、支持网络、可基于内存亦可持久化的日志型、Key-Value数据库，并提供多种语言的API。从2010年3月15日起，Redis的开发工作由VMware主持。从2013年5月开始，Redis的开发由Pivotal赞助。

# 安装及配置
-- 1、下载redis镜像
    docker pull redis

-- 2、创建redis挂载配置文件
    1)创建目录
        mkdir -p /mydata/redis/conf
    2)创建配置文件
        touch redis.conf

-- 2、创建并启动redis实例
  docker run -p 6379:6379 --name redis \
  -v /Users/pigskin/mydata/redis/data:/data \
  -v /Users/pigskin/mydata/redis/conf/redis.conf:/etc/redis/redis.conf \
  -d redis redis-server /etc/redis/redis.conf

    参数说明
    -p 6379:6379：将容器的6379端口映射到主机的6379端口
    -v /mydata/redis/data:/data————将数据文件夹挂载到主机
    -v /mydata/redis/conf/redis.conf:/etc/redis/redis.conf————将配置文件挂在到主机对应配置文件
    -d ————以后台方式运行指定对应镜像
    redis-server /etc/redis/redis.conf————指定该服务已指定配置文件启动

-- 3、进入redis客户端
    docker exec -it redis redis-cli

-- 4、持久化(防止重启redis后数据丢失)
    1)修改redis在主机的挂载配置文件
        vi /mydata/redis/conf/redis.conf
    2)添加如下配置信息,启用aof持久化方式
        appendonly yes
    3)重启redis
        docker restart redis
    注:配置文档可配置项参考————https://redis.io/topics/config

-- 5、设置开机自动启动
    sudo docker update redis --restart=always

-- 6、redis可视化客户端
    brew install another-redis-desktop-manager

-- 7、清除redis缓存命令
    flushdb
```

## 7、Docker中安装elasticSearch、kibana、ik分词器及自定义扩展词库

```markdown
# 下载镜像文件
    1)存储和检索数据
        docker pull elasticsearch:7.4.2
    2)可视化检索数据
        docker pull kibana:7.4.2

# 创建elasticSearch实例
    1)创建文件夹
        #用于挂载es的配置文件
        mkdir -p /mydata/elasticsearch/config
        #用于挂载es的数据
        mkdir -p /mydata/elasticsearch/data
        #用于挂载es的插件
        mkdir -p /mydata/elasticsearch/plugins
    2)递归设置指定目录及其子目录可读可写权限
        chmod -R 777 /mydata/elasticsearch/
  3)将配置写入执行文件,使es可以被远程任何机器进行访问
        echo  "http.host: 0.0.0.0">> /mydata/elasticsearch/config/elesticsearch.yml
    4)创建并启动elasticsearch实例
        docker run --name elasticsearch -p 9200:9200 -p 9300:9300 \
        -e "discovery.type=single-node" \
        -e ES_JAVA_OPTS="-Xms64m -Xmx512m" \
        -v /mydata/elasticsearch/config/elesticsearch.yml:/usr/share/elasticsearch/config/elesticsearch.yml \
        -v /mydata/elasticsearch/data:/usr/share/elasticsearch/data \
        -v /mydata/elasticsearch/plugins:/usr/share/elasticsearch/plugins \
        -d elasticsearch:7.4.2

        参数说明
        docker run --name elasticsearch -p 9200:9200 -p 9300:9300————启动容器,命名为elasticsearch,并暴露两个端口(9200:发送http请求的端口)(9300:分布式集群状态下节点之间的通信端口)
        -e "discovery.type=single-node"————指定参数:以单节点启动
        -e ES_JAVA_OPTS="-Xms64m -Xmx512m"————指定初始内存64m,最大占用128m(不指定会将内存全部占用)
        -v /mydata/elasticsearch/config/elesticsearch.yml:/usr/share/elasticsearch/config/elesticsearch.yml————将容器中得到elasticsearch配置与虚拟机中的外部配置文件挂载
        -v /mydata/elasticsearch/data:/usr/share/elasticsearch/data————挂在data目录
        -v /mydata/elasticsearch/plugins:/usr/share/elasticsearch/plugins————挂载插件目录
        -d elasticsearch:7.4.2————后台启动指定镜像
    5)设置开机自启
        sudo docker update elasticsearch --restart=always
    6)访问测试
        http://虚拟机IP:9200/
    7)重新设置es容器大小————停止服务移除镜像实例,重新启动
        停止es服务————sudo docker stop bd4105
        移除旧的————sudo docker rm bd4105

# 创建kibana实例
    1)创建并启动kibana实例
        docker run --name kibana \
        -e ELASTICSEARCH_HOSTS=http://192.168.56.106:9200 \
        -p 5601:5601 \
        -d kibana:7.4.2

        参数说明
        -e ELASTICSEARCH_HOSTS=http://虚拟机IP:9200————修改启动参数,设置es的主机地址
        -p 3306:3306————将容器的3306端口映射到主机的3306端口
        -d kibana:7.4.2————后台启动指定镜像
    2)设置开机自启
        sudo docker update kibana --restart=always
    3)访问路径
        http://虚拟机IP:5601/

# 安装ik分词器(需要和es版本同步)
    1)github地址
        https://github.com/medcl/elasticsearch-analysis-ik
    2)下载指定版本ik分词器,复制要下载的版本链接地址,使用wget命令进行下载/本地下载,详见[附件——elasticsearch-analysis-ik-7.4.2.zip]
        wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.4.2/elasticsearch-analysis-ik-7.4.2.zip
    3)将下载的ik分词器解压到es映射的插件路径中
        unzip elasticsearch-analysis-ik-7.4.2.zip -d /mydata/elasticsearch/plugins/ik
    4)授权ik文件夹任意用户完全权限(可读可写可执行)
        chmod -R 777 ik/
    5)重启es容器
        docker restart elasticsearch
    6)容器内部检查是否安装成功
        #进入容器内部
        docker  exec -it elasticsearch /bin/bash
        #进入指定目录
        cd /usr/share/elasticsearch/bin
        #通过执行可执行命令,列出es所有安装成功的插件
        elasticsearch-plugin list
    7)kibana中测试
        POST _analyze
    {
      "analyzer":"ik_smart",
      "text":"北京人在紫禁城吃着炸酱面,喝着北冰洋"
    }

# 自定义扩展词库——修改ik分词器的配置
    1)进入ik配置目录
        cd /mydata/elasticsearch/plugins/ik/config
    2)修改配置文件IKAnalyzer.cfg.xml
        vi IKAnalyzer.cfg.xml
    3)进行如下配置
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE properties SYSTEM "http://java.sun.com/dtd/properties.dtd">
        <properties>
        <comment>IK Analyzer 扩展配置</comment>
      <!--用户可以在这里配置自己的扩展字典 -->        
      <entry key="ext_dict"></entry>
      <!--用户可以在这里配置自己的扩展停止词字典-->
      <entry key="ext_stopwords"></entry>
      <!--用户可以在这里配置远程扩展字典 -->
      <entry key="remote_ext_dict">http://192.168.56.106/es/fenci.txt</entry>
      <!--用户可以在这里配置远程扩展停止词字典-->
      <!-- <entry key="remote_ext_stopwords">words_location</entry> -->
    </properties>
    4)说明
        1、可以处理remote_ext_dict设置的请求地址,设置自己的词库,合并旧词库使用
        2、使用nginx存放新词库,以上配置就会将新词库和旧词库合并使用
    5)在nginx的html目录下创建es目录并创建词库文件[fenci.txt]文件,浏览器访问测试
        http://虚拟机IP地址/es/fenci.txt
    6)重启ES进行测试
```

[附件——elasticsearch-analysis-ik-7.4.2.zip](/attachments/ik/elasticsearch-analysis-ik-7.4.2.zip)

## 8、Docker中安装nginx

```bash
1、创建nginx目录
    mkdir /mydata/nginx
2、使用docker命令,启动一个nginx实例,复制出其中的配置
    docker run -p 80:80 --name nginx -d nginx:1.10
3、将配置复制到创建的目录
    docker container cp nginx:/etc/nginx .
4、停止并移除掉原始启动的nginx
    docker stop nginx
    docker rm nginx
5、将原始创建的nginx目录进行重命名为conf
    mv nginx conf
6、重新创建一个nginx目录
    mkdir nginx
7、将conf文件移动到创建的目录
    mv conf nginx/
8、创建新的nginx
    docker run -p 80:80 --name nginx \
    -v /mydata/nginx/html:/usr/share/nginx/html \
    -v /mydata/nginx/logs:/var/log/nginx \
    -v /mydata/nginx/conf:/etc/nginx \
    -d nginx:1.10

    参数说明
    -v /mydata/nginx/html:/usr/share/nginx/html————映射静态资源目录到主机指定目录
    -v /mydata/nginx/logs:/var/log/nginx————映射日志目录到主机指定目录
    -v /mydata/nginx/conf:/etc/nginx————映射配置目录到主机指定目录
    -d nginx:1.10————后台启动执行镜像包
9、设置开机自启动
    sudo docker update nginx --restart=always
10、反向代理配置
    参照————https://jingyan.baidu.com/article/19192ad8171600e53f570774.html
11、负载均衡配置
    参照————https://jingyan.baidu.com/article/a3a3f811f11957cca3eb8a3e.html
```

## 9、Docker中安装RabbitMQ

```bash
1、创建并启动kibana实例
    docker run --name rabbitmq \
    -p 5671:5671 \
    -p 5672:5672 \
    -p 4369:4369 \
    -p 25672:25672 \
    -p 15671:15671 \
    -p 15672:15672 \
    -d rabbitmq:management

    开放端口说明
    5671,5672(AMQP端口)
    4369,25672(Erlang发现&集群端口)
    15672(web管理后台端口)
    61613,61614(STOMP协议端口)
    1883,8883(MQTT协议端口)
2、设置开机自启
    docker update rabbitmq --restart=always
3、浏览器访问
    http://虚拟机IP地址:15672         默认账号密码都是[guest]
4、文档地址
    https://www.rabbitmq.com/networking.html
5、镜像信息地址
    https://hub.docker.com/_/rabbitmq?tab=tags
```

## 10、Docker中安装Oracle

```bash
1、安装
    docker pull registry.cn-hangzhou.aliyuncs.com/helowin/oracle_11g
2、启动镜像为容器
    docker run --name oracle_11g \
  -p 9090:8080 \
  -p 1521:1521 \
  -d registry.cn-hangzhou.aliyuncs.com/helowin/oracle_11g
3、进入容器
    docker exec -it 容器id  /bin/bash
4、容器id可以通过一下命令查询
    docker ps -a
5、通过连接工具连接oracle
    初始用户名密码：system/helowin；服务名：helowin
```

## 11、Linux虚拟机中安装Redis

```markdown
# 安装
1、下载安装包
    进入到Xshell控制台(默认当前是root根目录)，输入【wget http://download.redis.io/releases/redis-5.0.7.tar.gz】
2、解压缩文件
    下载完成后需要将压缩文件解压，输入【tar -zvxf redis-5.0.7.tar.gz】解压到当前目录
3、移动redis目录
    一般都会将redis目录放置到/usr/local/redis目录，所以这里输入下面命令将目前在/root目录下的redis-5.0.7文件夹更改目录，同时更改文件夹名称为redis【mv /root/redis-5.0.7 /usr/local/redis】
4、编译
    cd到/usr/local/redis目录，输入命令【make】执行编译命令，接下来控制台会输出各种编译过程中输出的内容
5、安装
    执行命令【make PREFIX=/usr/local/redis/bin install】进行安装
6、redis配置文件路径修改
    通过命令【mv /usr/local/redis/redis.conf /etc】将redis.conf文件移动到【/etc】目录下
7、卸载
    直接【rm -rf /usr/local/redis】即可删除redis

# 启动
1、使用xshell连接上redis所在服务地址
2、找到redis配置文件【redis.conf】---【我在/etc下放着】
3、【服务端启动】进入redis安装位置【cd /usr/local/redis/bin/bin】使用命令同时指定配置文件启动【./redis-server /etc/redis.conf】
4、【客户端启动】使用命令检验是否启动【./redis-cli】，输出Ip地址就成功了
5、使用【keys *】查看有哪些key
6、使用命令【get XX-key名】查看指定key对应的值
7、重启redis【ps aux | grep redis】-查看redis进程、【kill -9 xxxx】-杀掉指定进程
```

## 12、Linux中JDK环境搭建

```markdown
-- 1、下载jdk————http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

-- 2、创建文件夹————mkdir /usr/local/java

-- 3、解压文件————tar -zxvf jdk-8u181-linux-x64.tar.gz -C /usr/local/java/

-- 4、修改环境变量————vim /etc/profile 添加如下内容：
    export JAVA_HOME=/usr/lib/java/jdk1.8.0_261
    export PATH=$JAVA_HOME/bin:$PATH
    export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

-- 5、重启机器或执行命令————source /etc/profile

-- 6、测试是否安装成功————java -version
```

## 13、Linux中MySQL环境搭建【LNMP】

```markdown
# 准备工作
-- 关闭selinux
    0、查看selinux状态————getenforce
    1、临时关闭，即时生效，重启失效————setenforce 0
    2、永久关闭，重启生效，永不失效
        1)修改Selinux配置文件————vim /etc/selinux/config
        2)修改此处为disabled————SELINUX=disabled

-- 关闭防火墙
    1、Linux6
        1)临时关闭，即时生效，重启失效————service iptables stop
        2)永久关闭，重启生效，永不失效————chkconfig iptables off
    2、Linux8
        1)查看运行状态————systemctl status firewalld
        2)禁止开机启动————systemctl disable firewalld
        3)停止运行————systemctl stop firewalld

-- 或不关闭防火墙，只开发部分端口：如80,3306
    1、开放80端口————/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
    2、保存配置————/etc/rc.d/init.d/iptables save
    3、重启防火墙服务————/etc/rc.d/init.d/iptables restart
    4、查看已开放的端口————netstat -anp

-- 问题解决
    1、yum修复————https://blog.csdn.net/weixin_42104211/article/details/112228242
        1)问题————当yum运行出错时【Error: Cannot find a valid baseurl for repo: base】
      2)解决————执行以下命令一键修复yum
      sed -i “s|enabled=1|enabled=0|g” /etc/yum/pluginconf.d/fastestmirror.conf
      mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
      curl -o /etc/yum.repos.d/CentOS-Base.repo https://www.xmpan.com/Centos-6-Vault-Aliyun.repo
      yum clean all
      yum makecache
    2、CentOS 8中执行命令，出现报错：Failed to set locale, defaulting to C.UTF-8
        1)问题原因1
            原因————没有安装相应的语言包。
            解决————安装对应语言包
                -- 查看目前系统已安装的语言包————locale -a
                -- 安装中文语言包————yum install glibc-langpack-zh
                -- 安装英文语言包————dnf install glibc-langpack-en 或 dnf install langpacks-en glibc-all-langpacks -y
        2)问题原因2
            原因————没有设置正确的语言环境
            解决————设置正确的语言环境
        echo "export LC_ALL=en_US.UTF-8" >> /etc/profile
        source /etc/profile
        或
        locale -gen en_US.UTF-8
-- 重启虚拟机————reboot

# 安装
-- 检查是否已安装 mysql————yum list installed | grep mysql

-- 卸载
    1、移除mysql相关内容————yum -y remove xxxx
    2、卸载依赖
        1)rpm -qa | grep -i mysql
        2)yum remove xxx
    3、删除文件夹
        1)find / -name mysql
        2)rm -rf xxx
-- 下载mysql的yum源
    1、安装wget————yum install wget -y
    2、mysql5.6,针对CenstOS 6————wget http://repo.mysql.com/mysql-community-release-e16-5.noarch.rpm
    3、mysql8.0.26,针对CenstOS 6————wget --no-check-certificate https://dev.mysql.com/get/mysql80-community-release-el6-3.noarch.rpm
    4、mysql8.0.21,针对CenstOS 8————wget https://dev.mysql.com/get/mysql80-community-release-el8-1.noarch.rpm

-- 安装源
    rpm -ivh mysql80-community-release-el6-3.noarch.rpm
    或
    rpm -ivh mysql80-community-release-el8-1.noarch.rpm

-- 更新源————yum makecache

-- 查看源可安装mysql————yum list | grep mysql

-- yum安装mysql
    yum install mysql-community-server.x86_64
    或
    yum install mysql-server.x86_64

-- 启动mysql服务————service mysqld start

-- 设置开机自启————chkconfig mysqld on

# 配置
-- 查看初始化后的密码
    1、进入mysql安装目录————cd /var/lib/mysql
    2、查看文件————ll
    3、过滤文件，查看密码————grep 'password' /var/log/mysqld.log

-- 登录mysql————mysql -uroot -p

-- 修改密码
    1、启用可设置简单密码
        1)字段含义
      # validate_password.length————密码长度的最小值(这个值最小要是4)
      # validate_password.number_count————密码中数字的最小个数。    
      # validate_password.mixed_case_count————大小写的最小个数。
      # validate_password.special_char_count————特殊字符的最小个数。
      # validate_password.dictionary_file ————字典文件
    2)设定脚本
      set global validate_password.check_user_name=0;
      set global validate_password.length=0;
      set global validate_password.mixed_case_count=0;
      set global validate_password.number_count=0;
      set global validate_password.policy=0;
      set global validate_password.special_char_count=0;
      show variables like 'validate_password%';
    2、查看密码验证插件信息————show variables like 'validate_password%';
    3、安装密码验证插件————INSTALL COMPONENT 'file://component_validate_password';
    4、密码修改————ALTER USER 'root'@'localhost' IDENTIFIED BY '新密码';

-- 修改mysql默认编码
    1、查看mysql默认编码————SHOW VARIABLES LIKE 'character%';
    2、修改配置文件————vi /etc/my.cnf————添加如下配置
        [client]
        default-character-set=utf8

        [mysqld]
        character-set-server=utf8
    3、重启mysql服务————service mysqld restart

-- mysql开启远程连接
    1、查看已存在的连接————select host, user, authentication_string, plugin from user;
    2、针对mysql5.6
        mysql>GRANT ALL PRIVILEGES ON *.* TO `root`@`%` IDENTIFIED BY `` WITH GRANT OPTION;
        mysql>flush privileges;
        mysql>select host,user from user;
    3、针对mysql8
        mysql>CREATE USER 'root'@'%' IDENTIFIED BY '你的密码'; 
        mysql>GRANT ALL ON *.* TO 'root'@'%'; 
        mysql>ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '你的密码';
        mysql>FLUSH PRIVILEGES;

-- 修改默认端口
    1、查看当前端口————show global variables like 'port';
    2、修改配置文件————vi /etc/my.cnf————# 添加/修改，如下配置
        [client]
        port=3308

        [mysqld]
        port=3308
    3、 重启服务————service mysqld restart

# Windows安装mysql
    https://blog.csdn.net/weixin_42109012/article/details/94443391
```

## 14、Linux中Canal环境搭建

```markdown
# 前提条件
-- 搭建好JDK环境————详见1-5-12、Linux中JDK环境搭建
-- 搭建好Mysql环境————详见1-5-13、Linux中MySQL环境搭建【LNMP】

# 准本工作
-- 开启mysql服务————service mysqld start

-- 开启binlog写入功能
    1、canal基于mysql binlog技术。所以需要开启mysql的binlog写入功能
    2、检查binlog功能是否开启————show variables like 'log_bin'————OFF(未开启)/ON(已开启)
    3、开启binlog
        1)修改mysql配置文件my.cnf————vi /etc/my.cnf
        2)追加内容
            #binlog文件名
            log-bin=mysql-bin
            #选择row模式
            binlog_format=ROW
            #mysql实例id,不能和canal的slaveId重复
            server_id=1
        3)重启mysql————service mysqld restart

-- mysql中添加以下的相关用户和权限
    create user `canal`@`%` identified by 'xxx';
    grant show view,select,replication slave,replication client on *.* to 'canal'@'%';
    flush privileges;

-- 下载安装Canal服务
    1、下载地址————https://github.com/alibaba/canal/releases
    2、将canal压缩文件上传到linux系统中————https://blog.csdn.net/shenjianxz/article/details/56686449
        linux中安装lrzsz————yum  install lrzsz————接下来就可以将文件拖拽进当前文件夹
    3、解压缩————tar zxvf 压缩文件名
    4、修改canal配置文件
        1)进入配置文件目录————cd /usr/local/canal/conf/example
        2)打开配置文件————vi instance.properties
        3)修改配置
            # 改成自己的数据库信息（当前linux中的数据库地址）
            canal.instance.master.address=127.0.0.1:3306
            # 改成自己的数据库用户名和密码（当前linux中的数据库）
            canal.instance.dbUsername=canalcanal.instance.dbPassword=canal
            # 改成同步的数据库表规则，例如只是同步一下表
            ## 所有表
            canal.instance.filter.regex=.*\\..*
            ##指定表
            canal.instance.filter.regex=指定库.指定表
        4)配置说明————mysql数据解析关注的表，Perl正则表达式（多个正则之间以【,】分割，转义符需要双斜杠【\\】）
            -- 常见示例
                # 所有表————【.*】【.*\\..*】
                # canal schema下所有表————【canal\\..*】
                # canal下的以canal打头的表————【canal\\.canal.*】
                # canal下的具体某张表————【canal.test1】
                # 多个规则组合使用(逗号分割)————【canal\\..*,mysql.test1,mysql.test2】
            -- 注意————此过滤条件只针对row模式的数据有效（ps:mixed/statement因为不解析sql,所以无法准确提取tableName进行过滤）

-- 启动Canal
    1、进入目录————cd /usr/local/canal/bin
    2、启动————./startup.sh
    3、查看是否已启动————ps -ef | grep canal
```

## 15、Linux中Maven环境搭建

```markdown
-- 上传或下载安装介质
    下载地址————https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/
-- 存放安装介质apache-maven-3.6.1-bin.tar.gz到指定目录————cd /usr/local
-- 解压安装包————tar -zxvf  apache-maven-3.6.1-bin.tar.gz
-- 建立软连接————ln -s /usr/local/apache-maven-3.6.1/ /usr/local/maven
-- 修改环境变量
    1、打开环境变量配置文件
        vim /etc/profile
    2、追加如下配置
        export MAVEM_HOME=/usr/local/maven
        export PATH=$PATH:$MAVEM_HOME/bin
    3、应用配置
        source /etc/profile
-- 测试是否成功————mvn -v
```

## 16、Linux中Git环境搭建

```markdown
-- 执行安装命令————yum -y install git
-- 测试是否成功————git --version
```

## 17、Linux中Jenkins搭建

```markdown
-- 上传或下载安装介质
    下载地址————http://updates.jenkins-ci.org/download/war/
-- 存放安装介质jenkins.war到指定目录————cd /usr/local
-- 启动
    1、#前缀nohup,代表后台静默启动 启动war包命令>日志输出文件路径 后缀
        nohup java -jar /usr/local/jenkins/jenkins.war >/usr/local/jenkins/jenkins.out &
    2、提示[nohup: ignoring input and redirecting stderr to stdout]继续按下回车键
    3、查看进程
        ps -ef | grep jenkins
-- 重装
    1、只需要删除安装jenkins用户的主目录（~）下的（.jenkins）文件夹，一般在/root/.jenkins
    2、可以用 ls -a 查看隐藏的文件。然后 rm -rf .jenkins就可以删除了
-- 访问
    1、访问地址————http://安装主机ip:8080
    2、默认账户————admin
    3、默认密码————详见————安装配置——解锁jenkins
-- 安装配置
    1、解锁jenkins
        1)获取管理员密码————默认初始密码文件所在路径————/root/.jenkins/secrets/initialAdminPassword
        2)复制以上目录,并执行以下命令,获取默认密码————cat /root/.jenkins/secrets/initialAdminPassword
    2、配置国内镜像
        1)关闭浏览器,配置镜像
        2)cd {jenkins工作目录,从解锁密码处可看到}/updates,并执行以下命令
            sed -i 's/http:\/\/updates.jenkins-ci.org\/download/https:\/\/mirrors.tuna.tsinghua.edu.cn\/jenkins/g' default.json && sed -i 's/http:\/\/www.google.com/https:\/\/www.baidu.com/g' default.json
    3、重启jenkins,运行管理界面,安装插件
        1)选择[安装推荐的插件]
        2)创建管理员用户名和密码
    4、实例配置,采用默认,可以知道Jenkins URL————http://当前虚拟机ip:8080
-- 忘记密码解决
    1、/root/.jenkins/
    2、vi config.xml
    3、修改标签内容为————<useSecurity>false</useSecurity>
    4、重启服务
    5、重启开启安全管理
    6、重新设置密码
-- 使用配置
    1、使用[which 软件名]查找
    2、配置自动化部署所需环境
        1)依次进入Manage Jenkins>Global Tool Configuration
        2)配置jdk,如下图所示:
```

<img src="image/img01/img1_5_18_1.png" style="zoom:50%;" />

```markdown
        3)配置maven,如下图所示:
```

<img src="image/img01/img1_5_18_2.png" style="zoom:50%;" />

```markdown
        4)配置git,如下图所示:
```

<img src="image/img01/img1_5_18_3.png" style="zoom:50%;" />

​        

## 18、Docker中安装Zipkin

```markdown
# 说明
    通过 Sleuth产生的调用链监控信息,可以得知微服务之间的调用链路,但监控信息只输出到控制台不方便查看。我们需要一个图开化的工具Zipkin。Zipkin是Twitter开源的分布式踪系统,主要用来收集系统的时序数据,从而追踪系统的调用问题。

# 安装
-- 0、插件镜像包地址
    https://hub.docker.com/r/openzipkin/zipkin/tags

-- 1、Docker安装Zipkin服务器
    docker run --name zipkin -d -p 9411:9411 openzipkin/zipkin:2.20.2

-- 2、设置开机自启
    docker update rabbitmq --restart=always

-- 3、访问
    http://虚拟机IP地址:15672

-- 4、不使用[Try Lens UI]方式
    1)FN+F12进入开发者模式
    2)删除名为lens的Cookie信息

# 基于Elasticsearch,数据持久化
-- 1、启动改版的Zipkin并指定ES主机地址
    docker run --env STORAGE_TYPE=elasticsearch --env ES_HOSTS=es所在IP:es占用端口 openzipkin/zipkin-dependencies

-- 2、使用ES时Zipkin-dependencies支持的环境变量
```

<img src="image/img01/img1_5_19_1_1.png" style="zoom:50%;" />

## 19、Docker中Oracle环境搭建

```markdown
# 拉取镜像
    docker pull registry.cn-hangzhou.aliyuncs.com/helowin/oracle_11g

# 运行oracle容器
    docker run -dp 9090:8080 --name oracle_11g -p 1521:1521 registry.cn-hangzhou.aliyuncs.com/helowin/oracle_11g

# 进入容器
-- 查看容器ID
    docker ps

-- 进入容器内部
    docker exec -it 容器id /bin/bash

# 使用可视化工具连接
-- 默认值
    服务名：helowin
    用户名：system
    密码：helowin
```

## 20、Docker中Tomcat环境搭建

```markdown
# 拉取镜像
    docker pull tomcat:8.5

# 启动镜像
    docker run -d --name tomcat8.5 -p 8080:8080 tomcat:8.5

# 配置
-- 由于 docker 的 tomcat8.5 的镜像的 webapp 目录中没有文件，可以采取以下方式纠正
    1、第一——————换版本;
    2、第二————将存放在 webapps.dist 文件夹中的内容复制出来，下面我们通过复制文件出来的方式解决这个问题:
        1)进入 tomcat 容器中,并进入tomcat目录
            docker exec -it 容器id /bin/bash
            cd /usr/local/tomcat
        2)tomcat 目录下执行如下命令
            mv webapps webapps2
            mv webapps.dist webapps

# 浏览器访问
    Ip:8080
```

​                                                                            
