# 0、Java技术大纲

## 1、JavaSE基础

### 1、Java开发前奏

#### 1、计算机基本原理

##### 1、硬件系统

###### 1、主机

`中央处理器CPU（central processing unit）`

    ——运行原理：控制单元在时序脉冲的作用下，将指令计数器里所指向的指令地址(这个地址是在内存里的)送到地址总线上去，然后CPU将这个地址里的指令读到指令寄存器进行译码。对于执行指令过程中所需要用到的数据，会将数据地址也送到地址总线，然后CPU把数据读到CPU的内部存储单元(就是内部寄存器)暂存起来，最后命令运算单元对数据进行处理加工。周而复始，一直这样执行下去，天荒地老，海枯枝烂，直到停电。

    ——控制器：控制单元是整个CPU的指挥控制中心，由指令寄存器IR(Instruction Register)、指令译码器ID(Instruction Decoder)和操作控制器OC(Operation Controller)等，对协调整个电脑有序工作极为重要。它根据用户预先编好的程序，依次从存储器中取出各条指令，放在指令寄存器IR中，通过指令译码(分析)确定应该进行什么操作，然后通过操作控制器OC，按确定的时序，向相应的部件发出微操作控制信号。操作控制器OC中主要包括节拍脉冲发生器、控制矩阵、时钟脉冲发生器、复位电路和启停电路等控制逻辑。

    ——运算器：可以执行算术运算(包括加减乘数等基本运算及其附加运算)和逻辑运算(包括移位、逻辑测试或两个值比较)。相对控制单元而言，运算器接受控制单元的命令而进行动作，即运算单元所进行的全部操作都是由控制单元发出的控制信号来指挥的，所以它是执行部件。

`内存`

    ——ROM（Read-Only Memory）：只读存储器。以非破坏性读出方式工作，只能读出无法写入信息。信息一旦写入后就固定下来，即使切断电源，信息也不会丢失，所以又称为固定存储器。ROM所存数据通常是装入整机前写入的，整机工作过程中只能读出，不像随机存储器能快速方便地改写存储内容。ROM所存数据稳定 ，断电后所存数据也不会改变，并且结构较简单，使用方便，因而常用于存储各种固定程序和数据。

    ——RAM（Random Access Memory）：读写存储器。随机存取存储器。也叫主存，是与CPU直接交换数据的内部存储器。它可以随时读写（刷新时除外），而且速度很快，通常作为操作系统或其他正在运行中的程序的临时数据存储介质。RAM工作时可以随时从任何一个指定的地址写入（存入）或读出（取出）信息。它与ROM的最大区别是数据的易失性，即一旦断电所存储的数据将随之丢失。RAM在计算机和数字系统中用来暂时存储程序、数据和中间结果。

    ——Cache：高速缓冲存储器。电脑中为高速缓冲存储器，是位于CPU和主存储器DRAM（Dynamic Random Access Memory）之间，规模较小，但速度很高的存储器，通常由SRAM（Static Random Access Memory 静态存储器）组成。它是位于CPU与内存间的一种容量较小但速度很高的存储器。CPU的速度远高于内存，当CPU直接从内存中存取数据时要等待一定时间周期，而Cache则可以保存CPU刚用过或循环使用的一部分数据，如果CPU需要再次使用该部分数据时可从Cache中直接调用，这样就避免了重复存取数据，减少了CPU的等待时间，因而提高了系统的效率。Cache又分为L1Cache（一级缓存）和L2Cache（二级缓存），L1Cache主要是集成在CPU内部，而L2Cache集成在主板上或是CPU上。

###### 2、外设

`输入设备（InputDevice）`

        向计算机输入数据和信息的设备。是计算机与用户或其他设备通信的桥梁。输入设备是用户和计算机系统之间进行信息交换的主要装置之一。是人或外部与计算机进行交互的一种装置，用于把原始数据和处理这些数的程序输入到计算机中。计算机能够接收各种各样的数据，既可以是数值型的数据，也可以是各种非数值型的数据，如图形、图像、声音等都可以通过不同类型的输入设备输入到计算机中，进行存储、处理和输出。

        主要包含——键盘、鼠标、扫描仪、摄像头、光笔、手写输入板、游戏杆、语音输入装置等。

`输出设备（Output Device）`

        是计算机硬件系统的终端设备，用于接收计算机数据的输出显示、打印、声音、控制外围设备操作等。也是把各种计算结果数据或信息以数字、字符、图像、声音等形式表现出来。

        主要包含——显示器、打印机、绘图仪、影像输出系统、语音输出系统、磁记录设备等。

`外存`

        指除计算机内存及CPU缓存以外的储存器，此类储存器一般断电后仍然能保存数据。

        主要包含——硬盘、光盘、软盘、闪存、U盘等。

##### 2、软件系统

###### 1、系统软件

`操作系统（operation system，简称OS）`

        是管理计算机硬件与软件资源的计算机程序。操作系统需要处理如管理与配置内存、决定系统资源供需的优先次序、控制输入设备与输出设备、操作网络与管理文件系统等基本事务。操作系统也提供一个让用户与系统交互的操作界面

        主要包含——Windows、macOS、Linux、iOS、Android等。

`编译程序和解释程序`

`数据库管理`

###### 2、应用软件

 `各种子处理系统、各种软件包`

#### 2、Java语言开发环境的搭建

`1、JDK下载`——针对不同操作系统开发了各个版本的JDK，在下载时根据自己电脑操作系统和系统位数选择合适的JDK。([Java Downloads | Oracle](https://www.oracle.com/java/technologies/downloads/))

`2、JDK安装`——基本都是点击下一步，选择默认位置安装。

`3、配置环境变量`

    ——新建JAVA_HOME环境变量，值为安装JDK时所在地址

    ——修改环境变量Path，设置值其为Path=%JAVA_HOME%\bin;<现有的其他路径>

`4、开发环境搭建测试`——测试JDK是否配置成功【命令行窗口执行java命令】出现如图结果证明配置成功

#### 3、相关反编译工具介绍

`JD-GUI`——属于Java Decompiler项目（JD项目）下个的图形化运行方式的反编译器。不需要安装，直接点击运行，可以反编译jar，class文件。

`JD-Eclipse`——属于Java Decompiler项目（JD项目）下个Eclipse插件化运行方式的反编译插件。

`JD-IntelliJ`——属于Java Decompiler项目（JD项目）下个Intellij插件化的运行方式的反编译插件。

#### 4、Java开发工具

`Eclipse的安装和使用`——[eclipse安装教程（win10)](https://blog.csdn.net/sinat_40766770/article/details/90575233)

`IDEA的安装和使用`——[IntelliJ IDEA 下载安装配置教程（完整版）](https://blog.csdn.net/weixin_44505194/article/details/104452880)

#### 5、javadoc

`说明`

    avadoc是Sun公司提供的一个技术，它从程序源代码中抽取类、方法、成员等注释形成一个和源代码配套的API帮助文档。也就是说，只要在编写程序时以一套特定的标签作注释，在程序编写完成后，通过Javadoc就可以同时形成程序的开发文档了。

`常用标记`

——@author 作者 

        作者标识。可应用于包、 类、接口

——@version 版本号 

        版本号。可应用于包、 类、接口

——@param 参数名 描述 

        方法的入参名及描述信息，如入参有特别要求，可在此注释。可应用于构造函数、 方法

——@return 描述 

        对函数返回值的注释。可应用于方法

——@deprecated 过期文本 

        标识随着程序版本的提升，当前API已经过期，仅为了保证兼容性依然存在，以此告之开发者不应再用这个API。可应用于包、类、接口、值域、构造函数、 方法

——@throws 异常类名 

        构造函数或方法所会抛出的异常。可应用于构造函数、 方法

——@exception 异常类名 

        同@throws。可应用于构造函数、 方法

——@see 引用 

        查看相关内容，如类、方法、变量等。可应用于包、类、接口、值域、构造函数、 方法

——@since 描述文本 

        API在什么程序的什么版本后开发支持。可应用于包、类、接口、值域、构造函数、 方法

——{@link包.类#成员 标签} 

        链接到某个特定的成员对应的文档中。可应用于 包、类、接口、值域、构造函数、 方法

——{@value} 

        当对常量进行注释时，如果想将其值包含在文档中，则通过该标签来引用常量的值。可应用于(JDK1.4) 静态值域

`命令格式：javadoc [选项] [软件包名称] [源文件]`

——命令格式对应选项,如下:

    -overview <文件> 读取 HTML 文件的概述文档

    -public 仅显示公共类和成员

    -protected 显示受保护/公共类和成员（默认）

    -package 显示软件包/受保护/公共类和成员

    -private 显示所有类和成员

    -help 显示命令行选项并退出

    -doclet <类> 通过替代 doclet 生成输出

    -docletpath <路径> 指定查找 doclet 类文件的位置

    -sourcepath <路径列表> 指定查找源文件的位置

    -classpath <路径列表> 指定查找用户类文件的位置

    -exclude <软件包列表> 指定要排除的软件包的列表

    -subpackages <子软件包列表> 指定要递归装入的子软件包

    -breakiterator 使用 BreakIterator 计算第 1 句

    -bootclasspath <路径列表> 覆盖引导类加载器所装入的类文件的位置

    -source <版本> 提供与指定版本的源兼容性

    -extdirs <目录列表> 覆盖安装的扩展目录的位置

    -verbose 输出有关 Javadoc 正在执行的操作的消息

    -locale <名称> 要使用的语言环境，例如 en_US 或 en_US_WIN

    -encoding <名称> 源文件编码名称

    -quiet 不显示状态消息

    -J<标志> 直接将 <标志> 传递给运行时系统

### 2、Java基础语法

`掌握`——命名规则、关键字、基本数据类型、进制转换等。

### 3、面向对象编程

`理解`——对象的本质，以及面向对象，类与对象之间的关系，如何用面向对象的思想分析和解决显示生活中的问题，并java程序的手段编写出来。

`如何设计类`——设计类的基本原则，类的实例化过程，类元素：构造函数、this关键字、方法和方法的参数传递过程、static关键字、内部类，Java的垃圾对象回收机制。

         static关键字

                静态字段属于所有实例“共享”的字段，实际上是属于class的字段；

                调用静态方法不需要实例，无法访问this，但可以访问静态字段和其他静态方法；

                静态方法常用于工具类和辅助方法。

`对象的三大特性`——封装、继承和多态。子类对象的实例化过程、方法的重写和重载、final关键字、抽象类、接口、继承的优点和缺点。

        多态——针对某类型的方法调用，其真正执行的方法取决于运行时期实际类型的方法

       继承——面向对象编程的一种强大的代码复用方式

        final——如果一个类或方法或字段不想被其它类继承或方法覆写或重新赋值，那么可以添加final修饰

        面向抽象的编程——尽量引用高层类型，避免引用实际子类型的方式

        接口—— Java的接口（interface）定义了纯抽象规范，一个类可以实现多个接口

                接口也是数据类型，适用于向上转型和向下转型

                接口的所有方法都是抽象方法，接口不能定义实例字段

                接口可以定义default方法（JDK>=1.8）

### 4、多线程应用

 `理解`——多线程的概念，如何在程序中创建多线程(Thread、Runnable)，线程安全问题，线程的同步，线程之间的通讯、死锁问题的剖析。

### 5、javaAPI详解

`理解`——JavaAPI介绍、String和StringBuffer、各种基本数据类型包装类，System和Runtime类，Date和DateFomat类等。

`常用的集合类使用`——如下：Java Collections Framework：Collection、Set、List、ArrayList、Vector、LinkedList、Hashset、TreeSet、Map、HashMap、TreeMap、Iterator、Enumeration等常用集合类API。

### 6、IO技术

`理解`——什么是IO，File及相关类，字节流InputStream和OutputStream，字符流Reader和Writer，以及相应缓冲流和管道流，字节和字符的转化流，包装流，以及常用包装类使用，分析java的IO性能。

### 7、网络编程

`理解`——Java网络编程，网络通信底层协议TCP/UDP/IP，Socket编程。网络通信常用应用层协议简介：HTTP、FTP等，以及WEB服务器的工作原理。

### 8、java高级特性

`掌握`——递归程序，Java的高级特性：反射、代理和泛型、枚举、Java正则表达式API详解及其应用。

## 2、数据库技术

`Oracle基础管理`——Oracle背景简介，数据库的安装，数据库的用户名和密码，客户端登录数据库服务SQLPLUS，数据库基本概。

`SQL语句`——数据库的创建，表的创建，修改，删除，查询，索引的创建，主从表的建立，数据控制授权和回收，事务控制，查询语句以及运算符的详解，sql中的函数使用。

`多表连接和子查询`——等值和非等值连接，外连接，自连接；交叉连接，自然连接，using子句连接，完全外连接和左右外连接，子查询使用以及注意事项。

`触发器、存储过程`——触发器和存储过程使用场合， 通过实例进行详解。

`数据库设计优化`——WHERE子句中的连接顺序，选择最有效率的表名顺序，SELECT子句中避免使用 ‘ * ‘ 计算记录条数等。

`数据备份与移植`——移植技巧，备份方案；导入导出等。

## 3、JDBC技术

`JDBC基础`——JDBC Connection、Statement、PreparedStatement、CallableStatement、ResultSet等不同类的使用。

`连接池技术`——了解连接池的概念，掌握连接池的建立、治理、关闭和配置。

`ORM与DAO封装`——对象关系映射思想，jdbc的dao封装，实现自己的jdbc。

## 4、Web基础技术

`Xml技术`——使用jdom和dom4j来对xml文档的解析和生成操作，xml 的作用和使用场合。

`html/css`——Java掌握基本的html标签的格式和使用，css层叠样式表对div的定义，实现对网站布局的基本实现。

`Javascript`

——了解javascript的基本语法以及相关函数的使用，并结合html页面实现流程控制和页面效果展示。

——什么是异常 异常的捕捉和抛出 异常捕捉的原则 finally的使用，package的应用 import关键字。

`jsp/servlet`——Servlet和SP 技术、上传下载、 Tomcat 服务器技术、servlet 过滤器和监听器。

`jstl和EL`——JSTL核心标签库、函数标签库、格式化标签库、自定义标签技术、EL表达式在jsp页面的使用。

`ajax及框架技术`——了解和属性原生态的ajax的使用，ajax使用的场合，使用ajax的好处，ajax框架jquery渲染页面效果和相关的强大的第三方类库，dwr如何和后台服务进行数据传输，以及页面逻辑控制等。

`JSON高级应用`——Java使用json支持的方式对字符串进行封装和解析，实现页面和java后台服务的数据通信。

`Fckeditor编辑器`——FCKEditor在线编辑器技术、配置、处理图片和文件上传。

`javaMail技术`——了解域名解析与MX记录、电子邮件工作原理、邮件传输协议：SMTP、POP3、IMAP、邮件组织结构：RFC822邮件格式、MIME协议、邮件编码、复合邮件结构分析、JavaMail API及其体系结构、编程创建邮件内容：简单邮件内容、包含内嵌图片的复杂邮件、包含内嵌图片和附件的复杂邮件。

`JfreeChart报表`——统计报表；图表处理。

`BBS项目实战`——采用Jquery+dwr+jsp+servlet+Fckeditor+JfreeChart+tomcat+jdbc(oracle) 完成BBS项目的实战。

## 5、Web主流框架技术

`struts2.x`——struts2框架的工作原理和架构分析，struts-default.xml与default.properties文件的作用，struts。Xml中引入多个配置文件。OGNL表达式、Struts2 UI和非UI标签、输入校验、使用通配符定义action、动态方法调用、多文件上传、自定义类型转换器、为Action的属性注入值、自定义拦截器、异常处理、使用struts2实现的CRUD操作的案例。

`hibernate3.x`——Hibernate应用开发基础； ORM基础理论； 关系映射技术； 性能调优技术； 性能优化 一级缓存 二级缓存 查询缓存 事务与并发 悲观锁、乐观锁。

`spring3.x`——Spring IoC技术； Spring AOP技术； Spring 声明事务管理； Spring 常用功能说明，spring3.0的新特性， Spring整合struts2和hibernate3的运用。

`Log4j和Junit`——Logging API； JUnit单元测试技术； 压力测试技术：badboy 进行测试计划跟踪获取以及JMeter压力测试。

`在线支付技术`——完成支付宝的支付接口的在线支付功能。

`电子商务网实战`——采用spring3+hibernate3+struts2+jquery+dwr+FckEditor+tomcat 完成电子商务网站实战开发。

## 6、Web高级进阶

`openJpa技术`——JPA介绍及开发环境搭建、单表实体映射、一对多/多对一、一对一、多对多关联、实体继承、复合主键、JPQL语句、EntityManager API、事务管理，了解一下jpa2.0的新特性以及应用。

`lucene搜索引擎`——了解全文搜索原理、全文搜索引擎、什么是OSEM、OSEM框架Compass、基于使用Lucene使用Compass实现全文增量型索引创建和搜索、探索Lucene 3.0以及API。

`电子商务网重构`——此项目采用了Lucene+compass+openJpa+上一版电子商务网站的技术进行重构。

`Excel/PDF文档处理技术`——java对excel和pdf文档分别利用poi和itext来进行解析和生成。此技术在企业级系统的报表中经常使用。

`OA工作流技术JBPM`——工作流是什么、JBPM介绍、JBPM的主要用法、各类节点的用法、任务各种分派方式、JBPM的整体架构原理、工作流定义模型分析、运行期工作流实例模型分析、数据库表模型分析、流程定义管理、流程实例监控、对JBPM的相关接口进行封装，构建自己的工作流应用平台等。

`WebService技术`——WebService技术原理、WebService技术的应用、Soap服务的创建与管理、WSDL描述文档规范、UDDI 注册中心运行原理;使用Axis和Xfire创建WEB服务、Webservice客户端的编写、使用TCPMonitor监听SOAP协议、异构平台的整合。

`Linux技术`——Linux 系统安装，卸载、linux 使用的核心思想、linux下的用户管理，文件管理,系统管理、程序的安装，使用，卸载。linux下作为server的基本应用：web服务器，j2ee服务器，ftp服务器的安装和项目的部署。

`CRM项目实战`——此项目能了解和熟悉客户关系管理的基本流程以及功能的实现，采用上面几个阶段学到的主流框架实现，同时加入了JBPM的技术。

## 7、大型高并发网站优化方案

`如何构建一个高性能网站详解`——什么样的网站需要高性能，高性能的指标体系，构建高性能网站需要做哪些工作，注意哪些细节。

`SSI技术`——什么是SSI，使用他有什么好处，什么样的系统才使用SSI，SSI技术详解和使用，应用到项目中。

`生成静态页技术`——什么是静态页，为什么需要静态页以及带来的好处，生成静态页的模版技术Velocity和Freemark，生成静态页的访问规则等。

`缓存技术`——为什么使用缓存技术，oscache缓存技术的介绍和使用，memcached缓存技术的介绍和使用、两者缓存技术的比较和如何去使用。

`经典web服务器`——什么是web服务器，什么是javaweb服务器，他们存在什么关系，当前技术主流中常用的web服务器有哪些， web服务器apache和nginx的应用。

`nginx架构实战`——什么是反向代理，负载均衡以及集群，在nginx中如何实现这些高性能的系统架构。

## 8、第三方技术

### 1、EasyPOI

`简介`

        用惯了SpringBoot的朋友估计会想到，有没有什么办法可以直接定义好需要导出的数据对象，然后添加几个注解，直接自动实现Excel导入导出功能？EasyPoi正是这么一款工具，如果你不太熟悉POI，想简单地实现Excel操作，用它就对了！

        EasyPoi的目标不是替代POI，而是让一个不懂导入导出的人也能快速使用POI完成Excel的各种操作，而不是看很多API才可以完成这样的工作。

`参考资料`

——项目官网：https://gitee.com/lemur/easypoi

——项目源码：https://github.com/macrozheng/mall-learning/tree/master/mall-tiny-easypoi

`SpringBoot集成`——在SpringBoot中集成EasyPoi非常简单，只需添加如下一个依赖即可，真正的开箱即用

```java
<dependency>    
    <groupId>cn.afterturn</groupId>  
    <artifactId>easypoi-spring-boot-starter</artifactId>  
    <version>4.4.0</version>
</dependency>
```

`使用`

——简单导出

        1、首先创建一个会员对象Member，封装会员信息；

```java
/**
 * 购物会员
 * Created by macro on 2021/10/12.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Member {
    @Excel(name = "ID", width = 10)
    private Long id;
    @Excel(name = "用户名", width = 20, needMerge = true)
    private String username;
    private String password;
    @Excel(name = "昵称", width = 20, needMerge = true)
    private String nickname;
    @Excel(name = "出生日期", width = 20, format = "yyyy-MM-dd")
    private Date birthday;
    @Excel(name = "手机号", width = 20, needMerge = true, desensitizationRule = "3_4")
    private String phone;
    private String icon;
    @Excel(name = "性别", width = 10, replace = {"男_0", "女_1"})
    private Integer gender;
}
```

        2、在此我们就可以看到EasyPoi的核心注解@Excel，通过在对象上添加@Excel注解，可以将对象信息直接导出到Excel中去，下面对注解中的属性做个介绍；

```java
name：Excel中的列名；
width：指定列的宽度；
needMerge：是否需要纵向合并单元格；
format：当属性为时间类型时，设置时间的导出导出格式；
desensitizationRule：数据脱敏处理，3_4表示只显示字符串的前3位和后4位，其他为*号；
replace：对属性进行替换；
suffix：对数据添加后缀。
```

        3、接下来我们在Controller中添加一个接口，用于导出会员列表到Excel，具体代码如下；

```java
**
 * EasyPoi导入导出测试Controller
 * Created by macro on 2021/10/12.
 */
@Controller
@Api(tags = "EasyPoiController", description = "EasyPoi导入导出测试")
@RequestMapping("/easyPoi")
public class EasyPoiController {

    @ApiOperation(value = "导出会员列表Excel")
    @RequestMapping(value = "/exportMemberList", method = RequestMethod.GET)
    public void exportMemberList(ModelMap map,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {
//LocalJsonUtil工具类，可以直接从resources目录下获取JSON数据并转化为对象，例如此处使用的members.json；
        List<Member> memberList = LocalJsonUtil.getListFromJson("json/members.json", Member.class);
        ExportParams params = new ExportParams("会员列表", "会员列表", ExcelType.XSSF);
        map.put(NormalExcelConstants.DATA_LIST, memberList);
        map.put(NormalExcelConstants.CLASS, Member.class);
        map.put(NormalExcelConstants.PARAMS, params);
        map.put(NormalExcelConstants.FILE_NAME, "memberList");
        PoiBaseView.render(map, request, response, NormalExcelConstants.EASYPOI_EXCEL_VIEW);
    }
}
```

——简单导入

        1、在Controller中添加会员信息导入的接口，这里需要注意的是使用@RequestPart注解修饰文件上传参数，否则在Swagger中就没法显示上传按钮了

```java
/**
 * EasyPoi导入导出测试Controller
 * Created by macro on 2021/10/12.
 */
@Controller
@Api(tags = "EasyPoiController", description = "EasyPoi导入导出测试")
@RequestMapping("/easyPoi")
public class EasyPoiController {

    @ApiOperation("从Excel导入会员列表")
    @RequestMapping(value = "/importMemberList", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult importMemberList(@RequestPart("file") MultipartFile file) {
        ImportParams params = new ImportParams();
        params.setTitleRows(1);
        params.setHeadRows(1);
        try {
            List<Member> list = ExcelImportUtil.importExcel(
                    file.getInputStream(),
                    Member.class, params);
            return CommonResult.success(list);
        } catch (Exception e) {
            e.printStackTrace();
            return CommonResult.failed("导入失败！");
        }
    }
}
```

——复杂导出

        1、首先添加商品对象Product，用于封装商品信息；

```java
/**
 * 商品
 * Created by macro on 2021/10/12.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Product {
    @Excel(name = "ID", width = 10)
    private Long id;
    @Excel(name = "商品SN", width = 20)
    private String productSn;
    @Excel(name = "商品名称", width = 20)
    private String name;
    @Excel(name = "商品副标题", width = 30)
    private String subTitle;
    @Excel(name = "品牌名称", width = 20)
    private String brandName;
    @Excel(name = "商品价格", width = 10)
    private BigDecimal price;
    @Excel(name = "购买数量", width = 10, suffix = "件")
    private Integer count;
}
```

        2、然后添加订单对象Order，订单和会员是一对一关系，使用@ExcelEntity注解表示，订单和商品是一对多关系，使用@ExcelCollection注解表示，Order就是我们需要导出的嵌套订单数据；

```java
/**
 * 订单
 * Created by macro on 2021/10/12.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Order {
    @Excel(name = "ID", width = 10,needMerge = true)
    private Long id;
    @Excel(name = "订单号", width = 20,needMerge = true)
    private String orderSn;
    @Excel(name = "创建时间", width = 20, format = "yyyy-MM-dd HH:mm:ss",needMerge = true)
    private Date createTime;
    @Excel(name = "收货地址", width = 20,needMerge = true )
    private String receiverAddress;
    @ExcelEntity(name = "会员信息")
    private Member member;
    @ExcelCollection(name = "商品列表")
    private List<Product> productList;
}
```

        3、接下来在Controller中添加导出订单列表的接口，由于有些会员信息我们不需要导出，可以调用ExportParams中的setExclusions方法排除掉；

```java
**
 * EasyPoi导入导出测试Controller
 * Created by macro on 2021/10/12.
 */
@Controller
@Api(tags = "EasyPoiController", description = "EasyPoi导入导出测试")
@RequestMapping("/easyPoi")
public class EasyPoiController {

    @ApiOperation(value = "导出订单列表Excel")
    @RequestMapping(value = "/exportOrderList", method = RequestMethod.GET)
    public void exportOrderList(ModelMap map,
                                HttpServletRequest request,
                                HttpServletResponse response) {
        List<Order> orderList = getOrderList();
        ExportParams params = new ExportParams("订单列表", "订单列表", ExcelType.XSSF);
        //导出时排除一些字段
        params.setExclusions(new String[]{"ID", "出生日期", "性别"});
        map.put(NormalExcelConstants.DATA_LIST, orderList);
        map.put(NormalExcelConstants.CLASS, Order.class);
        map.put(NormalExcelConstants.PARAMS, params);
        map.put(NormalExcelConstants.FILE_NAME, "orderList");
        PoiBaseView.render(map, request, response, NormalExcelConstants.EASYPOI_EXCEL_VIEW);
    }
}
```

——自定义处理

        1、如果你想对导出字段进行一些自定义处理，EasyPoi也是支持的，比如在会员信息中，如果用户没有设置昵称，我们添加下暂未设置信息。

        2、我们需要添加一个处理器继承默认的ExcelDataHandlerDefaultImpl类，然后在exportHandler方法中实现自定义处理逻辑；

```java
/**
 * 自定义字段处理
 * Created by macro on 2021/10/13.
 */
public class MemberExcelDataHandler extends ExcelDataHandlerDefaultImpl<Member> {

  @Override
  public Object exportHandler(Member obj, String name, Object value) {
    if("昵称".equals(name)){
      String emptyValue = "暂未设置";
      if(value==null){
        return super.exportHandler(obj,name,emptyValue);
      }
      if(value instanceof String&&StrUtil.isBlank((String) value)){
        return super.exportHandler(obj,name,emptyValue);
      }
    }
    return super.exportHandler(obj, name, value);
  }

  @Override
  public Object importHandler(Member obj, String name, Object value) {
    return super.importHandler(obj, name, value);
  }
}
```

        3、然后修改Controller中的接口，调用MemberExcelDataHandler处理器的setNeedHandlerFields设置需要自定义处理的字段，并调用ExportParams的setDataHandler设置自定义处理器；

```java
/**
 * EasyPoi导入导出测试Controller
 * Created by macro on 2021/10/12.
 */
@Controller
@Api(tags = "EasyPoiController", description = "EasyPoi导入导出测试")
@RequestMapping("/easyPoi")
public class EasyPoiController {

    @ApiOperation(value = "导出会员列表Excel")
    @RequestMapping(value = "/exportMemberList", method = RequestMethod.GET)
    public void exportMemberList(ModelMap map,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {
        List<Member> memberList = LocalJsonUtil.getListFromJson("json/members.json", Member.class);
        ExportParams params = new ExportParams("会员列表", "会员列表", ExcelType.XSSF);
        //对导出结果进行自定义处理
        MemberExcelDataHandler handler = new MemberExcelDataHandler();
        handler.setNeedHandlerFields(new String[]{"昵称"});
        params.setDataHandler(handler);
        map.put(NormalExcelConstants.DATA_LIST, memberList);
        map.put(NormalExcelConstants.CLASS, Member.class);
        map.put(NormalExcelConstants.PARAMS, params);
        map.put(NormalExcelConstants.FILE_NAME, "memberList");
        PoiBaseView.render(map, request, response, NormalExcelConstants.EASYPOI_EXCEL_VIEW);
    }
}
```

# 1、Java知识点整理

## 1、JavaSE基础

### `jdk和jre的区别`

——jdk是java的开发工具包，提供了java的开发环境和运行环境

——jre是java的运行环境，为java的运行提供了环境

### `==和equals的区别`

——==对于基本类型比较的是值是否相同，对于引用类型比较的是引用地址是否相同

——equals本质上就是==，只是String和Integer等重写了equals方法，把它变成了值比较

### `final在java中的作用`

——修饰的类为最终类，不能被继承

——修饰的方法不能被重写

——修饰的变量叫做常量，常量必须初始化，初始化后值就不能被修改

### `String属于基础类型吗`

——不属于基础类型，而是属于引用类型。基础类型有：byte、boolean、char、short、int、float、long、double

### `操作字符串的类`

——String:声明的是不可变的对象，每次操作都会生成新的String对象，然后将指针指向新的String对象

——StringBuffer:可以在原对象的基础上进行操作，线程安全，性能相对StringBuilder低，建议多线程使用

——StringBuilder:可以在原对象的基础上进行操作，非线程安全，性能相对StringBuffer高，建议单线程使用

### `如何实现字符串反转`

——使用StringBuffer或StringBuilder的reverse方法

### `String常见方法`

——indexOf:返回指定字符的索引

——charAt:返回指定索引处的字符

——replace:字符串替换

——trim：去除字符串两端空白

——split:分个字符串，返回一个分割后的字符串数组

——getBytes：返回字符串的byte类型数组

——length：返回字符串长度

——toLowerCase:将字符串转换为小写形式

——toUpperCase:将字符串转换为大写形式

——substring：截取字符串

——equals:字符串比较

### `普通类和抽象类的区别`

——普通类:不能包含抽象方法，可以直接实例化

——抽象类:不能直接实例化，可以包含抽象方法（不是必须的），不能被final修饰，因为抽象类就是需要被其他类继承的

### `接口和抽象类的区别`

——实现:抽象类的子类需要使用extends来继承，接口使用implements来实现接口

——构造方法:抽象类可以有，而接口不能有

——main方法:抽象类可有且可运行，接口不能有

——访问修饰符:抽象类中的方法可以是任意修饰符，接口中的方法默认为public

### `BIO、NIO、AIO的区别`

——BIO(Block IO):同步阻塞式IO,平常使用的传统IO(模式简单、使用方便、并发处理能力低)

——NIO(New IO):同步非阻塞IO，传统IO的升级(客户端和服务器端通过channel(通道)通讯，实现了多路复用)

——AIO(Asynchronous IO):异步非阻塞IO，NIO的升级(异步IO的操作基于事件和回调机制)

### `Files的常用方法有哪些`

——exists:检测文件路径是否存在

——createFile:创建文件

——createDrectory:创建文件夹

——delete:删除一个文件或目录

——copy:复制文件

——move:移动文件

——size:查看文件个数

——read:读取文件

——write:写入文件

### `建立数组的方式`

——int[] arr = new int[6];

——int[] arr = {...};

——int[] arr = new int[]{...};

## 2、数据库

### 1、MySQL

#### `mysql分页查询`

——方式一

```sql
-- 该语句的意思为，查询m+n条记录，去掉前m条，返回后n条记录。无疑该查询能够实现分页功能，
-- 但是如果m的值越大，查询的性能会越低（越后面的页数，查询性能越低），
-- 因为MySQL同样需要扫描过m+n条记录。

select * from table order by id limit m, n;
```

——方式二

```sql
-- 该方式每次会返回n条记录，却无需像方式1扫描过m条记录，在大数据量的分页情况下，
-- 性能可以明显好于方式1，但该分页查询必须要每次查询时拿到上一次查询（上一页）
-- 的一个最大id（或最小id）。该查询的问题就在于，我们有时没有办法拿到上一次查
-- 询（上一页）的最大id（或最小id），比如当前在第3 页，需要查询第5页的数据，
-- 该查询方法便爱莫能助了

select * from table where id > #max_id# order by id limit n;
```

——方式三

```sql
-- 为了避免能够实现方式2不能实现的查询，就同样需要使用到limit m, n子句，
-- 为了性能，就需要将m的值尽力的小，比如当前在第3页，需要查询第5页，
-- 每页10条数据，当前第3页的最大id为#max_id#：
-- 其实该查询方式是部分解决了方式2的问题，但如果当前在第2页，需要查询第100页或1000页，
-- 性能仍然会较差。

select * from table where id > #max_id# order by id limit 20, 10;
```

#### `MySQL数据库优化`

——

——

——

——

### 2、Oracle

`oracle分页查询`

——方式一

```sql
-- 根据ROWID来分  取500到10000
select * from t_student where rowid in(
        select rid from(
                  select rownum rn,rid from(
                   select rowid rid,cid from t_student)
             where rownum<10000)
            where rn>500)
       order by cid desc;
```

——方式二

```sql
-- 按ROWNUM来分  取500到10000
select * from(
                     select t.*,rownum rn from(
                                        select * from t_student) t
                           where rownum<10000)
where rn>500
```

### 3、数据库查询记录大于n条的记录

```sql
select 字段1,字段2,字段3 from 表名 group by 字段1,字段2,字段3 having count(*)>n
```

## 3、Spring

## 4、SpringBoot

## 5、SpringCloud
