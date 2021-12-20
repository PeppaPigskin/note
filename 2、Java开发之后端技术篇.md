# 一、主流技术

## 1、MybatisPlus

### 1、说明

```java
针对mybatis做的增强,简化开发
```
### 2、在线学习地址

```java
http://mp.baomidou.com
```
### 3、整合过程

```markdown
# 导入依赖
<!-- mybatisplus依赖 -->
<dependency>            
	<groupId>com.baomidou</groupId>      
	<artifactId>mybatis-plus-boot-starter</artifactId>   
	<version>3.2.0</version>  
</dependency>
<!-- mysql驱动 -->
<!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
<dependency>
	<groupId>mysql</groupId>
	<artifactId>mysql-connector-java</artifactId>    
	<version>8.0.17</version>
</dependency>

# 配置文件配置
-- application.yml中配置数据源相关信息
#配置mysql数据源
spring:
	datasource:
		username: root
		password: root
		url: jdbc:mysql://192.168.56.106:3306/db_mall_sms
		driver-class-name: com.mysql.jdbc.Driver
		
-- 配置mybatisplus相关配置
#配置mybatis-plus查找sql映射文件
mybatis-plus.mapper-locations=classpath:/mapper/**/*.xml
#配置主键自增
mybatis-plus.global-config.db-config.id-type=auto
#全局逻辑删除的实体字段名[since 3.3.0,配置后可以忽略不配置步骤2
mybatis-plus.global-config.db-config.logic-delete-field=flag 
#逻辑已删除值[默认为1]
mybatis-plus.global-config.db-config.logic-delete-value=1 
#逻辑未删除值[默认为0]    
mybatis-plus.global-config.db-config.logic-not-delete-value=0                     
```
### 4、使用步骤

```markdown
# 创建数据库，创建数据表，添加数据用于mp操作

# 初始化工程
-- 使用Spring Initializr快速初始化一个SpringBoot工程
-- 当前使用版本：2.2.1.RELEASE
-- Artifact中安装mybatis-plus插件

# 添加依赖                     
<dependencies>
	<!--springboot启动器依赖-->
	<dependency>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter</artifactId>
	</dependency>

	<!--springboot测试依赖-->
	<dependency>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-test</artifactId>
		<scope>test</scope>
		<exclusions>
			<exclusion>
      <groupId>org.junit.vintage</groupId>
      <artifactId>junit-vintage-engine</artifactId>
      </exclusion>
    </exclusions>
  </dependency>

  <!--mybatis-plus依赖-->
  <dependency>
  	<groupId>com.baomidou</groupId>
  	<artifactId>mybatis-plus-boot-starter</artifactId>
  	<version>3.0.5</version>
  </dependency>

  <!--mysql依赖-->
  <dependency>
  	<groupId>mysql</groupId>
  	<artifactId>mysql-connector-java</artifactId>
  </dependency>

  <!--lombok用来简化实体类的开发（通过注解形式就不需要写get和set方法）-->
  <dependency>
  	<groupId>org.projectlombok</groupId>
  	<artifactId>lombok</artifactId>
  </dependency>
</dependencies>

# 安装lombok插件
Settings-->Plugins-->Marketplace-->搜索lombok进行安装  

# 创建配置文件[application.properties或application.yml],并添加配置项内容如下:
#mysql5
#spring.datasource.driver-class-name=com.mysql.jdbc.Driver
#spring.datasource.url=jdbc:mysql://localhost:3306/mybatis_plus
#mysql8以上（springboot2.1以上）
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
##【serverTimezone=GMT%2B8】表示时区;【&useUnicode=true&characterEncoding=utf8】用于设置编码格式，防止中文乱码
spring.datasource.url=jdbc:mysql://localhost:3306/mybatis_plus?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf8
spring.datasource.username=root
spring.datasource.password=root
#mybatis日志
##查看更详细的内容
mybatis-plus.configuration.log-impl=org.apache.ibatis.logging.stdout.StdOutImpl
#设置逻辑删除默认值配置，可自动以配置
mybatis-plus.global-config.db-config.logic-delete-value=1
mybatis-plus.global-config.db-config.logic-not-delete-value=0

# 编写代码
-- 创建对应实体类
-- 创建对应mapper接口文件继承自BaseMapper<对应实体类名>                     
```

### 5、主键生成策略

```markdown
# 分类
AUTO_INCREMENT————自动增长,缺点是进行分表操作时，下一张表需要知道上一张表的最后一个id
UUID————每次操作都会生成随机的一个唯一的值,缺点是无法通过生成的值进行排序
Redis实现————依据redis的原子操作INCR和INCRBY来实现
MP自带策略————snowflake算法：使用41bit作为毫秒数，10bit作为机器的ID（5个bit是数据中心，5个bit的机器ID），12bit作为毫秒内的流水号（意味着每个节点在每毫秒可以产生 4096 个 ID），最后还有一个符号位，永远是0。	

# 使用
在要生成主键的属性上添加注解:@TableId（type=IdType.xxx）
```

### 6、自动填充

```markdown
# 实现步骤
-- 在实体类中进行自动填充的属性上添加注解：@TableField（fill=FieldFill.xxx）
	@TableField(fill = FieldFill.INSERT)
  private Date createTime;
  @TableField(fill = FieldFill.INSERT_UPDATE)
  private Date updateTime;
  
-- 创建类（元对象处理类），实现接口MetaObjectHandler，并实现接口中的方法，同时将该类交由spring管理
    @Component//将该类交由spring容器管理
    public class MyMetaObjectHandler implements MetaObjectHandler {
        @Override
        public void insertFill(MetaObject metaObject) {
            //metaObject:元数据对象
            this.setFieldValByName("createTime", new Date(), metaObject);
            this.setFieldValByName("updateTime", new Date(), metaObject);
        }
    
        @Override
        public void updateFill(MetaObject metaObject) {
            //metaObject:元数据对象
            this.setFieldValByName("updateTime", new Date(), metaObject);
        }
    }
```

### 7、乐观锁

```markdown
# 作用
主要解决丢失更新问题(并发修改同一条记录时，最后一次的提交会将之前的更新覆盖。)

# 解决方案
-- 悲观锁(串行)
-- 乐观锁

# 实现原理
-- 1、取出记录时，获取当前version
-- 2、更新时，带上这个version
-- 3、执行更新时，set version=newVersion where version=oldVersion
-- 4、如果version不对，就更新失败

# 具体实现
-- 1、表添加字段，作为乐观锁的版本号
-- 2、对应实体添加版本号属性
-- 3、在实体类版本号属性添加注解@Version
-- 4、配置乐观锁插件（写到配置类中）
// Spring xml方式
<bean class="com.baomidou.mybatisplus.extension.plugins.inner.OptimisticLockerInnerInterceptor" id="optimisticLockerInnerInterceptor"/>  
<bean id="mybatisPlusInterceptor" class="com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor">    
  <property name="interceptors">        
    <list>              
      <ref bean="optimisticLockerInnerInterceptor"/>    
    </list>   
  </property>
</bean>
// Springboot 注解方式
@Bean
public MybatisPlusInterceptor mybatisPlusInterceptor() {  
MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();    
interceptor.addInnerInterceptor(new OptimisticLockerInnerInterceptor());  
return interceptor;
}
```

### 8、分页实现

```markdown
# 说明
PageHelper类似

# 实现步骤
-- 1、配置分页插件
  /**    
  * 分页插件
  * 
  * @return 
  */ 
  @Bean 
  public PaginationInterceptor paginationInterceptor() {
    return new PaginationInterceptor();
  }
  
-- 2、编写分页代码
  /**     
  * 分页查询    
  */
  @Test
  void testPageSelect() {  
    //1、创建page对象(分页当前页，每页条数)  
    Page<User> page = new Page<>(2, 2);  
    //2、调用mp分页查询方法(分页对象，条件)，会将分页所有的对象封装到page对象中 
    userMapper.selectPage(page, null);  
    //3、通过page对象获取分页数据  
    System.out.println("当前页：" + page.getCurrent());  
    System.out.println("每页数据list集合：" + page.getRecords()); 
    System.out.println("每页显示记录数：" + page.getSize());  
    System.out.println("总记录数：" + page.getTotal()); 
    System.out.println("总页数：" + page.getPages());  
    System.out.println("是否有下一页：" + page.hasNext()); 
    System.out.println("是否有上一页：" + page.hasPrevious()); 
  }
```

### 9、简单查询

```markdown
# 根据ID查询————xxxMapper.selectById([id值])
  /**     
  * 根据id查询
  */
  @Test
  void selectById() {
    //根据id查询数据   
    User user = userMapper.selectById(1409337486740770818L);  
    System.out.println(user);    
	}

# 通过多个id批量查询————xxxMapper.selectBatchIds([id集合])
  /**     
  * 根据多个id批量查询    
  */
  @Test
  void testSelectByIds(){
    List<User> users = userMapper.selectBatchIds(Arrays.asList(1409341740750704641L, 1409341829028179969L)); 
    System.out.println(users);
  }

# 通过map封装查询条件————xxxMapper.selectByMap([map对象])
  /**
  * 通过map封装查询条件    
  */
  @Test 
  void testSelectByMap() {
    Map<String, Object> map = new HashMap<>();
    map.put("name", "mary"); 
    map.put("age", 16);
    List<User> users = userMapper.selectByMap(map);
    System.out.println(users);    
  }
```

### 10、复杂条件查询

```markdown
# 一般复杂查询使用QueryWrapper对象,结构图如下:
```

<img src="image/img2_1_1_10_1.png" style="zoom:50%;" />

```markdown
# 包含的常见操作,如图所示:
	select                                     指定查询的列                                      
```

<img src="image/img2_1_1_10_2.png" style="zoom:50%;" />

```markdown
# 代码实现步骤
  /**     
  * 复杂查询操作实现 
  */ 
  @Test
  void testSelectByQueryWrapper() {   
    //1、创建QueryWrapper对象        
    QueryWrapper<User> wrapper = new QueryWrapper<>();       
    //2、使用QueryWrapper对象设置条件       
    //ge【大于等于】、gt【大于】、le【小于等于】、lt【小于】 
    //  查询大于ag>25的      
    wrapper.gt("age", 25);    
    //eq【等于】、ne【不等于】       
    //  查询name等于mary的值       
    wrapper.eq("name", "mary");       
    //  查询name不等于mary的值       
    wrapper.ne("name", "mary");       
    //between【在范围内】包含边界       
    //  查询age在20-30之间的      
    wrapper.between("age", 20, 40);  
    //like【模糊查询】       
    //  查询名字中包含“骨”的数据   
    wrapper.like("name", "骨");
    //orderByDesc【排序】     
    //  根据id降序排列       
    wrapper.orderByDesc("id");  
    //last【直接拼接到sql最后】   
    wrapper.last("limit 1");      
    //指定查询列       
    wrapper.select("name", "age", "id");   
    List<User> users = userMapper.selectList(wrapper);  
    System.out.println(users); 
  }
```

### 11、物理删除

```markdown
# 说明
	直接从数据库中将数据记录删除

# 代码实现
-- 根据id删除
	/**     
	* 根据id删除
  */
  @Test
  void deleteById() {
  	int i = userMapper.deleteById(1409341740750704641L);   
  	System.out.println(i);    
 	}
	
-- 根据id批量删除
	/**     
	* 根据id集合批量删除  
  */
  @Test  
  void deleteByIds() {
  	int i = userMapper.deleteBatchIds(Arrays.asList(1409341740750704641L, 1409341829028179969L));   			
  	System.out.println(i);    
  }

-- 根据map条件删除
	/**
  * 根据map条件删除    
  */
  @Test
  void deleteByMap() {
  	Map<String, Object> map = new HashMap<>(); 
    map.put("name", "mary");
    map.put("age", 16);  
    int i = userMapper.deleteByMap(map);  
    System.out.println(i); 
  }
```



### 12、逻辑删除

```markdown
# 1、表中添加逻辑删除字段，标识数据是否被删除

# 2、实体类中添加对应属性，并添加@TableLogic和@TableField(fill=FieldFill.INSERT)注解
	/**     
	* 逻辑删除标识，并添加自动填充注解，以及逻辑删除注解     
	*/ 
  @TableLogic 
  @TableField(fill = FieldFill.INSERT)    
  private Integer deleted;

# 3、元对象处理类添加自动填充设置
	/**     
	* 数据插入操作自动填充属性    
  *
  * @param metaObject 元数据对象     
  */
  @Override 
  public void insertFill(MetaObject metaObject) { 
  	//自动填充createTime字段   
  	this.setFieldValByName("createTime", new Date(), metaObject);
    //自动填充updateTime字段 
    this.setFieldValByName("updateTime", new Date(), metaObject);   
    //自动填充乐观锁版本号version默认值
    this.setFieldValByName("version", 1, metaObject);   
    //自动填充逻辑删除标志deleted默认值 
    this.setFieldValByName("deleted", 0, metaObject);
  }

# 4、配置类文件（application.xml）中添加配置
	# 逻辑删除配置(设置删除标志值，以及未删除标志值，可自定义)
	mybatis-plus.global-config.db-config.logic-delete-value=1
	mybatis-plus.global-config.db-config.logic-not-delete-value=0
	
# 5、配置类中添加实现逻辑删除的插件
	/**     
	* 逻辑删除插件 
  */ 
  @Bean
  public ISqlInjector iSqlInjector(){   
  	return  new LogicSqlInjector();  
  }
# 注意：配置了之后就查询不了删除的数据，要查只能自己配置Mapper对应的xml文件进行自定义语句查询
```

### 13、性能分析插件

```markdown
# 作用
	性能分析拦截器，用于输出每条SQL语句及其执行时间

# 配置插件
	/**     
	* SQL执行性能分析插件   
  * 
  * @return
  */ 
  @Bean
  @Profile({"dev", "test"})//设置dev、test环境开启
  public PerformanceInterceptor performanceInterceptor() {    
    PerformanceInterceptor performanceInterceptor = new PerformanceInterceptor();      
    //SQL执行最大时长，超时自动停止运行，有助于发现问题   
    performanceInterceptor.setMaxTime(100);   
    //SQL是否格式化，默认为false   
    performanceInterceptor.setFormat(true); 
    return performanceInterceptor; 
  }

# 超过配置的时间会发生异常
	Caused by: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: The SQL execution time is too large, please optimize !
```

### 14、代码生成器生成接口结构

```markdown
# 说明
	AutoGenerator 是 MyBatis-Plus 的代码生成器，通过 AutoGenerator 可以快速生成 Entity、Mapper、Mapper XML、Service、Controller 等各个模块的代码，极大的提升了开发效率。

# 代码实现 
  /**
	* Mp代码生成模版
	*/
  @Test    
  public void run() { 
  	// 1、创建代码生成器      
    AutoGenerator mpg = new AutoGenerator();  
    
    // 2、全局配置    
    GlobalConfig gc = new GlobalConfig();
    //获取项目路径   
    String projectPath = System.getProperty("user.dir");     
    //设置代码生成后的输出目录(建议设置成绝对路径)        
    projectPath = "E:\\项目开发\\edu_parent\\service\\service_edu"; 
    gc.setOutputDir(projectPath + "/src/main/java");    
    //作者     
    gc.setAuthor("Pigskin");       
    //生成后是否打开资源管理器   
    gc.setOpen(false);
    //重新生成时文件是否覆盖     
    gc.setFileOverride(false); 
    //去掉Service接口的首字母I     
    gc.setServiceName("%sService");  
    //主键策略    
    gc.setIdType(IdType.ID_WORKER_STR);    
    //定义生成的实体类中日期类型     
    gc.setDateType(DateType.ONLY_DATE);
    //开启Swagger2模式  
    gc.setSwagger2(true);  
    mpg.setGlobalConfig(gc);      
    
    // 3、数据源配置     
    DataSourceConfig dsc = new DataSourceConfig();    
    dsc.setUrl("jdbc:mysql://localhost:3306/db_online_education?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf8");        
    dsc.setDriverName("com.mysql.cj.jdbc.Driver");        dsc.setUsername("root");        
    dsc.setPassword("root"); 
    dsc.setDbType(DbType.MYSQL);     
    mpg.setDataSource(dsc);     
    
    // 4、包配置  
    PackageConfig pc = new PackageConfig();     
    //包名   
    pc.setParent("com.pigskin");     
    //模块名     
    pc.setModuleName("edu_service");  
    pc.setController("controller");   
    pc.setEntity("entity");      
    pc.setService("service");     
    pc.setMapper("mapper");    
    mpg.setPackageInfo(pc);     
    
    // 5、策略配置     
    StrategyConfig strategy = new StrategyConfig();      
    strategy.setInclude("edu_teacher");       
    //数据库表映射到实体的命名策略    
    strategy.setNaming(NamingStrategy.underline_to_camel);    
    //生成实体时去掉表前缀      
    strategy.setTablePrefix(pc.getModuleName() + "_");    
    //数据库表字段映射到实体的命名策略      
    strategy.setColumnNaming(NamingStrategy.underline_to_camel);       
    // lombok 模型 @Accessors(chain = true) setter链式操作  
    strategy.setEntityLombokModel(true);    
    //restful api风格控制器 
    strategy.setRestControllerStyle(true); 
    //url中驼峰转连字符 
    strategy.setControllerMappingHyphenStyle(true); 
    mpg.setStrategy(strategy);
    
    // 6、执行   
    mpg.execute(); 
  }	
```





## 2、Swagger

```markdown
# 说明
	生成在线接口文档,方便接口测试

# 实现步骤
-- 1、在父工程下创建maven模块【common】

-- 2、pom中引入相关依赖
	<!--swagger相关依赖-->       
  <dependency>  
  	<groupId>io.springfox</groupId>    
  	<artifactId>springfox-swagger2</artifactId>
  	<scope>provided</scope>   
  </dependency>  
  <dependency>    
  	<groupId>io.springfox</groupId>   
  	<artifactId>springfox-swagger-ui</artifactId>       
  	<scope>provided</scope>    
  </dependency>

-- 3、common模块下创建子模块【service_base】

-- 4、在其中创建swagger配置类
  package com.pigskin.service_base;
  import com.google.common.base.Predicates;
  import org.springframework.context.annotation.Bean;
  import org.springframework.context.annotation.Configuration;
  import springfox.documentation.builders.ApiInfoBuilder;
  import springfox.documentation.builders.PathSelectors;
  import springfox.documentation.service.ApiInfo;
  import springfox.documentation.service.Contact;
  import springfox.documentation.spi.DocumentationType;
  import springfox.documentation.spring.web.plugins.Docket;
  import springfox.documentation.swagger2.annotations.EnableSwagger2;
  
  @Configuration
  @EnableSwagger2//swagger注解
  public class SwaggerConfig {  
  	private ApiInfo webApiInfo() {   
    	return new ApiInfoBuilder().title("在线教育网-课程中心API文档")       
      	.description("本文档描述了课程中心微服务接口定义")    
        .version("1.0")  
        .contact(new Contact("Pigskin", "http://pigskin.com", "123456789@qq.com"))  
        .build();
    }
    /**     
    * swagger插件
    *
    * @return
    */
    @Bean    
    public Docket webApiConfig() {
    	return new Docket(DocumentationType.SWAGGER_2)//类型   
      	.groupName("WebApi")//表示分组      
        .apiInfo(webApiInfo())//设置在线文档信息     
        .select() 
        .paths(Predicates.not(PathSelectors.regex("/admin/.*")))//忽略显示的              
        .paths(Predicates.not(PathSelectors.regex("/error/.*")))//忽略显示的   
        .build(); 
    }
  }

-- 5、具体使用
	-- 1、在对应模块中引入配置的依赖
		<dependency>           
    	<groupId>com.pigskin</groupId> 
      <artifactId>service_base</artifactId>   
      <version>0.0.1-SNAPSHOT</version> 
    </dependency>
    
	-- 2、在对应模块启动类中添加相应注解
		@ComponentScan(basePackages = {"com.pigskin"})
		
	-- 3、访问swagger
		http://localhost:[对应服务端口]/swagger-ui.html
```



## 3、Nginx

```markdown
# 说明
	反向代理服务器

# 功能
  -- 请求转发
  	-- 说明————根据用户请求，路径匹配，将请求转发到对应服务器
  	-- 示例————如下:
  		1、客户端浏览器发起请求
  		2、nginx得到用户的请求（9001），根据请求转发到具体服务器（路径匹配）
  		3、如果地址包含（eduservice），请求转发到（eduservice）8001，如果地址包含（ossservice），请求转发到（ossservice）8002
  	-- 实现步骤————如下:
  		1、找到nginx配置文件【nginx.conf】
  		2、修改nginx配置文件【nginx.conf】的【server{}】中的默认端口【80】，改为【81】————listen 81;
  		3、配置nginx转发规则,在【http{}】中创建如下配置:
  			 server {		
  			 	# 对外监听端口		
  			 	listen 9001;
          # 主机名称		
          server_name localhost;	
          # 规则(请求地址包含匹配路径，请求就会转发到对应地址；【~】表示匹配方式为正则匹配)	
          location ~/edu_service/ {# 设置匹配路径		
          	#设置请求转发地址			
          	proxy_pass http://localhost:8001;	
          }
          location ~/oss_service/ {# 设置匹配路径		
          	#设置请求转发地址			
          	proxy_pass http://localhost:8002;
          }	
        }
			4、重启nginx
				#先停掉
				nginx.exe -s stop
				#再重启
				nginx.exe
  -- 负载均衡
  	-- 说明————多台服务器中放相同的内容（集群效果），多台服务器平均分摊压力
  	-- 分摊规则
  		1、轮询
  		2、根据请求时间
  	-- 示例
  		1、客户端浏览器发起请求
  		2、nginx得到用户的请求（9001），根据请求转发到具体服务器（路径匹配）

  -- 动静分离
  	-- 说明————将java代码和普通页面分开进行部署，每个请求分开访问

# 安装/启动
	-- 1、官网下载————http://nginx.org/en/download.html
	-- 2、使用cmd启动（niginx.exe所在目录，执行niginx.exe）
	-- 3、使用命令停止运行（niginx.exe所在目录，执行niginx.exe -s stop）
	-- 注：cmd启动的niginx.exe直接关闭不会被退出
```



## 4、Tomcat

```markdown
# 说明
	Tomcat是Apache 软件基金会（Apache Software Foundation）的Jakarta 项目中的一个核心项目，由Apache、Sun 和其他一些公司及个人共同开发而成。由于有了Sun 的参与和支持，最新的Servlet 和JSP 规范总是能在Tomcat 中得到体现，Tomcat 5支持最新的Servlet 2.4 和JSP 2.0 规范。因为Tomcat 技术先进、性能稳定，而且免费，因而深受Java 爱好者的喜爱并得到了部分软件开发商的认可，成为比较流行的Web 应用服务器。

```



## 5、EasyExcel

```markdown
# 说明
	EasyExcel是一个基于Java的简单、省内存的读写Excel的开源项目。在尽可能节约内存的情况下支持读写百M的Excel。GitHub地址:https://github.com/alibaba/easyexcel

# 主要功能
	-- 数据导入：减轻录入工作量
	-- 数据导出：统计信息归档
	-- 数据传输：异构系统之间数据传输
	
# 使用步骤
	-- 1、POM引入EasyExcel相关依赖
		<dependencies>     
    	<!--easyexcel相关依赖，本质对poi的封装，父工程已经引入poi,此版本easyexcel对应poi3.17--> 
      <dependency>
      	<groupId>com.alibaba</groupId>     
        <artifactId>easyexcel</artifactId>         
        <version>2.1.1</version>   
      </dependency>  
      <!--xls-->
      <dependency>
      	<groupId>org.apache.poi</groupId>            
      	<artifactId>poi</artifactId>        
      </dependency> 
    </dependencies>
    
	-- 2、实现Excel写操作,步骤如下:
		-- 1、创建实体类和Excel对应
			@Datapublic class ExcelDemo {   
        /**
        * 设置表头名称 
        */
        @ExcelProperty("学生编号")
        private Integer sno;    
        /**
        * 设置表头名称  
        */
        @ExcelProperty("学生姓名")  
        private String sname;
      }
		-- 2、最终实现写操作
			public class TestEasyExcel {  
      	public static void main(String[] args) {     
        	//实现excel写操作      
          //1、设置写入文件夹地址和Excel文件名称      
          String fileName = "E:\\课程分类.xlsx";   
          //2、调用easyexcel中的方法实现写操作(文件路径名称，实体类class)   
          EasyExcel.write(fileName, ExcelDemo.class)              
          	.sheet("学生列表")              
          	.doWrite(getData());  
        }  
        /**    
        * 返回list集合   
        *  
        * @return    
        */    
        private static List<ExcelDemo> getData() {  
        	ArrayList<ExcelDemo> excelDemos = new ArrayList<>();     
          for (int i = 0; i < 10; i++) {       
          	ExcelDemo excelDemo = new ExcelDemo();          
            excelDemo.setSno(i);           
            excelDemo.setSname("lucy" + i);   
            excelDemos.add(excelDemo);     
          }       
          return excelDemos;  
        }
      }
		
	-- 3、实现Excel读操作————步骤如下:
		-- 1、创建实体类和Excel对应
			package com.pigskin.code_generator.excel;
			
			import com.alibaba.excel.annotation.ExcelProperty;
			import lombok.Data;
			
			/** 
			* EasyExcel测试类 
			*/
			@Data
			public class ExcelDemo {    
				/**
        * 设置表头名称，index表示对应excel的列 
        */
        @ExcelProperty(value = "学生编号",index = 0)   
        private Integer sno;  
        /**
        * 设置表头名称 
        */
        @ExcelProperty(value = "学生姓名",index = 1)  
        private String sname;
      }
		-- 2、创建读取excel监听器
			package com.pigskin.code_generator.excel;
			
			import com.alibaba.excel.context.AnalysisContext;
			import com.alibaba.excel.event.AnalysisEventListener;
			import java.util.Map;
			
			public class ExcelLister extends AnalysisEventListener<ExcelDemo> {  
      	/**    
        * 一行一行读取excel内容   
        * 
        * @param excelDemo  
        * @param analysisContext    
        */ 
        @Override   
        public void invoke(ExcelDemo excelDemo, AnalysisContext analysisContext) {  
        	System.out.println("****" + excelDemo);  
        }   
        
        /**   
        * 读取表头内容   
        *   
        * @param headMap 
        * @param context  
        */   
        @Override   
        public void invokeHeadMap(Map<Integer, String> headMap, AnalysisContext context) {   
        	System.out.println("表头" + headMap);   
        }
        
        /**   
        * 读完之后执行的方法  
        *   
        * @param analysisContext   
        */    
        @Override
        public void doAfterAllAnalysed(AnalysisContext analysisContext) {   
        	//TODO:
        }
      }
		-- 3、最终实现读取
			 //实现excel读操作       
       String fileName2 = "E:\\课程分类.xlsx";    
       EasyExcel.read(fileName2,ExcelDemo.class,new ExcelLister()).sheet().doRead();
```



## 6、Spring

## 7、SpringBoot

### 1、说明

```markdown
	spring的一套快速配置脚手架,用于快速开发单个微服务
```



### 2、SpringBoot多环境配置

```markdown
# 作用
	针对不同环境，使用不同的配置文件
	
# 分类
-- dev————开发环境————application-dev.properties
-- test————测试环境————application-test.properties
-- prod————生产环境————application-prod.properties

# 使用
	# 配置文档配置(代表当前配置文档是dev类型)
	spring.profiles.active=dev
```



## 8、SpringCloud

### 1、微服务简介

```markdown
# 特点
-- 一个项目中有多个端口的服务端口进行启动的
-- 一个项目拆分成独立的多个服务，每个服务能够独立运行

# 常用微服务开发框架
-- Spring Cloud(现在比较流行的)————https://spring.io/projects/spring-cloud

-- Dubbo(出现的早，有些公司也在用)————https://dubbo.apache.org/zh/

-- DropWizard（关注单个微服务的开发）————https://www.dropwizard.io/en/latest/

-- Consul、etcd&etc(微服务的模块)

```



### 2、分布式简介

```markdown
# 说明
 一个项目不同服务单独部署到不同的服务器
```



### 3、SpringCloud说明

```markdown
-- 不是一种技术，而是多种技术的集合
-- 包含多种框架（技术），使用这些技术实现微服务操作
-- 依赖于springboot技术
```



### 4、SpringCloud相关基础服务组件（框架）

```markdown
# 服务发现【Netflix Eureka（Nacos）】——注册中心
-- 作用
	将多个模块(微服务)在注册中心注册，就能实现多个模块之间的互相调用，【相当于中介】

-- 常见的注册中心
  Eureka(原生，2.0遇到性能瓶颈，停止维护)
  Zookeeper(支持，专业的独立产品。例如：dubbo)
  Consul(原生，Go语言开发)
  Nacos内容详见【1.9————Nacos】

-- 服务注册实现步骤
  1、相关模块引入依赖
    <!--服务注册-->
    <dependency>
      <groupId>org.springframework.cloud</groupId>
      <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
    </dependency>
  2、在要注册服务的配置文件中进行Nacos地址配置
    #nacos服务地址
    spring.cloud.nacos.discovery.server-addr=127.0.0.1:8848
  3、在启动类添加注解，进行nacos注册
  	@EnableDiscoveryClient
  4、启动测试
  	在nacos的服务列表中就会列举出来

# 服务调用【Netflix Feign】
-- Feign说明
  1、Feign是Netflix开发的声明式、模板化的HTTP客户端， Feign可以帮助我们更快捷、优雅地调用HTTP API。
  2、Feign支持多种注解，例如Feign自带的注解或者JAX-RS注解等。
  3、Spring Cloud对Feign进行了增强，使Feign支持了Spring MVC注解，并整合了Ribbon和Eureka，从而让Feign的使用更加方便。
  4、Spring Cloud Feign是基于Netflix feign实现，整合了Spring Cloud Ribbon和Spring Cloud Hystrix，除了提供这两者的强大功能外，还提供了一种声明式的Web服务客户端定义的方式。
  5、Spring Cloud Feign帮助我们定义和实现依赖服务接口的定义。在Spring Cloud feign的实现下，只需要创建一个接口并用注解方式配置它，即可完成服务提供方的接口绑定，简化了在使用Spring Cloud Ribbon时自行封装服务调用客户端的开发量。

-- 服务调用实现步骤
  1、引入相关依赖
    <!--服务调用-->
    <dependency>
      <groupId>org.springframework.cloud</groupId>
      <artifactId>spring-cloud-starter-openfeign</artifactId>
    </dependency>
  2、调用端启动类添加注解
  	@EnableFeignClients
  3、创建调用服务接口【@FeignClient("被调用的服务名")】，并设置被调用的方法【要设置完全路径、PathVariable一定要指定名称】
    packagecom.pigskin.eduservice.client;

    importcom.pigskin.common_utils.R;
    importorg.springframework.cloud.openfeign.FeignClient;
    importorg.springframework.stereotype.Component;
    importorg.springframework.web.bind.annotation.DeleteMapping;
    importorg.springframework.web.bind.annotation.PathVariable;

    /**
    * 定义服务调用接口
    */
    @Component
    @FeignClient("vod-service")//设置要调用的服务名
    public interface VodClient{
      /**
      * @param videoId
      * @return
      */
      @PathVariable("videoId")//定义要调用方法的路径,PathVariable一定要指定名称
      @DeleteMapping("/vod_service/video/removeVideoSourceById/{videoId}")
      R removeVideoSource(@PathVariable("videoId")StringvideoId);
    }
  4、将创建的服务接口注入到要使用的服务类中，进行调用即可
    //远端服务接口注入
    @Autowired private VodClient vodClient;

    @Override    
    public void deleteVideoById(String videoId) {  
      //获取视频ID      
      EduVideo eduVideo = baseMapper.selectById(videoId);    
      if (eduVideo != null && StringUtils.isEmpty(eduVideo.getVideoSourceId())) {   
      //TODO:根据视频ID,进行远程调用，实现对应阿里云视频删除         
      vodClient.removeVideoSource(eduVideo.getVideoSourceId()); 
      }      
      //删除小节      
      baseMapper.deleteById(videoId);  
    }

# 熔断器【Netflix Hystrix】
-- Hystrix说明
  1、查看被调用服务是否宕机（挂掉了），如果宕机，则进行熔断，否则继续执行
  2、一个供分布式系统使用，提供延迟和容错功能，保证复杂的分布系统在面临不可避免的失败时，仍能有其弹性。

-- Feign结合Hystrix使用步骤
  1、添加依赖
    <!--提供负载均衡-->  
    <dependency>
      <groupId>org.springframework.cloud</groupId> 
      <artifactId>spring-cloud-starter-netflix-ribbon</artifactId> 
    </dependency>
    <!--hystrix依赖，主要是用  @HystrixCommand -->
    <dependency>
      <groupId>org.springframework.cloud</groupId>
      <artifactId>spring-cloud-starter-netflix-hystrix</artifactId>   
    </dependency>
  2、调用端配置文件中添加hystrix配置
    #开启熔断机制
    feign.hystrix.enabled=true
    #设置hystrix超时时间，默认1000ms
    hystrix.command.default.execution.isolation.thread.timeoutInMilliseconds=6000
  3、设置的服务调用接口添加实现类，用于当发生熔断时，进行的处理操作
    /** 
    * vod服务远端接口实现类(用于实现熔断机制) 
    */
    @Component
    public class VodFileDegradeFeignClient implements VodClient { 
      @Override   
      public R removeVideoSource(String videoId) {     
      	return R.error().message("删除视频出错！");  
      }   

      @Override   
      public R removeVideoSources(List<String> videoIdList) {   
      	return R.error().message("删除多个视频出错！");  
      }
    }
  4、服务调用接口注解添加属性【fallback】,值为其实现类
  	@FeignClient(name="vod",fallback=VodFileDegradeFeignClient.class)

# 服务网关【Spring Cloud GateWay】
-- 说明
	什么是网关?————在客户端和服务端中间存在的一堵墙，可以起到【请求转发】【负载均衡】【权限控制】等,替代nginx

-- Gateway图示,如下:
```

<img src="image/img2_1_8_4_1.png" style="zoom:50%;" />

```markdown
-- 核心概念
	1、路由————路由是网关最基础的部分，路由信息有一个ID、一个目的URL、一组断言和一组Filter组成。如果断言路由为真，则说明请求的URL和配置匹配
	2、断言————Java8中的断言函数。Spring Cloud Gateway中的断言函数输入类型是Spring5.0框架中的ServerWebExchange。Spring Cloud Gateway中的断言函数允许开发者去定义匹配来自于http request中的任何信息，比如请求头和参数等。
	3、过滤器————一个标准的Spring webFilter。Spring cloud gateway中的filter分为两种类型的Filter，分别是Gateway Filter和Global Filter。过滤器Filter将会对请求和响应进行修改处理

-- 执行过程
	Spring cloud Gateway发出请求。然后再由Gateway Handler Mapping中找到与请求相匹配的路由，将其发送到Gateway web handler。Handler再通过指定的过滤器链将请求发送到我们实际的服务执行业务逻辑，然后返回。如下图所示:
```

<img src="image/img2_1_8_4_2.png" style="zoom:50%;" />

```markdown
-- 代码实现
	1、创建对应微服务模块————api_gateway
	2、引入相关依赖
		<dependencies>      
      <dependency>      
        <groupId>com.pigskin</groupId>      
        <artifactId>common_utils</artifactId>      
        <version>0.0.1-SNAPSHOT</version>   
      </dependency>   
      <dependency>          
        <groupId>org.springframework.cloud</groupId> 
        <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>    
      </dependency>   
      <dependency>        
        <groupId>org.springframework.cloud</groupId> 
        <artifactId>spring-cloud-starter-gateway</artifactId>  
        <version>2.1.2.RELEASE</version>    
      </dependency>      
      <!--gson-->   
      <dependency>  
        <groupId>com.google.code.gson</groupId> 
        <artifactId>gson</artifactId>        
      </dependency>      
      <!--服务调用-->       
      <dependency>     
        <groupId>org.springframework.cloud</groupId>    
        <artifactId>spring-cloud-starter-openfeign</artifactId>     
      </dependency>  
    </dependencies>
	3、编写application.properties配置文件
    # 服务端口
    server.port=8222
    # 服务名
    spring.application.name=service-gateway

    # nacos服务地址
    spring.cloud.nacos.discovery.server-addr=127.0.0.1:8848

    #使用服务发现路由
    spring.cloud.gateway.discovery.locator.enabled=true
    #服务路由名小写
    #spring.cloud.gateway.discovery.locator.lower-case-service-id=true

    #设置路由id(建议服务名)
    spring.cloud.gateway.routes[0].id=service-acl
    #设置路由的uri（lb://nacos中注册的服务名称）
    spring.cloud.gateway.routes[0].uri=lb://service-acl
    #设置路由断言,代理servicerId为auth-service的/auth/路径（匹配规则）
    spring.cloud.gateway.routes[0].predicates= Path=/*/acl/**

    #配置service-edu服务
    spring.cloud.gateway.routes[1].id=eduService
    spring.cloud.gateway.routes[1].uri=lb://eduService
    spring.cloud.gateway.routes[1].predicates= Path=/eduService/**
	4、创建启动类
		package com.pigskin.gateway;
		
		import org.springframework.boot.SpringApplication;
		import org.springframework.boot.autoconfigure.SpringBootApplication;
		import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
		
		@SpringBootApplication
		@EnableDiscoveryClient
		public class ApiGatewayApplication {   
    	public static void main(String[] args) {    
      	SpringApplication.run(ApiGatewayApplication.class, args); 
      }
    }

-- Gateway网关负载均衡
	1、负载均衡————将请求平均分摊到多台服务器
	2、实现负载均衡的几种方式
		轮询————
		权重————
		请求时间————
	3、实现原理
		如下图所示,默认不需要额外配置，只要多个服务名字一样，Gateway自动实现负载均衡

-- 相关工具类
	1、Gateway网关跨域【就不需要给每个控制器添加@CrossOrigin】
		package com.pigskin.gateway.config;
		
		import org.springframework.context.annotation.Bean;
		import org.springframework.context.annotation.Configuration;
		import org.springframework.web.cors.CorsConfiguration;
		import org.springframework.web.cors.reactive.CorsWebFilter;
		import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;
		import org.springframework.web.util.pattern.PathPatternParser;
		
		/** * 统一处理跨域 */
		@Configuration
		public class CorsConfig {  
    	@Bean  
    	public CorsWebFilter corsFilter() {  
    		CorsConfiguration config = new CorsConfiguration();  
    		config.addAllowedMethod("*");     
    		config.addAllowedOrigin("*");   
        config.addAllowedHeader("*");    
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource(new PathPatternParser()); 
        source.registerCorsConfiguration("/**", config);  
        return new CorsWebFilter(source); 
    	}
    }
	2、Gateway访问控制过滤器
    package com.pigskin.gateway.filter;

    import com.google.gson.JsonObject;
    import org.springframework.cloud.gateway.filter.GatewayFilterChain;
    import org.springframework.cloud.gateway.filter.GlobalFilter;
    import org.springframework.core.Ordered;
    import org.springframework.core.io.buffer.DataBuffer;
    import org.springframework.http.server.reactive.ServerHttpRequest;
    import org.springframework.http.server.reactive.ServerHttpResponse;
    import org.springframework.stereotype.Component;
    import org.springframework.util.AntPathMatcher;
    import org.springframework.web.server.ServerWebExchange;
    import reactor.core.publisher.Mono;
    import java.nio.charset.StandardCharsets;
    import java.util.List;

    /**
    * 全局Filter，统一处理会员登录与外部不允许访问的服务 
    */
    @Component
    public class AuthGlobalFilter implements GlobalFilter, Ordered {  
      private AntPathMatcher antPathMatcher = new AntPathMatcher();  
      @Override   
      public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {  
        ServerHttpRequest request = exchange.getRequest();  
        String path = request.getURI().getPath();   
        //api接口，校验用户必须登录     
        if (antPathMatcher.match("/api/**/auth/**", path)) {  
          List<String> tokenList = request.getHeaders().get("token");
          if (null == tokenList) {       
            ServerHttpResponse response = exchange.getResponse();      
            return out(response);      
          } else {
            //Boolean isCheck = JwtUtils.checkToken(tokenList.get(0));
            //if(!isCheck) {  
            ServerHttpResponse response = exchange.getResponse();  
            return out(response);
            //}       
          }      
        }      
        //内部服务接口，不允许外部访问      
        if (antPathMatcher.match("/**/inner/**", path)) {        
          ServerHttpResponse response = exchange.getResponse();   
          return out(response);     
        }        
        return chain.filter(exchange);  
      }   

      @Override   
      public int getOrder() { 
        return 0;  
      }    

      private Mono<Void> out(ServerHttpResponse response) {   
        JsonObject message = new JsonObject();   
        message.addProperty("success", false);    
        message.addProperty("code", 28004);      
        message.addProperty("data", "鉴权失败");    
        byte[] bits = message.toString().getBytes(StandardCharsets.UTF_8);  
        DataBuffer buffer = response.bufferFactory().wrap(bits);  
        //response.setStatusCode(HttpStatus.UNAUTHORIZED);     
        //指定编码，否则在浏览器中会中文乱码      
        response.getHeaders().add("Content-Type", "application/json;charset=UTF-8");  
        return response.writeWith(Mono.just(buffer));  
      }
    }
	3、Gateway异常处理
    package com.pigskin.gateway.handler;

    import org.springframework.beans.factory.ObjectProvider;
    import org.springframework.boot.autoconfigure.web.ResourceProperties;
    import org.springframework.boot.autoconfigure.web.ServerProperties;
    import org.springframework.boot.context.properties.EnableConfigurationProperties;
    import org.springframework.boot.web.reactive.error.ErrorAttributes;
    import org.springframework.boot.web.reactive.error.ErrorWebExceptionHandler;
    import org.springframework.context.ApplicationContext;
    import org.springframework.context.annotation.Bean;
    import org.springframework.context.annotation.Configuration;
    import org.springframework.core.Ordered;
    import org.springframework.core.annotation.Order;
    import org.springframework.http.codec.ServerCodecConfigurer;
    import org.springframework.web.reactive.result.view.ViewResolver;
    import java.util.Collections;import java.util.List;

    /**
    * 覆盖默认的异常处理 
    * 
    * @author yinjihuan 
    *
    */
    @Configuration
    @EnableConfigurationProperties({ServerProperties.class, ResourceProperties.class})
    public class ErrorHandlerConfig {  
      private final ServerProperties serverProperties; 
      private final ApplicationContext applicationContext; 
      private final ResourceProperties resourceProperties;  
      private final List<ViewResolver> viewResolvers;  
      private final ServerCodecConfigurer serverCodecConfigurer; 

      public ErrorHandlerConfig(ServerProperties serverProperties, 
        ResourceProperties resourceProperties,      
        ObjectProvider<List<ViewResolver>> viewResolversProvider,    
        ServerCodecConfigurer serverCodecConfigurer,          
        ApplicationContext applicationContext) {      
        this.serverProperties = serverProperties;   
        this.applicationContext = applicationContext;   
        this.resourceProperties = resourceProperties;   
        this.viewResolvers = viewResolversProvider.getIfAvailable(Collections::emptyList);   
        this.serverCodecConfigurer = serverCodecConfigurer;    
      }   

      @Bean  
      @Order(Ordered.HIGHEST_PRECEDENCE) 
      public ErrorWebExceptionHandler errorWebExceptionHandler(ErrorAttributes errorAttributes) { 
        JsonExceptionHandler exceptionHandler = new JsonExceptionHandler(   
        errorAttributes,              
        this.resourceProperties,      
        this.serverProperties.getError(),    
        this.applicationContext);      
        exceptionHandler.setViewResolvers(this.viewResolvers);        
        exceptionHandler.setMessageWriters(this.serverCodecConfigurer.getWriters());  
        exceptionHandler.setMessageReaders(this.serverCodecConfigurer.getReaders());  
        return exceptionHandler;  
      }
    }

    package com.pigskin.gateway.handler;

    import org.springframework.boot.autoconfigure.web.ErrorProperties;
    import org.springframework.boot.autoconfigure.web.ResourceProperties;
    import org.springframework.boot.autoconfigure.web.reactive.error.DefaultErrorWebExceptionHandler;
    import org.springframework.boot.web.reactive.error.ErrorAttributes;
    import org.springframework.context.ApplicationContext;
    import org.springframework.web.reactive.function.server.*;
    import java.util.HashMap;import java.util.Map;

    /**
    * 自定义异常处理(异常时用JSON代替HTML异常信息) 
    */
    public class JsonExceptionHandler extends DefaultErrorWebExceptionHandler {   
      public JsonExceptionHandler(ErrorAttributes errorAttributes, 
        ResourceProperties resourceProperties,           
        ErrorProperties errorProperties,
        ApplicationContext applicationContext) {  
        super(errorAttributes, resourceProperties, errorProperties, applicationContext);   
      }   

      /**   
      * 获取异常属性  
      */    
      @Override 
      protected Map<String, Object> getErrorAttributes(ServerRequest request, boolean includeStackTrace) {  
        Map<String, Object> map = new HashMap<>(); 
        map.put("success", false);  
        map.put("code", 20005);    
        map.put("message", "网关失败");     
        map.put("data", null);       
        return map;  
      }  

      /**  
      * 指定响应处理方法为JSON处理的方法 
      *  
      * @param errorAttributes  
      */
      @Override   
      protected RouterFunction<ServerResponse> getRoutingFunction(ErrorAttributes errorAttributes) {      
        return RouterFunctions.route(RequestPredicates.all(), this::renderErrorResponse); 
      }  

      /**    
      * 根据code获取对应的HttpStatus    
      *    
      * @param errorAttributes 
      */  
      @Override   
      protected int getHttpStatus(Map<String, Object> errorAttributes) {
        return 200;    
      }
    }
```

<img src="image/img2_1_8_4_3.png" style="zoom:50%;" />

```markdown
# 分布式配置【Spring Cloud Config（Nacos）】
	Nacos内容详见【1.9————Nacos————Nacos配置中心】

# 消息总线【Spring Cloud Bus（Nacos）】
	
```



### 5、调用接口过程

```markdown
# 名词解释
-- 消费者（调用者）
	1、接口化请求调用（创建服务接口）
	2、Feign（根据定义的服务名，找到服务接口进行调用）
	3、Hystrix（查看被调用服务是否正常启动，如果没有正常启动，则进行熔断）
	4、Ribbon
	5、HttpClient/OkHttp

-- 生产者（被调用者）

# 调用过程
	Feign-->Hystrix-->Ribbon-->Http Client(apache http components/Okhttp),详细过程如图:
```

<img src="image/img2_1_8_4_4.png" style="zoom:50%;" />

### 6、小版本划分

```markdown
SNAPSHOT————快照版本，随时可能修改

M(MileStone)————表示里程碑版本，一般同时标注PRE,表示预览版本

SR(Service Relese )————表示正式版本，一般同时标注GA
```



## 9、Nacos

```markdown
# 说明
	阿里巴巴推出的一个开源项目。Nacos=Spring Cloud Eureka + Spring Cloud Config。可与Spring、Spring Boot、Spring Cloud集成.并能替代它们两者，通过Nacos Server和spring-cloud-starter-alibaba-nacos-discovery实现服务的注册和发现.以服务为主要服务对象的中间件，支持所有主流的服务发现、配置和管理

# 主要提供功能
-- 服务发现和服务健检测
-- 动态配置服务
-- 动态DNS服务
-- 服务及其元数据管理

# 结构图
	如下所示:
```

<img src="image/img2_1_8_4_5.png" style="zoom:50%;" />

```markdown
# 下载安装
-- 下载
	地址:https://github.com/alibaba/nacos/releases(建议先进入github,再去搜索nacos下载)
	下载版本：nacos-server-1.1.4.tar.gz或nacos-server-1.1.4.zip,解压到任意目录即可
-- 启动
	windows————运行解压的【startup.cmd】
	mac————终端进入nacos的bin目录下,执行命令【./startup.sh -m standalone】
-- 终端测试是否启动成功
	终端执行命令————curl 127.0.0.1:8848/nacos
-- 访问
	浏览器访问地址————http://localhost:8848/nacos/#/login
	默认用户名和密码————【nacos/nacos】
-- 启动问题
	nacos单机模式报错
		错误内容————server is DOWN now, please try again later!
    解决方式————如下:
      #删除nacos目录下data/protocol目录
      cd nacos/data
      rm -rf protocol/
      #重新启动nacos服务
      sh startup.sh -m standalone &

# Nacos配置中心
-- 作用
	基于配置中心进行配置文件的统一管理

-- 相关依赖
	<!--nacos配置中心依赖-->       
  <dependency>      
    <groupId>org.springframework.cloud</groupId>  
    <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>    
  </dependency>
  
-- Spring Boot配置文件加载顺序
	1、先加载[bootstrap.yml(.properties)]
	2、后加载[application.yml(.properties)]
	3、如果application.yml中存在[spring.profiles.active=dev],就会接着去加载[application-dev.yml]
	
-- 实现过程
	1、调用服务中添加依赖[spring-cloud-starter-alibaba-nacos-config]
	2、在nacos配置管理的配置列表中添加配置
		-- Data ID:读取的配置文件名称
			1)名称规则
				第一部分:服务名
				第二部分:配置文件所使用的环境(不指定可省略)
				第三部分:文件类型扩展名
			2)完整格式
				${spring.application.name}-${spring.profiles.active}.${file.exetension}
		-- Group:默认组
		-- 配置格式:配置文件格式
		-- 配置内容:配置文件内容
	3、添加配置到配置文件[bootstrap.yml]
		#配置中心地址
		spring.cloud.nacos.config.server-addr=127.0.0.1:8848
		#通过这个环境去配置中心找对应配置
		#spring.profiles.active=dev
		#通过这个名字去配置中心找对应配置
		spring.application.name=staService

-- 名称空间切换环境
	1、实际开发包含的开发环境
		-- dev:开发环境
		-- test:测试环境
		-- prod:生产环境
	2、使用
    -- 在nacos中创建不同的名称空间
      public:默认名称空间
      dev:开发名称空间
      test:测试名称空间
      prod:生产名称空间
    -- 不同名称空间创建不同的配置文件
    -- 配置文件[bootstrap.yml]中追加内容
      #通过此设置去nacos配置中心找对应配置命名空间(值为创建出的不同名称空间对应的)
      spring.cloud.nacos.config.namespace=aa10b21c-9642-46c2-8422-7ea095ffe3c0

-- 多配置文件加载
 	1、创建不同的配置文件,用于设置不同的配置
 	2、修改配置文件[bootstrap.yml],加载nacos中的多个配置文件
 		#加载nacos配置中心的多个配置文件
 		##设置加载的配置文件名称
 		spring.cloud.nacos.config.ext-config[0].data-id=port.properties
 		##开启动态刷新配置，否则配置文件修改，工程无法感知
 		spring.cloud.nacos.config.ext-config[0].refresh=true
 		...
```



## 10、Redis

## 11、MD5加密

## 12、OAuth2

## 13、Canal数据同步工具

## 14、Spring Security权限框架

## 15、Git

## 16、Jenkins

## 17、Docker

## 18、JWT

# 二、第三方服务技术

## 1、阿里云oss

### 1、说明

```markdown
解决海量存储和弹性扩容
```

### 2、开通

```markdown
-- 打开阿里云网址：https://www.aliyun.com/
-- 注册阿里云账户，使用支付宝实名认证
-- 找到产品中的【对象存储OSS】
-- 点击立即开通
-- 进入管理控制台
-- 创建Bucket
```

### 3、java代码实现文件上传到阿里云oss

```markdown
# 创建阿里云oss许可证（阿里云提供id和秘钥）
-- 点击【Access key】进入页面，创建AccessKey

# 使用文档
-- 首页 > 对象存储 OSS > SDK 示例 > Java

# 引入依赖
<dependency>    
	<groupId>com.aliyun.oss</groupId>
	<artifactId>aliyun-sdk-oss</artifactId>
	<version>3.10.2</version>
</dependency>

# 使用
详见文档:https://help.aliyun.com/document_detail/32009.html?spm=a2c4g.11186623.6.919.54cd46a1Ly8vgk
```



## 2、阿里云视频点播服务

### 1、说明

```markdown
视频点播（ApsaraVideo VoD，简称VoD）是集视频采集、编辑、上传、媒体资源管理、自动化转码处理（窄带高清™）、视频审核分析、分发加速于一体的一站式音视频点播解决方案。
```

### 2、开通

```markdown
-- 打开阿里云网址：https://www.aliyun.com/<br>
-- 找到产品中的【视频服务】中的【视频点播】
-- 选择【按流量计费】开通
```

### 3、管理控制台使用

```markdown
# 媒资库
-- 音视频
	// 可以看到上传到阿里云的音视频文件
	// 可以进行音视频的上传
	// 每个视频会有一个ID和地址
-- 图片
	// 放视频的封面

# 配置管理
-- 存储管理
-- 分类管理
	// 可以自行进行分类
-- 媒体处理配置——转码模板组
	// 进行视频加密、转码
-- 域名管理
	// 不配域名，加密视频播放不了
```

### 4、java代码实现相关功能

```markdown
# 手册学习(https://help.aliyun.com/product/29932.html?spm=a2c4g.11186623.6.540.561c5186nBzfoC)
-- 服务端的API
	// 使用httpclient技术，调用api地址
	// 阿里云针对相关功能提供的固定地址，只需要向其传入指定参数即可，功能就能实现。不建议使用
-- 服务端的SDK
	// 底层是API，对API方式进行了封装，更方便使用。
	// 即调用提供的类或接口里面的方法实现功能
-- 上传的SDK(手动上传)
	// 阿里云官网下载SDK————VODUploadDemo-java-1.4.11.zip
	// 使用命令安装jar包所在目录进入终端执行以下命令

# aliyun-java-vod-upload-1.4.11.jar包所在目录进入cmd执行以下命令
mvn install:install-file -DgroupId=com.aliyun -DartifactId=aliyun-sdk-vod-upload -Dversion=1.4.11 -Dpackaging=jar -Dfile=aliyun-java-vod-upload-1.4.11.jar

# 引入相关依赖
-- 添加maven仓库
<repositories>
	<repository>
		<id>sonatype-nexus-staging</id>
		<name>SonatypeNexusStaging</name>				
		<url>https://oss.sonatype.org/service/local/staging/deploy/maven2/</url>
    <releases>
      <enabled>true</enabled>
    </releases>
    <snapshots>
      <enabled>true</enabled>
    </snapshots>
	</repository>
</repositories>

-- 添加Jar包依赖
<dependency>
  <groupId>com.aliyun</groupId>
  <artifactId>aliyun-java-sdk-core</artifactId>
  <version>4.5.1</version>
</dependency>
<dependency>
  <groupId>com.aliyun</groupId>
  <artifactId>aliyun-java-sdk-vod</artifactId>
  <version>2.15.11</version>
</dependency>
<dependency>
  <groupId>com.alibaba</groupId>
  <artifactId>fastjson</artifactId>
  <version>1.2.62</version>
</dependency>

# 初始化
	importcom.aliyuncs.profile.DefaultProfile;
  importcom.aliyuncs.DefaultAcsClient;
  importcom.aliyuncs.exceptions.ClientException;
  /**
	* 初始化操作
	*/
  public static DefaultAcsClientinitVodClient(String accessKeyId,String accessKeySecret)throws ClientException{
  	StringregionId="cn-shanghai";//点播服务接入区域                                                                                                 		DefaultProfile profile=DefaultProfile.getProfile(regionId,accessKeyId,accessKeySecret);
  	DefaultAcsClient client=new DefaultAcsClient(profile);
  	return client;                                                                                                                   	}

# 功能实现
-- 实现视频上传功能
  /**     
  * 实现文件上传
  *
  * @param file
  * @return
  */
  @Override
  public String uploadVideo(MultipartFile file) {
    try {
      //accessKeyId
      //accessKeySecret
      //fileName：上传文件原始名称
      String fileName = file.getOriginalFilename();
      //title：上传到阿里云显示的名称
      String title = fileName.substring(0, fileName.lastIndexOf("."));
      //InputStream:上传文件输入流
      InputStream stream = file.getInputStream();
      UploadStreamRequest request = new UploadStreamRequest(ConstantVodPropertiesUtils.ACCESS_KEY_ID, ConstantVodPropertiesUtils.ACCESS_KEY_SECRET, title, fileName, stream);
      UploadVideoImpl uploader = new UploadVideoImpl();
      UploadStreamResponse response = uploader.uploadStream(request);
      String videoId = null;
      if (response.isSuccess()) {
        videoId = response.getVideoId();
      } else {
        videoId = response.getVideoId();
      }            
      return videoId;
    } catch (IOException e) {
    	e.printStackTrace();            
    	return null;
    }
  }
  
-- 实现单个视频删除功能
  /**
  * 实现单个视频删除
  */
  @Override
  public void removeVideoById(String videoId) {
    try {
      //初始化对象
      DefaultAcsClient client = InitVodClient.initVodClient(ConstantVodPropertiesUtils.ACCESS_KEY_ID, ConstantVodPropertiesUtils.ACCESS_KEY_SECRET);
      //创建删除视频的request对象
      DeleteVideoRequest request = new DeleteVideoRequest();
      //设置被删除视频的id
      request.setVideoIds(videoId);
      //进行视频删除操作
      client.getAcsResponse(request);
    } catch (Exception e) {
      e.printStackTrace();
      throw new EduException(20001, "删除视频出现异常！");
    }
  }
  
-- 实现多个视频批量删除功能
  /**
  * 实现多个视频批量删除
  */
  @Override    
  public void removeMoreVideo(List<String> videoIdList) {
    try {
        //初始化对象
        DefaultAcsClient client = InitVodClient.initVodClient(ConstantVodPropertiesUtils.ACCESS_KEY_ID, ConstantVodPropertiesUtils.ACCESS_KEY_SECRET);
        //创建删除视频的request对象
        DeleteVideoRequest request = new DeleteVideoRequest();
        //设置被删除视频的id
        String str = StringUtils.join(videoIdList.toArray(), ",");
        request.setVideoIds(str);
        //进行视频删除操作
        client.getAcsResponse(request);
    } catch (Exception e) {
      e.printStackTrace();
      throw new EduException(20001, "删除视频出现异常！");        
    }
  }
```



## 3、阿里云视频播放器

### 1、文档地址

```markdown
https://help.aliyun.com/document_detail/61064.html
```

### 2、基本使用流程

```markdown
# 获取播放地址
  /**
  * 根据视频id获取视频播放地址（没有加密）     
  *
  * @param accessKeyId 
  * @param accessKeySecret 
  * @param id              上传到阿里云的视频ID     
  */
  public static void getVideoByID(String accessKeyId, String accessKeySecret, String id)
  throws ClientException {     
    //创建初始化对象       
    DefaultAcsClient defaultAcsClient = initVodClient(accessKeyId, accessKeySecret);    
    //获取视频地址request和response对象     
    GetPlayInfoRequest request = new GetPlayInfoRequest();    
    GetPlayInfoResponse response;    
    //向request对象中设置视频地址   
    request.setVideoId("1165a086b3914d93b54951836a8ce5c4");     
    //调用初始化对象中的方法传递request，获取视频相关数据        
    response = defaultAcsClient.getAcsResponse(request);
    //获取视频集合       
    List<GetPlayInfoResponse.PlayInfo> infoList = response.getPlayInfoList();    
    //获取视频播放地址        
    for (GetPlayInfoResponse.PlayInfo info : infoList) {      
      String playURL = info.getPlayURL(); 
      System.out.println("视频播放地址：" + playURL); 
    } 
    //获取视频名称   
    String title = response.getVideoBase().getTitle();       
    System.out.println("视频名称：" + title);    
  }

# 获取播放凭证
  /**
  * 获取播放凭证
  */
  @Override    
  public String getPlayAuth(String videoId) {  
    try {            
      DefaultAcsClient client = InitVodClient.initVodClient(ConstantVodPropertiesUtils.ACCESS_KEY_ID, ConstantVodPropertiesUtils.ACCESS_KEY_SECRET);      
      GetVideoPlayAuthRequest request = new GetVideoPlayAuthRequest();      
      request.setVideoId(videoId);    
      //设置播放凭证过期时间,默认为100秒,取值范围：[100,3000]。        
      request.setAuthInfoTimeout(3000L);       
      GetVideoPlayAuthResponse acsResponse = client.getAcsResponse(request); 
      return acsResponse.getPlayAuth();       
    } catch (Exception e) {            
      e.printStackTrace();  
      throw new EduException(20001, "获取播放凭证异常！");  
    }
  }

# 创建视频播放器(前端)
  <!-- 引入阿里云播放器需要的样式文件和js文件 -->
  <link rel="stylesheet" href="https://g.alicdn.com/de/prismplayer/2.8.1/skins/default/aliplayer-min.css" />
  <script charset="utf-8" type="text/javascript" src="https://g.alicdn.com/de/prismplayer/2.8.1/aliplayer-min.js"></script>
  <!-- 初始化视频播放器 -->
  <div class="prism-player" id="J_prismPlayer"></div>
    <script>    
    var player = new Aliplayer({    
      id: 'J_prismPlayer',
      width: '100%',
      // 是否打开网页自动播放     
      autoplay: false,   
      cover: 'http://liveroom-img.oss-cn-qingdao.aliyuncs.com/logo.png',    
      //播放配置(设置播放方式)      
      // 播放方式一：支持播放地址播放,此播放优先级最高，此种方式不能播放加密视频      
      // source: 'https://outin-ca32ebbbe067aaaa11ebaaed800163e1aa3b4a.oss-cn-shanghai.aliyuncs.com/sv/3f6fe692-17acd974570/3f6fe692-17acd974570.mp4?Expires=1627010386&OSSAccessKeyId=LTAI4FfD63zoqnm6ckiBFfXZ&Signature=BE50sgQ%2BC0t57%2FH92v7Qmlfa%2Fuc%3D', 
      // 播放方式二、阿里云播放器支持通过播放凭证自动换取播放地址进行播放，接入方式更为简单，且安全性更高。播放凭证默认时效为100秒（最大为3000秒），只能用于获取指定视频的播放地址，不能混用或重复使用。如果凭证过期则无法获取播放地址，需要重新获取凭证。  
      encryptType: '1',//如果播放加密视频，则需设置encryptType=1，非加密视频无需设置此项（加上也可以）     
      vid: '4c705cd5063546a895cc435sss4f292e1a9',//视频id      
      playauth: 'ca32ebbbe067aaaa11ebaaed800163e1aa3b4a==',//凭证    
    }, 
    function (player) {
    console.log('播放器创建好了。')  
    });
</script>
```

### 3、项目整合

```markdown
# 创建布局页面
<template>
<div class="guli-player">  
  <div class="head">   
    <a href="#" title="Pigskin@Study">  
      <img class="logo" src="~/assets/img/logo.png" lt="Pigskin@Study" />    
  </a>    
  </div>
  <div class="body"> 
    <div class="content"><nuxt /></div>
  </div>
  </div>
</template>
<script>export default {};</script>
<style>
  html,body {  height: 100%;}
</style>
<style scoped>
  .head {  
    height: 50px;
    position: absolute;
    top: 0;  
    left: 0; 
    width: 100%;
  }
  .head .logo {
    height: 50px;  margin-left: 10px;
  }
  .body {
    position: absolute;  
    top: 50px;
    left: 0;  
    right: 0;
    bottom: 0; 
    overflow: hidden;
  }
</style>

# 异步加载播放凭证 
layout: "video", //应用video布局  
asyncData({ params, error }) {    
if (params.vid)   
return vodApi.getPlayAuthByVideoId(params.vid).then((response) => { 
return {     
playAuth: response.data.playAuth,
vid: params.vid, 
};
});
},

# 页面加载完成执行视频播放请求
// 页面渲染之后执行  
mounted() {   
var player = new Aliplayer(  
{        
id: "J_prismPlayer", 
width: "100%",       
height: "500px",      
// 是否打开网页自动播放        
autoplay: false,       
cover: "http://liveroom-img.oss-cn-qingdao.aliyuncs.com/logo.png",  
//播放配置(设置播放方式)       
// 播放方式一：支持播放地址播放,此播放优先级最高，此种方式不能播放加密视频       
// source: 'https://outin-ca32ebbbe067aaaa11ebaaed800163e1aa3b4a.oss-cn-shanghai.aliyuncs.com/sv/3f6fe692-17acd974570/3f6fe692-17acd974570.mp4?Expires=1627010386&OSSAccessKeyId=LTAI4FfD63zoqnm6ckiBFfXZ&Signature=BE50sgQ%2BC0t57%2FH92v7Qmlfa%2Fuc%3D', 
// 播放方式二、阿里云播放器支持通过播放凭证自动换取播放地址进行播放，接入方式更为简单，且安全性更高。播放凭证默认时效为100秒（最大为3000秒），只能用于获取指定视频的播放地址，不能混用或重复使用。如果凭证过期则无法获取播放地址，需要重新获取凭证。 
encryptType: "1", //如果播放加密视频，则需设置encryptType=1，非加密视频无需设置此项（加上也可以）  
vid: this.vid, //视频id   
playauth: this.playAuth, //凭证    
}),      
function (player) {     
console.log("播放器创建成功");  
}   
); 
},

# 其他可选配置
// 以下可选设置
cover: 'http://guli.shop/photo/banner/1525939573202.jpg', // 封面
qualitySort: 'asc', // 清晰度排序
mediaType: 'video', // 返回音频还是视频
autoplay: false, // 自动播放
isLive: false, // 直播
rePlay: false, // 循环播放
preload: true,controlBarVisibility: 'hover', // 控制条的显示方式：鼠标悬停
useH5Prism: true, // 播放器类型：html5

# 加入播放组件,详见如下链接
https://player.alicdn.com/aliplayer/presentation/index.html?type=cover
```



## 4、阿里云短信服务

### 1、说明

```markdown
实现短信验证
```

### 2、开通

```markdown
-- 登录阿里云
-- 选择短信服务，免费开通
-- 国内消息
	// 模板管理
		用于显示内容设置
	// 签名管理


```

### 3、项目整合

```markdown
# 引入依赖
  <!--json转换工具-->
  <dependency>
  	<groupId>com.alibaba</groupId>
  	<artifactId>fastjson</artifactId>
  </dependency>]
  <!--阿里云操作核心依赖-->
  <dependency>
  	<groupId>com.aliyun</groupId>
 	 	<artifactId>aliyun-java-sdk-core</artifactId>        
  </dependency>

# 服务端代码实现
  /**     
  * 阿里云发送验证码
  *
  * @param hashMap   验证码哈希表
  * @param phoneCode 手机号
  * @return
  */
  @Override
  public boolean sendPhoneCode(HashMap<String, Object> hashMap, String phoneCode) {
    if (StringUtils.isEmpty(phoneCode)) return false;
    DefaultProfile profile = DefaultProfile.getProfile("default", ConstantPropertiesUtils.ACCESS_KEY_ID, ConstantPropertiesUtils.ACCESS_KEY_SECRET);
    DefaultAcsClient client = new DefaultAcsClient(profile);
    //设置参数
    CommonRequest request = new CommonRequest();
    //request.setProtocol(ProtocolType.HTTPS);
    //（固定参数）
    request.setMethod(MethodType.POST);//提交方式
    request.setDomain("dysmsapi.aliyuncs.com");//请求地址
    request.setVersion("2017-05-25");//版本号
    request.setAction("SendSms");//请求方法
    //发送相关参数
    request.putQueryParameter("PhoneNumbers", phoneCode);//手机号
    request.putQueryParameter("SignName", "Pigskin教育网站");//申请的阿里云签名名称
    request.putQueryParameter("TemplateCode", "");//申请的阿里云模板CODE
    request.putQueryParameter("TemplateParam", JSONObject.toJSONString(hashMap));//验证码
    //最终发送        
    try {            
    	CommonResponse response = client.getCommonResponse(request);
    	return response.getHttpResponse().isSuccess();
    } catch (ClientException e) {
    	e.printStackTrace();
    }
    return false;
  }

# Redis实现设定验证码有效时间
  -- 注入实现对redis操作的对象
  /**
  * 实现对redis操作
  */
  @Autowired
  private RedisTemplate<String, String> redisTemplate;
  
	-- 从Redis获取验证码（根据手机号），获取到直接返回
  String code = redisTemplate.opsForValue().get(phoneCode);
  
	-- 获取不到，就进行阿里云发送
  String random = RandomUtil.getFourBitRandom();
  HashMap<String, Object> hashMap = new HashMap<>();
  hashMap.put("code", random);        
  boolean b = msmService.sendPhoneCode(hashMap, phoneCode);
  
	-- 发送成功，将发送成功的短信验证码放到redis中(并设定有效时间五分钟)
  redisTemplate.opsForValue().set(phoneCode, random, 5, TimeUnit.MINUTES);
```



## 5、腾讯云短信服务

### 1、说明

```markdown
实现短信验证
```

### 2、Java SDK文档地址

```markdown
https://cloud.tencent.com/document/product/382/43194
```

### 3、开通过程

```markdown
和阿里云类似
```

### 4、项目整合

```markdown
# 引入依赖
  <!--腾讯云操作依赖-->        
  <dependency>
 	 	<groupId>com.tencentcloudapi</groupId>
  	<artifactId>tencentcloud-sdk-java</artifactId>
  	<version>3.1.270</version>
  	<!-- 注：这里只是示例版本号（可直接使用），可获取并替换为 最新的版本号，注意不要使用4.0.x版本（非最新版本） -->
  </dependency>
  
# 服务端代码实现
  import com.tencentcloudapi.common.Credential;
  import com.tencentcloudapi.common.exception.TencentCloudSDKException;
  import com.tencentcloudapi.common.profile.ClientProfile;
  import com.tencentcloudapi.common.profile.HttpProfile;
  import com.tencentcloudapi.sms.v20210111.SmsClient;
  import com.tencentcloudapi.sms.v20210111.models.SendSmsRequest;
  
  /**     
  * 腾讯云发送验证码     
  *     
  * @param code   验证码
  * @param mobile 手机号
  * @return     
  */    
  @Override
  public boolean sendPhoneCodeByTencentyun(String code, String mobile) {
  	if (StringUtils.isEmpty(mobile)) return false;
    try {
      //实例化认证对象
      Credential cred = new Credential(ConstantPropertiesUtils.TX_ACCESS_KEY_ID, ConstantPropertiesUtils.TX_ACCESS_KEY_SECRET);
      //实例化Http对象
      HttpProfile httpProfile = new HttpProfile();
      //设置站点域名
      httpProfile.setEndpoint(ConstantPropertiesUtils.TX_END_POINT);
      //实例化客户端配置对象
      ClientProfile clientProfile = new ClientProfile();
      clientProfile.setHttpProfile(httpProfile);
      //实例化sms的client对象(第二个参数是地域信息) 
      SmsClient client = new SmsClient(cred, "ap-guangzhou", clientProfile); 
      SendSmsRequest req = new SendSmsRequest();
      //设置下发手机号码  
      String[] phoneNumberSet = {"+86" + mobile};
      req.setPhoneNumberSet(phoneNumberSet);
      //签名ID 
      req.setSmsSdkAppId(ConstantPropertiesUtils.TX_SDK_APP_ID);
      //签名
      req.setSignName(ConstantPropertiesUtils.TX_SIGN_NAME); 
      //模板ID
      req.setTemplateId(ConstantPropertiesUtils.TX_TEMPLATE_ID); 
      //模板参数(验证码，有效时间)
      String[] templateParamSet = {code, "1"};
      req.setTemplateParamSet(templateParamSet);
      client.SendSms(req); 
    } catch (TencentCloudSDKException e) {
      throw new EduException(20001, e.getMessage());  
    }
    return true;
  }

# 验证码接口防刷及再次校验[存到Redis]
  -- 引入redis依赖
  <!--引入redis-->
  <dependency>
 	 	<groupId>org.springframework.boot</groupId>
  	<artifactId>spring-boot-starter-data-redis</artifactId>
  	<version>2.1.8.RELEASE</version>
  </dependency>
  
  -- 配置redis
  #redis相关配置
  spring.redis.host=192.168.56.101
  spring.redis.port=6379
  
  -- 注入对象
  @Autowired    
  private StringRedisTemplate redisTemplate;
  
  -- 使用
  /*TODO:1、接口防刷*/
  String redisCode = redisTemplate.opsForValue().get(AuthConstant.SMS_CODE_CACHE_PREFIX + phone);
  if (!StringUtils.isEmpty(redisCode)) {
    long parseLong = Long.parseLong(redisCode.split("_")[1]); 
    /*根据当前系统时间减去上次该手机号记录的发送验证码的系统时间是否小于60秒，决定是否重新发送验证码*/   
    if (System.currentTimeMillis() - parseLong < 60000) { 
    	//60秒内不能再发送 
   	 	return R.error(BizCodeEnum.SMS_CODE_EXCEPTION.getCode(), BizCodeEnum.SMS_CODE_EXCEPTION.getMsg());  
    }
  }
  /*TODO:2、验证码再次校验，存，key:手机号，value：验证码*/ 
  String code = String.valueOf((int) (Math.random() * 9 + 1) * 1000);        
  String setRedisCode = code + "_" + System.currentTimeMillis();
  /*redis缓存验证码*/   
  redisTemplate.opsForValue().set(AuthConstant.SMS_CODE_CACHE_PREFIX + phone, setRedisCode, 10, TimeUnit.MINUTES);        
  thirdPartFeignService.sendCode(phone, code);
  return R.ok();
```

## 6、微信登录（注册）实现

### 1、准备工作

```markdown
-- 注册开发者资质(仅支持企业,注册后提供微信ID和密钥)
https://open.weixin.qq.com/
-- 申请网站应用名称
-- 需要域名地址
```

### 2、开发过程

```markdown
-- https://developers.weixin.qq.com/doc/oplatform/Website_App/WeChat_Login/Wechat_Login.html
-- 如图所示:
```

<img src="image/img2_2_6_2_1.png" style="zoom:50%;" />

### 3、后端功能实现

```markdown
# 配置文件添加配置
  #微信开放平台 app_id    
  wx.open.app_id=wxed9954c01bb89b47    
  #微信开放平台 app_secret    		
  wx.open.app_secret=a7482517235173ddb4083788de60b90e    
  #微信开放平台 重定向url    
  wx.open.redirect_url=http://guli.shop/api/ucenter/wx/callback

# 创建用于读取配置文件内容的类
  package com.pigskin.ucenter.utils;
	import io.swagger.annotations.ApiModelProperty;
	import org.springframework.beans.factory.InitializingBean;
	import org.springframework.beans.factory.annotation.Value;
	import org.springframework.stereotype.Component;
  /**     
  * 用于获取微信登录相关配置信息
  */
  @Component
  public class ConstantWxUtils implements InitializingBean {
    @ApiModelProperty("appId")
    @Value("${wx.open.app_id}")
    private String appId;
    @ApiModelProperty("appSecret")
    @Value("${wx.open.app_secret}")
    private String appSecret;
    @ApiModelProperty("redirectUrl")
    @Value("${wx.open.redirect_url}")
    private String redirectUrl;
    public static String WX_OPEN_APP_ID;
    public static String WX_OPEN_APP_SECRET;
    public static String WX_OPEN_REDIRECT_URL;
    @Override
    public void afterPropertiesSet() throws Exception {
      WX_OPEN_APP_ID = this.appId;
      WX_OPEN_APP_SECRET = this.appSecret;
      WX_OPEN_REDIRECT_URL = this.redirectUrl;
    }
  }
  
# 生成微信扫描的二维码
  @Api(description = "微信登录相关操作接口")
  @Controller
  @RequestMapping("/uCenterService/weChartApi")
  @CrossOrigin
  public class WxApiController {
    @ApiOperation(value = "生成微信登录二维码")  
    @GetMapping("getWxCode")  
    public String getWxCode() {
      //https://open.weixin.qq.com/connect/qrconnect?appid=APPID&redirect_uri=REDIRECT_URI&response_type=code&scope=SCOPE&state=STATE#wechat_redirect
      //生成微信二维码的重定向基础地址字符串            
      String baseUrl = "https://open.weixin.qq.com/connect/qrconnect" + 
        "?appid=%s" +                    
        "&redirect_uri=%s" +            
        "&response_type=code" +     
        "&scope=snsapi_login" +       
        "&state=%s" +                 
        "#wechat_redirect";        
      //对redirect_url进行URLEncode编码   
      String redirectUrl = ConstantWxUtils.WX_OPEN_REDIRECT_URL;       
      try {               
        redirectUrl = URLEncoder.encode(redirectUrl, "utf-8");     
      } catch (UnsupportedEncodingException e) {     
        throw new EduException(20001, "编码转换异常");        
      }          
      //占位符替换       
      String url = String.format(    
        baseUrl,                   
        ConstantWxUtils.WX_OPEN_APP_ID,   
        redirectUrl,                  
        "atguigu"           
      );           
      //重定向到请求的微信地址     
      return "redirect:" + url;      
    }    
  }
# 当扫描该二维码后,会重定向到设定的地址，并带出两个值（status,code）
  -- 为测试准备
  // 将本地服务端口号改成8150
  // 回调接口地址和域名跳转地址写成一样
  
  -- 会执行本地的callback方法，在callback中获取两个值，在跳转的时候传递过来,代码示例如下
  /**
  * 获取扫码人信息，添加数据  
  *
  * @param code  获取到的code值（临时票据），类似于验证码   
  * @param state 原样传递值（作用不大）    
  * @return
  */
  @ApiOperation(value = "获取扫码人信息，添加数据") 
  @GetMapping("callback")
  public String callback(String code, String state) { 
  	// 代码后续操作请查看下一步...
  }
  
  -- 拿着上一步的code,请求微信提供固定的地址，获取到两个值（access_token、openid）
    // 代码实现
    //1、使用code创建微信固定请求地址   
    String baseAccessTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token" +   
    "?appid=%s" + 
    "&secret=%s" +  
    "&code=%s" +  
    "&grant_type=authorization_code";
    String accessTokenUrl = String.format(  
      baseAccessTokenUrl,  
      ConstantWxUtils.WX_OPEN_APP_ID,   
      ConstantWxUtils.WX_OPEN_APP_SECRET,     
      code 
    );
    //2、使用httpClient发送请求，获取到accessToken和openId  
    String accessTokenInfo = HttpClientUtils.get(accessTokenUrl);     
    //3、将从请求的到的Json字符串使用Gson转换成map集合，从中获取accessToken和openId 
    String access_token = "";     
    String openid = "";  
    if (!StringUtils.isEmpty(accessTokenInfo)) {     
      Gson gson = new Gson();       
      HashMap mapAccessToken = gson.fromJson(accessTokenInfo, HashMap.class);      
      access_token = mapAccessToken.get("access_token").toString();      
      openid = mapAccessToken.get("openid").toString();    
    }
    // 响应结果示例
    accessTokenInfo:
    {
      /*访问凭证*/
      "access_token":"31_asdaslgk566asdw84sdf656asdas",
      /*凭证过期时间*/
      "expires_in":7200,
      /*刷新之后生成的新的凭证*/
      "refresh_token":"31_adkldfjglASDFVLFK2545AD",
      /*微信ID*/
      "openid":"o3_asdfvgd65sdv",
      /*作用范围*/
      "scope":"snspi_login",
      /*作用单元*/
      "unionid":"asdg2asde2ad"
    }
	-- 根据openid查看表中是否已包含相同微信信息，没有的话进行第7步获取用户信息添加到数据库
	
  -- 拿着上上一步获取到的两个值，再去请求微信提供固定地址，获取到微信扫码人信息（openid、nickName、sex、heardimgurl）
    // 代码实现
    //4、使用获取到accessToken和openId，去请求另一个地址，获取到用户信息   
    String baseUserInfoUrl = "https://api.weixin.qq.com/sns/userinfo" +  
    "?access_token=%s" +                    
    "&openid=%s";              
    String userInfoUrl = String.format(baseUserInfoUrl, access_token, openid);              
    //5、发送请求(获取扫码人信息)            
    String userInfo = HttpClientUtils.get(userInfoUrl);    
    //todo:gson使用详见主流技术中Gson
    HashMap userInfoMap = gson.fromJson(userInfo, HashMap.class);   
    //昵称              
    String nickName = userInfoMap.get("nickName").toString();     
    //性别              
    int sex = Integer.parseInt(userInfoMap.get("sex").toString());           
    //头像              
    String headimgurl = userInfoMap.get("headimgurl").toString();
    // 响应结果示例
    userInfo:
    {
      /*微信ID*/
      "openid":"o3_asdfvgd65sdv",
      /*微信昵称*/         
      "nickName":"哈哈",
      /*性别*/
      "sex":1,
      /*语言*/
      "language":"zh_CN",
      /*城市*/
      "city":"",
      /*省份*/
      "province":"",
      /*国家*/
      "country":"CN",
      /*微信头像（路径中有转义）*/
      "headimgurl":"http:\/\/thsdmkpokfpalds"
        "privilege":[],
      /*作用单元*/
      "unionid":"asdg2asde2ad"
      
    -- 将用户信息显示到主页面
      // 方式一:
      将扫码之后的信息放到cookie中，跳转到首页进行显示

      存在问题：cookie无法实现跨域访问
      // 方式二:
      根据微信信息，使用jwt生成token字符串，将token字符串通过路径传递到首页面

      代码实现
      /*使用jwt根据member生成token字符串*/
      String token = JwtUtils.getJwtToken(member.getId(), member.getNickname());
      return "redirect:http://localhost:3000?token=" + token;
```

### 4、前端代码实现

```markdown
# 在首页路径中有token字符串
created() {    
  //获取路径中的token值    
  this.token = this.$route.query.token;
  if (this.token) {   
  	this.wxLogin();
  }
}
# 获取token值，放到cookie中
//微信登录显示的方法    
wxLogin() { 
  // 将token值放到cookie中
  cookie.set("edu_token", this.token, { domain: "localhost" }); 
  //调用接口，根据token值获取用户信息     
  loginApi.getLoginUserInfo().then((response) => {     
    this.loginInfo = response.data.member;
    //将用户信息记录到cookie   
    cookie.set("edu_ucenter", this.loginInfo, { domain: "localhost" });   
  });
},	
# 调用后端接口，根据token值获取用户信息
	把获取出来的用户信息放到cookie中
```



## 7、微信支付

### 1、后端

```markdown
# 准备工作
  微信支付id/商户号/商户key

# 引入相关依赖
  <!--微信支付依赖-->       
  <dependency>
  	<groupId>com.github.wxpay</groupId>    
  	<artifactId>wxpay-sdk</artifactId>     
  	<version>0.0.3</version>  
  </dependency>  
  <!--json转换-->    
  <dependency>      
	  <groupId>com.alibaba</groupId>     
  	<artifactId>fastjson</artifactId> 
  </dependency>
  
# 创建生成微信支付二维码接口
  @Override    
  public Map<String, Object> createNative(String orderNo) {     
    try {
      //1、获取订单信息     
      QueryWrapper<Order> wrapper = new QueryWrapper<>();   
      wrapper.eq("order_no", orderNo);      
      Order orderInfo = orderService.getOne(wrapper);      
      //2、设置支付所需参数        
      Map m = new HashMap();        
      m.put("appid", ConstantPropertiesUtils.APP_ID);//微信id          
      m.put("mch_id", ConstantPropertiesUtils.PARTNER);//商户号        
      m.put("nonce_str", WXPayUtil.generateNonceStr());//生成的随机字符串，确保生成的二维码每次都不相同    
      m.put("body", orderInfo.getCourseTitle());//生成二维码显示的名称       
      m.put("out_trade_no", orderNo);//二维码唯一标识（一般填写订单号）        
      m.put("total_fee", orderInfo.getTotalFee().multiply(new BigDecimal("100")).longValue() + "");//二维码汇总订单的价格      
      m.put("spbill_create_ip", "127.0.0.1");//进行支付的ip地址(域名)     
      m.put("notify_url", ConstantPropertiesUtils.NOTIFY_URL + "\n");//支付成功后的回调地址  
      m.put("trade_type", ConstantPropertiesUtils.TRADE_TYPE);//生成二维码的支付类型（NATIVE:根据价格生成二维码）
      //3、发送HTTPClient请求，传递xml格式参数，微信支付提供的固定地址      
      HttpClient client = new HttpClient(ConstantPropertiesUtils.CLIENT_URL);     
      //client设置参数（map集合，商户key）    
      client.setXmlParam(WXPayUtil.generateSignedXml(m, ConstantPropertiesUtils.PARTNER_KEY));      
      //支持https访问  
      client.setHttps(true);     
      //发送post请求     
      client.post();  
      //4、返回第三方的数据（返回的内容是xml格式）     
      String xml = client.getContent();
      //将xml转换成map集合        
      Map<String, String> resultMap = WXPayUtil.xmlToMap(xml);         
      //5、封装返回结果集     
      Map map = new HashMap<>();      
      map.put("out_trade_no", orderNo);   
      map.put("course_id", orderInfo.getCourseId());        
      map.put("total_fee", orderInfo.getTotalFee());        
      map.put("result_code", resultMap.get("result_code"));     
      map.put("code_url", resultMap.get("code_url"));      
      //微信支付二维码2小时过期，可采取2小时未支付取消订单       
      //redisTemplate.opsForValue().set(orderNo, map, 120, TimeUnit.MINUTES);     
      return map;   
    } catch (Exception e) {
      throw new EduException(20001, "获取支付信息失败！");        
    }
	}

# 创建查询订单支付状态接口
  @Override   
  public void updateOrdersStatus(Map<String, String> map) {     
    //获取订单id  
    String orderNo = map.get("out_trade_no");    
    //根据订单编号查询订单信息   
    QueryWrapper<Order> wrapper = new QueryWrapper<>();      
    wrapper.eq("order_no", orderNo);   
    Order order = orderService.getOne(wrapper);   
    //更新订单表订单状态       
    if (order.getStatus().intValue() == 1) {//已经支付    
      return;     
    }       
    //修改支付状态为已修改   
    order.setStatus(1);       
    orderService.updateById(order);      
    //向支付表中添加支付记录 
    PayLog payLog = new PayLog();    
    payLog.setOrderNo(order.getOrderNo());//支付订单号 
    payLog.setPayTime(new Date());//订单完成时间    
    payLog.setPayType(1);//支付类型        
    payLog.setTotalFee(order.getTotalFee());//总金额(分)     
    payLog.setTradeState(map.get("trade_state"));//支付状态      
    payLog.setTransactionId(map.get("transaction_id"));//订单流水号      
    payLog.setAttr(JSONObject.toJSONString(map));//其他属性     
    baseMapper.insert(payLog);   
  }
  
# 根据返回的查询状态进行后续操作
  //获取订单的支付状态       
  String trade_state = map.get("trade_state");    
  if (trade_state.equals("SUCCESS")) {//支付成功    
    //添加支付记录到支付表，更新订单表订单状态           
    payLogService.updateOrdersStatus(map);     
    return R.ok().message("支付成功");      
  }       
  return R.ok().code(25000).message("支付中");
```

2、前端

```markdown
# 安装插件
npm install vue-qriously

# 设置拦截器
// response 拦截器
service.interceptors.response.use(response => {    
  /**     
  * code为非20000是抛错 可结合自己业务进行修改     
  */
  const res = response.data    
  if (res.code === 28004) {
    // 返回 错误代码-1 清除 ticket信息并跳转到登录界面     
    window.location.href = "/login"    
    return
  } else if (res.code !== 20000) {  
    if (res.code != 25000) {//订单支付中不做任何提示   
      Message({ 
        message: res.message || 'error',     
        type: 'error',  
        duration: 5 * 1000    
      })
      // 50008:非法的token; 50012:其他客户端登录了;  50014:Token 过期了; 
      if (res.code === 50008 || res.code === 50012 || res.code === 50014) {       
        MessageBox.confirm(    
          '你已被登出，可以取消继续留在该页面，或者重新登录',       
          '确定登出',    
          {
          confirmButtonText: '重新登录',      
          cancelButtonText: '取消',     
          type: 'warning' 
          }
        ).then(() => { 
          store.dispatch('FedLogOut').then(() => { 
            location.reload() // 为了重新实例化vue-router对象 避免bug   
          })          
        })
      }
      return Promise.reject('error')
    } else {  
      return response.data      
    } 
  } else {   
    return response.data
  }
},  
error => {   
  console.log('err' + error) // for debug  
  Message({      
    message: error.message,  
    type: 'error',     
    duration: 5 * 1000   
  })   
  return Promise.reject(error)  
})

# 展示付款码
<template> 
  <div class="cart py-container">  
    <!--主内容-->   
    <div class="checkout py-container pay">  
      <div class="checkout-tit">      
        <h4 class="fl tit-txt">     
          <span class="success-icon"></span>
          <span class="success-info">订单提交成功，请您及时付款！订单号：{{ payObj.out_trade_no }}</span>     
        </h4>    
        <span class="fr">
          <em class="sui-lead">应付金额：</em>
          <em class="orange money">￥{{ payObj.total_fee }}</em>
        </span>       
        <div class="clearfix"></div>    
      </div>     
      <div class="checkout-steps">    
        <div class="fl weixin">微信支付</div>  
          <div class="fl sao">        
            <p class="red">请使用微信扫一扫。</p> 
            <div class="fl code">    
              <!-- <img id="qrious" src="~/assets/img/erweima.png" alt=""> --> 
              <!-- <qriously value="weixin://wxpay/bizpayurl?pr=R7tnDpZ" :size="338"/> -->  
              <qriously :value="payObj.code_url" :size="338" />   
              <div class="saosao">            
              <p>请使用微信扫一扫</p>            
              <p>扫描二维码支付</p>         
            </div>         
          </div>      
        </div>      
        <div class="clearfix"></div>   
        <!-- <p><a href="pay.html" target="_blank">> 其他支付方式</a></p> -->   
 			</div>   
  	</div> 
	</div>
</template>

# 进行定时器查询支付状态
<script>
  import orderApi from "@/api/order";
  export default {  
    asyncData({ params, error }) {  
      return orderApi.createNative(params.pid).then((response) => {  
        return { payObj: response.data.map };  
      }); 
    }, 
    data() { 
      return {   
        timer: "",   
      };  
    }, 
    mounted() { 
      //创建订单支付状态查询定时器，每三秒查一次    
      this.timer = setInterval(() => {  
        this.queryOrderStatus(this.payObj.out_trade_no); 
      }, 3000);  
    }, 
    methods: {   
      // 查询订单支付状态   
      queryOrderStatus(orderNo) {  
        orderApi.queryStatus(orderNo).then((response) => {  
          console.log(response);      
          if (response.success) {     
            // 清除定时器      
            clearInterval(this.timer);       
            // 支付结果提示         
            this.$message({       
              type: "success",          
              message: "支付成功！",     
            });         
            // 跳转到课程详情页面      
            this.$router.push({ path: "/course/" + this.payObj.course_id });   
          }   
        });  
      }, 
    },
  };
</script>
```



## 8、HTTPClient

### 1、说明

```markdown
不需要浏览器，也能模拟浏览器发送请求和得到数据过程,多用于安卓和IOS
```

### 2、使用

```markdown
# 引入依赖
<!--httpClient相关依赖-->
<dependency>
		<groupId>org.apache.httpcomponents</groupId>
		<artifactId>httpclient</artifactId>
</dependency>
<!--commons-io-->
<dependency>
		<groupId>commons-io</groupId>
		<artifactId>commons-io</artifactId>
</dependency>

# 编写工具类代码(调用其中方法，实现get/post请求)
	-- 依赖的jar包
		common-lang-2.6.jar
		httpclient-4.3.2.jar
		httpcore-4.3.1.jar
		commons-io-2.4.jar
	-- 代码实现
  	package com.pigskin.ucenter.utils;
    
    import org.apache.commons.io.IOUtils;
    import org.apache.commons.lang.StringUtils;
    import org.apache.http.Consts;
    import org.apache.http.HttpEntity;
    import org.apache.http.HttpResponse;
    import org.apache.http.NameValuePair;
    import org.apache.http.client.HttpClient;
    import org.apache.http.client.config.RequestConfig;
    import org.apache.http.client.config.RequestConfig.Builder;
    import org.apache.http.client.entity.UrlEncodedFormEntity;
    import org.apache.http.client.methods.HttpGet;
    import org.apache.http.client.methods.HttpPost;
    import org.apache.http.conn.ConnectTimeoutException;
    import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
    import org.apache.http.conn.ssl.SSLContextBuilder;
    import org.apache.http.conn.ssl.TrustStrategy;
    import org.apache.http.conn.ssl.X509HostnameVerifier;
    import org.apache.http.entity.ContentType;
    import org.apache.http.entity.StringEntity;
    import org.apache.http.impl.client.CloseableHttpClient;
    import org.apache.http.impl.client.HttpClients;
    import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
    import org.apache.http.message.BasicNameValuePair;

    import javax.net.ssl.SSLContext;
    import javax.net.ssl.SSLException;
    import javax.net.ssl.SSLSession;
    import javax.net.ssl.SSLSocket;
    import java.io.IOException;
    import java.net.SocketTimeoutException;
    import java.security.GeneralSecurityException;
    import java.security.cert.CertificateException;
    import java.security.cert.X509Certificate;
    import java.util.ArrayList;
    import java.util.List;
    import java.util.Map;
    import java.util.Map.Entry;
    import java.util.Set;

    /**
    * 实现HttpClient技术
    */
    public class HttpClientUtils {

      public static final int connTimeout = 10000;
      public static final int readTimeout = 10000;
      public static final String charset = "UTF-8";
      private static HttpClient client = null;

      static {
        PoolingHttpClientConnectionManager cm = new PoolingHttpClientConnectionManager();
        cm.setMaxTotal(128);
        cm.setDefaultMaxPerRoute(128);
        client = HttpClients.custom().setConnectionManager(cm).build();
      }

      public static String postParameters(String url, String parameterStr) throws ConnectTimeoutException, SocketTimeoutException, Exception {
        return post(url, parameterStr, "application/x-www-form-urlencoded", charset, connTimeout, readTimeout);
      }

      public static String postParameters(String url, String parameterStr, String charset, Integer connTimeout, Integer readTimeout) throws ConnectTimeoutException, SocketTimeoutException, Exception {
        return post(url, parameterStr, "application/x-www-form-urlencoded", charset, connTimeout, readTimeout);
      }

      public static String postParameters(String url, Map<String, String> params) throws ConnectTimeoutException,
      SocketTimeoutException, Exception {
        return postForm(url, params, null, connTimeout, readTimeout);
      }

      public static String postParameters(String url, Map<String, String> params, Integer connTimeout, Integer readTimeout) throws ConnectTimeoutException,
      SocketTimeoutException, Exception {
        return postForm(url, params, null, connTimeout, readTimeout);
      }

      public static String get(String url) throws Exception {
        return get(url, charset, null, null);
      }

      public static String get(String url, String charset) throws Exception {
        return get(url, charset, connTimeout, readTimeout);
      }

      /**
      * 发送一个 Post 请求, 使用指定的字符集编码.
      *
      * @param url
      * @param body        RequestBody
      * @param mimeType    例如 application/xml "application/x-www-form-urlencoded" a=1&b=2&c=3
      * @param charset     编码
      * @param connTimeout 建立链接超时时间,毫秒.
      * @param readTimeout 响应超时时间,毫秒.
      * @return ResponseBody, 使用指定的字符集编码.
      * @throws ConnectTimeoutException 建立链接超时异常
      * @throws SocketTimeoutException  响应超时
      * @throws Exception
      */
      public static String post(String url, String body, String mimeType, String charset, Integer connTimeout, Integer readTimeout)throws ConnectTimeoutException, SocketTimeoutException, Exception {
        HttpClient client = null;
        HttpPost post = new HttpPost(url);
        String result = "";
        try {
          if (StringUtils.isNotBlank(body)) {
            HttpEntity entity = new StringEntity(body, ContentType.create(mimeType, charset));
            post.setEntity(entity);
          }
          // 设置参数
          Builder customReqConf = RequestConfig.custom();
          if (connTimeout != null) {
            customReqConf.setConnectTimeout(connTimeout);
          }
          if (readTimeout != null) {
            customReqConf.setSocketTimeout(readTimeout);
          }
          post.setConfig(customReqConf.build());

          HttpResponse res;
          if (url.startsWith("https")) {
            // 执行 Https 请求.
            client = createSSLInsecureClient();
            res = client.execute(post);
          } else {
            // 执行 Http 请求.
            client = HttpClientUtils.client;
            res = client.execute(post);
          }
          result = IOUtils.toString(res.getEntity().getContent(), charset);
        } finally {
          post.releaseConnection();
          if (url.startsWith("https") && client != null && client instanceof CloseableHttpClient) {
            ((CloseableHttpClient) client).close();
          }
        }
        return result;
      }


      /**
      * 提交form表单
      *
      * @param url
      * @param params
      * @param connTimeout
      * @param readTimeout
      * @return
      * @throws ConnectTimeoutException
      * @throws SocketTimeoutException
      * @throws Exception
      */
      public static String postForm(String url, Map<String, String> params, Map<String, String> headers, Integer connTimeout, Integer readTimeout) throws ConnectTimeoutException,SocketTimeoutException, Exception {
        HttpClient client = null;
        HttpPost post = new HttpPost(url);
        try {
          if (params != null && !params.isEmpty()) {
            List<NameValuePair> formParams = new ArrayList<NameValuePair>();
            Set<Entry<String, String>> entrySet = params.entrySet();
            for (Entry<String, String> entry : entrySet) {
              formParams.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
            }
            UrlEncodedFormEntity entity = new UrlEncodedFormEntity(formParams, Consts.UTF_8);
            post.setEntity(entity);
          }

          if (headers != null && !headers.isEmpty()) {
            for (Entry<String, String> entry : headers.entrySet()) {
              post.addHeader(entry.getKey(), entry.getValue());
            }
          }
          // 设置参数
          Builder customReqConf = RequestConfig.custom();
          if (connTimeout != null) {
            customReqConf.setConnectTimeout(connTimeout);
          }
          if (readTimeout != null) {
            customReqConf.setSocketTimeout(readTimeout);
          }
          post.setConfig(customReqConf.build());
          HttpResponse res = null;
          if (url.startsWith("https")) {
            // 执行 Https 请求.
            client = createSSLInsecureClient();
            res = client.execute(post);
          } else {
            // 执行 Http 请求.
            client = HttpClientUtils.client;
            res = client.execute(post);
          }
          return IOUtils.toString(res.getEntity().getContent(), "UTF-8");
        } finally {
          post.releaseConnection();
          if (url.startsWith("https") && client != null&& client instanceof CloseableHttpClient) {
            ((CloseableHttpClient) client).close();
          }
        }
      }


      /**
      * 发送一个 GET 请求
      *
      * @param url         请求地址
      * @param charset     编码格式
      * @param connTimeout 建立链接超时时间,毫秒.
      * @param readTimeout 响应超时时间,毫秒.
      * @return
      * @throws ConnectTimeoutException 建立链接超时
      * @throws SocketTimeoutException  响应超时
      * @throws Exception
      */
      public static String get(String url, String charset, Integer connTimeout, Integer readTimeout)
      throws ConnectTimeoutException, SocketTimeoutException, Exception {
        HttpClient client = null;
        HttpGet get = new HttpGet(url);
        String result = "";
        try {
          // 设置参数
          Builder customReqConf = RequestConfig.custom();
          if (connTimeout != null) {
            customReqConf.setConnectTimeout(connTimeout);
          }
          if (readTimeout != null) {
            customReqConf.setSocketTimeout(readTimeout);
          }
          get.setConfig(customReqConf.build());

          HttpResponse res = null;

          if (url.startsWith("https")) {
            // 执行 Https 请求.
            client = createSSLInsecureClient();
            res = client.execute(get);
          } else {
            // 执行 Http 请求.
            client = HttpClientUtils.client;
            res = client.execute(get);
          }
          result = IOUtils.toString(res.getEntity().getContent(), charset);
        } finally {
          get.releaseConnection();
          if (url.startsWith("https") && client != null && client instanceof CloseableHttpClient) {
            ((CloseableHttpClient) client).close();
          }
        }
        return result;
      }


      /**
      * 从 response 里获取 charset
      *
      * @param ressponse
      * @return
      */
      @SuppressWarnings("unused")
      private static String getCharsetFromResponse(HttpResponse ressponse) {
        // Content-Type:text/html; charset=GBK
        if (ressponse.getEntity() != null && ressponse.getEntity().getContentType() != null && ressponse.getEntity().getContentType().getValue() != null) {
          String contentType = ressponse.getEntity().getContentType().getValue();
          if (contentType.contains("charset=")) {
            return contentType.substring(contentType.indexOf("charset=") + 8);
          }
        }
        return null;
      }


      /**
      * 创建 SSL连接
      *
      * @return
      * @throws GeneralSecurityException
      */
      private static CloseableHttpClient createSSLInsecureClient() throws GeneralSecurityException {
        try {
          SSLContext sslContext = new SSLContextBuilder().loadTrustMaterial(null, new TrustStrategy() {
            public boolean isTrusted(X509Certificate[] chain, String authType) throws CertificateException {
              return true;
            }
          }).build();

         SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslContext, new X509HostnameVerifier(){

            @Override
            public boolean verify(String arg0, SSLSession arg1) {
              return true;
            }

            @Override
            public void verify(String host, SSLSocket ssl)throws IOException {
            }

            @Override
            public void verify(String host, X509Certificate cert)throws SSLException {
            }

            @Override
            public void verify(String host, String[] cns,String[] subjectAlts) throws SSLException {
            }

          });

          return HttpClients.custom().setSSLSocketFactory(sslsf).build();
        } catch (GeneralSecurityException e) {
          throw e;
        }
      }

      /**
      * 使用测试
      */
      public static void main(String[] args) {
        try {
          String str = post("https://localhost:443/ssl/test.shtml", "name=12&page=34", "application/x-www-form-urlencoded", "UTF-8", 10000, 10000);
          //String str= get("https://localhost:443/ssl/test.shtml?name=12&page=34","GBK");
          /*Map<String,String> map = new HashMap<String,String>();
          map.put("name", "111");
          map.put("page", "222");
          String str= postForm("https://localhost:443/ssl/test.shtml",map,null, 10000, 10000);*/
          System.out.println(str);
        } catch (ConnectTimeoutException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        } catch (SocketTimeoutException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        } catch (Exception e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }
      }
		}
```



```java

```



# 三、开发经验

## 1、开发模式

### 1、前后端分离

```markdown
-- 前端
	作用：数据展示
	ajax异步请求操作，调用接口
-- 后端
	作用：操作数据/返回数据（json）
	接口开发：开发controller\service\mapper过程,调用结果的返回
```



## 2、前后端联调常见问题

```markdown
1、请求方式有问题get/post
2、传输格式混乱错误json/x-wwww-form-urlencoded
3、后台必要的参数,前台省略了
4、数据类型不匹配
5、空指针异常
6、分布式ID生成器生成的ID长度过长(19位),JS无法解析(最多只能16位),需修改ID生成策略
```



## 3、分布式系统的CAP原理

### 1、CAP是什么?

```markdown
-- 指的是在一个分布式系统中,Consistency(一致性)Availability(可用性)Partiation tolarance(分区容错性)三者不可同时获得
	一致性————在分布式系统中的所有数据备份,在同一时刻是否具有相同值(所有节点在同一时间的数据完全一致,越多节点,数据同步耗时越多)
	可用性————负载过大后,集群整体是否还能响应客户端的读写请求(服务一直可以用,而且响应时间正常)
	分区容错性————高可用性,一个节点崩了,不影响其他节点(100个节点,崩了几个,不影响服务,越多机器越好)
```

### 2、不能同时三者满足的原因

```markdown
-- CA满足,P不能满足————数据同步(A)需要时间,也要正常的时间内响应(A),那么机器数量就要少(P不满足)
-- CP满足,A不能满足————数据同步(A)需要时间,机器数量(P)也多,但同步数据需要时间,所以不能在正常时间内响应(A不满足)
-- AP满足,C不能满足————机器数量多(P),也要正常的时间内响应(A),那么数据就不能及时同步到其他节点(C不满足)
```



## 4、统一返回结果处理

```markdown
# JSON数据格式

-- 分类————数组、对象

-- 个人开发要求
	-- 统一基本定义
		{    
			"success":布尔类型,//表示响应是否成功    
			"code":数字类型,//表示响应状态码
      "message":字符串,//表示响应返回的消息 
      "data":HashMap//返回数据，存放在键值对中
    }
    
	-- 列表
		{   
    	“success”:true,//请求相应结果  
      “code”:200,//相应状态码    
      “message“:成功,//相应结果消息    
      “data”:{//设置返回数据    
      	“items”:[//存放多个对象
      		{
        		“id”:1,  
          	“name”:"adad",
          	....
         	},
         	...
         ]  
       }
     }
     
   -- 分页
   	{    
   		“success”:true,//请求相应结果    
   		“code”:200,//相应状态码   
      “message“:成功,//相应结果消息    
      “data”:{//设置返回数据
      	“total”:5,//当前页总记录数
        “rows”:[//存放多个对象    
        	{
          	“id”:1,
            “name”:"adad",
            .... 
          }
        ]
      }
    }
  -- 没有返回数据
  	//成功
  	{   
    	“success”:true,//请求相应结果    
    	“code”:200,//相应状态码    
    	“message“:成功,//相应结果消息    
    	“data”:{}
    }
    //失败
    {    
    	“success”:false,//请求相应结果   
      “code”:404,//相应状态码 
      “message“:失败,//相应结果消息    
      “data”:{}
    }
```

```markdown
# 创建统一返回结果类创建、使用步骤
-- 1、在common模块下创建子模块【common_utils】

-- 2、创建一个接口类，用于定义数据返回状态码
	package com.pigskin.common_utils;
	/**
  * 定义响应状态码 
  */
  public interface ResultCode {
  	/**
    * 响应成功状态码    
    */
    Integer SUCCESS = 20000; 
    /**  
    * 响应失败状态码     
    */
    Integer ERROR = 200001;
  }

-- 3、创建统一结果返回类
  package com.pigskin.common_utils;
  import io.swagger.annotations.ApiModelProperty;
  import lombok.Data;
  import org.springframework.util.StringUtils;
  import java.util.HashMap;
  /**
  * 统一结果返回类 
  */
  @Data
  public class R {   
  	/**
    * 是否响应成功 
    */
    @ApiModelProperty(value = "返回响应是否成功")   
    private Boolean success;
    
    /**
    * 返回状态码
    */
    @ApiModelProperty(value = "返回状态码")
    private Integer code;  
    
    /**
    * 返回消息
    */
    @ApiModelProperty(value = "返回消息")    
    private String message;  
    
    /** 
    * 返回数据
    */ 
    @ApiModelProperty(value = "返回数据")    
    private HashMap<String, Object> data = new HashMap<>();
    
    /**
    * 构造方法私有化    
    */ 
    private R() {  
    }
    
    /**
    * 响应成功的静态方法   
    * 
    * @return 统一返回结果对象  
    */ 
    public static R ok() { 
    	R r = new R(); 
      r.setSuccess(true); 
      r.setCode(ResultCode.SUCCESS);   
      r.setMessage("响应成功");     
      return r;
    } 
   
   	/**
    * 响应失败的静态方法     
    *
    * @return 统一返回结果对象 
    */
    public static R error() {
    	R r = new R();    
      r.setSuccess(false);  
      r.setCode(ResultCode.ERROR);  
      r.setMessage("响应失败");       
      return r;    
    } 
    
    /**
    * 设置返回的响应结果
    * 
    * @param success 响应结果 
    * @return 当前类的对象     
    */
    public R success(Boolean success) {  
    	this.setSuccess(success);
      return this; 
    } 
    
    /** 
    * 设置返回的消息    
    * 
    * @param message
    * @return 当前类的对象     
    */
    public R message(String message) {    
    	this.setMessage(message);  
      return this;    
    } 
    
    /**
    * 设置返回状态码    
    * 
    * @param code 状态码   
    * @return 当前类的对象(此种形式就可以支持链式编程)     
    */   
    public R code(Integer code) { 
    	this.setCode(code);  
      return this;    
    } 
    
    /** 
    * 设置返回数据（单一键值对）    
    * 
    * @param key   键  
    * @param value 值  
    * @return 当前类的对象     
    */
    public R data(String key, Object value) {      
    	this.data.put(key, value);  
      return this;   
    }
    
    /**
    * 设置返回数据结果（HashMap） 
    * 
    * @param map 返回数据    
    * @return 当前对象  
    */  
    public R data(HashMap<String, Object> map) {    
   	 	this.setData(map);      
      return this;   
    }
  }

-- 4、使用
	-- 1、在pom文件中引入定义的依赖
		 <!--引入自定义统一结果返回依赖-->  
     <dependency>          
       <groupId>com.pigskin</groupId>   
       <artifactId>common_utils</artifactId>      
       <version>0.0.1-SNAPSHOT</version>      
     </dependency>
	-- 2、将控制器接口返回结果都定义为R返回结果，并引入定义的统一结果返回类
```



## 5、统一异常处理

```markdown
# 全局异常处理
  package com.pigskin.service_base.exceptionhandler;
  
  import com.pigskin.common_utils.R;
  import org.springframework.web.bind.annotation.ControllerAdvice;
  import org.springframework.web.bind.annotation.ExceptionHandler;
  import org.springframework.web.bind.annotation.ResponseBody;
  /**
  * 统一异常处理类
  */
  @ControllerAdvice
  public class GlobalExceptionHandler {   
  	/**
    * 指定当出现对应异常时执行该方法(统一异常处理类中)   
    *
    * @param e 
    * @return  
    */
    @ResponseBody//为了返回数据    
    @ExceptionHandler(Exception.class)//指定对应的类型异常发生时，执行该方法    
    public R error(Exception e) { 
    	e.printStackTrace();  
      return R.error().message("执行了全局异常处理：" + e.getMessage()); 
    }
  }

# 特定异常处理
    /**    
    * 指定当出现特定异常时执行该方法(统一异常处理类中)
    *     
    * @param e  
    * @return    
    */ 
    @ResponseBody//为了返回数据    
    @ExceptionHandler(ArithmeticException.class)//指定对应的类型异常发生时，执行该方法   
    public R error(ArithmeticException e) {     
    	e.printStackTrace();  
      return R.error().message("执行了ArithmeticException异常处理：" + e.getMessage());
    }

# 自定义异常处理
	-- 创建自定义异常类，并继承RuntimeException，设置相关属性
  	package com.pigskin.service_base.exceptionhandler;
  	
  	import io.swagger.annotations.ApiModel;
  	import io.swagger.annotations.ApiModelProperty;
  	import lombok.AllArgsConstructor;
  	import lombok.Data;
  	import lombok.NoArgsConstructor;
  	
  	/**
    * 自定义异常类 
    */
    @ApiModel(value = "自定义异常类")
    @Data
    @AllArgsConstructor //用于生成全参构造
    @NoArgsConstructor //用于生成无参构造
    public class EduException extends RuntimeException {   
    	@ApiModelProperty(value = "状态码")    
    	private Integer code; 
      @ApiModelProperty(value = "异常提示信息")    
      private String msg;
    }
  
  -- 定义异常处理方法
     /**    
     * 指定当出现自定义异常时执行该方法(统一异常处理类中)  
     *     
     * @param e
     * @return   
     */
     @ResponseBody//为了返回数据 
     @ExceptionHandler(EduException.class)//指定对应的类型异常发生时，执行该方法    
     public R error(EduException e) {    
       e.printStackTrace();
       return R.error().code(e.getCode()).message(e.getMsg());    
     }
     
 	--  执行自定义异常
  	使用throw new XXXException（...）；手动抛出自定义异常
```

## 6、统一日志处理

### 1、日志

```markdown
# 分类
-- OFF————是最高等级的,用于关闭所有日志记录
-- FATAL————指出每个严重的错误事件将会导致应用程序的退出
-- ERROR————指出虽然发生错误事件,但仍然不影响系统的继续运行
-- WARN————指定具有潜在危害的情况
-- INFO————默认项,指定能够突出在粗粒度级别的应用程序运行情况的信息的消息
-- DEBUG————指定细粒度信息事件是最有用的应用程序调试
-- TRACE————指定细粒度比DEBUG更低的信息事件
-- ALL————是最低等级的，用于打开所有日志记录

# 优先级
-- 从高到低依次为:OFF——>FATAL——>ERROR——>WARN——>INFO——>DEBUG——>TRACE——>ALL
-- 日志记录的级别有继承性，子类会记录父类的所有的日志级别。
-- Log4j建议只使用四个级别，优先级从高到低分别是ERROR、WARN、INFO、DEBUG。

# 配置
	logging.leval.root=[对应的日志级别]
```



### 2、日志工具Logback使用步骤

```markdown
# 删除之前的日志配置
	
# resource中创建logback-spring.xml日志配置文件
    <?xml version="1.0" encoding="UTF-8"?>
      <configuration scan="true" scanPeriod="10 seconds"> 
        <!-- 日志级别从低到高分为TRACE < DEBUG < INFO < WARN < ERROR < FATAL，如果设置为WARN，则低于WARN的信息都不会输出 --> 
        <!-- scan:当此属性设置为true时，配置文件如果发生改变，将会被重新加载，默认值为true -->  
        <!-- scanPeriod:设置监测配置文件是否有修改的时间间隔，如果没有给出时间单位，默认单位是毫秒。当scan为true时，此属性生效。默认的时间间隔为1分钟。 -->    
        <!-- debug:当此属性设置为true时，将打印出logback内部日志信息，实时查看logback运行状态。默认值为false。 -->    
        <contextName>logback</contextName>  
        <!-- name的值是变量的名称，value的值时变量定义的值。通过定义的值会被插入到logger上下文中。定义变量后，可以使“${}”来使用变量。 -->  
        <property name="log.path" value="D:/edu_parent/edu"/>
        <!-- 彩色日志 -->
        <!-- 配置格式变量：CONSOLE_LOG_PATTERN 彩色日志格式 -->    
        <!-- magenta:洋红 -->   
        <!-- boldMagenta:粗红-->   
        <!-- cyan:青色 -->    
        <!-- white:白色 -->  
        <!-- magenta:洋红 -->   
        <property name="CONSOLE_LOG_PATTERN" value="%yellow(%date{yyyy-MM-dd HH:mm:ss}) |%highlight(%-5level) |%blue(%thread) |%blue(%file:%line) |%green(%logger) |%cyan(%msg%n)"/>   
        <!--输出到控制台-->
        <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender"> 
          <!--此日志appender是为开发使用，只配置最底级别，控制台输出的日志级别是大于或等于此级别的日志信息-->    
          <!-- 例如：如果此处配置了INFO级别，则后面其他位置即使配置了DEBUG级别的日志，也不会被输出 -->   
          <filter class="ch.qos.logback.classic.filter.ThresholdFilter">   
            <level>INFO</level>   
          </filter>   
          <encoder> 
            <Pattern>${CONSOLE_LOG_PATTERN}</Pattern>      
            <!-- 设置字符集 -->          
            <charset>UTF-8</charset>     
          </encoder>  
        </appender>   

        <!--输出到文件--> 
        <!-- 时间滚动输出 level为 INFO 日志 --> 
        <appender name="INFO_FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">  
          <!-- 正在记录的日志文件的路径及文件名 -->      
          <file>${log.path}/log_info.log</file>    
          <!--日志文件输出格式-->   
          <encoder>         
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>  
            <charset>UTF-8</charset>      
          </encoder>    
          <!-- 日志记录器的滚动策略，按日期，按大小记录 -->   
          <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">     
            <!-- 每天日志归档路径以及格式 -->   
            <fileNamePattern>${log.path}/info/log-info-%d{yyyy-MM-dd}.%i.log</fileNamePattern>  
            <timeBasedFileNamingAndTriggeringPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP">   
              <maxFileSize>100MB</maxFileSize>     
            </timeBasedFileNamingAndTriggeringPolicy>     
            <!--日志文件保留天数-->  
            <maxHistory>15</maxHistory>   
          </rollingPolicy>      
          <!-- 此日志文件只记录info级别的 -->     
          <filter class="ch.qos.logback.classic.filter.LevelFilter">    
            <level>INFO</level>       
            <onMatch>ACCEPT</onMatch>     
            <onMismatch>DENY</onMismatch>   
          </filter> 
        </appender>   

        <!-- 时间滚动输出 level为 WARN 日志 -->  
        <appender name="WARN_FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">     
          <!-- 正在记录的日志文件的路径及文件名 -->   
          <file>${log.path}/log_warn.log</file>    
          <!--日志文件输出格式-->       
          <encoder>          
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
            <charset>UTF-8</charset> 
            <!-- 此处设置字符集 -->    
          </encoder>      
          <!-- 日志记录器的滚动策略，按日期，按大小记录 -->   
          <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">   
            <fileNamePattern>${log.path}/warn/log-warn-%d{yyyy-MM-dd}.%i.log</fileNamePattern>  
            <timeBasedFileNamingAndTriggeringPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP">   
              <maxFileSize>100MB</maxFileSize>    
            </timeBasedFileNamingAndTriggeringPolicy>    
            <!--日志文件保留天数-->          
            <maxHistory>15</maxHistory>  
          </rollingPolicy>      
          <!-- 此日志文件只记录warn级别的 -->   
          <filter class="ch.qos.logback.classic.filter.LevelFilter"> 
            <level>warn</level>    
            <onMatch>ACCEPT</onMatch> 
            <onMismatch>DENY</onMismatch>     
          </filter>   
        </appender>  

        <!-- 时间滚动输出 level为 ERROR 日志 -->  
        <appender name="ERROR_FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">    
          <!-- 正在记录的日志文件的路径及文件名 -->     
          <file>${log.path}/log_error.log</file>    
          <!--日志文件输出格式-->  
          <encoder>   
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>    
            <charset>UTF-8</charset> 
            <!-- 此处设置字符集 -->     
          </encoder>      
          <!-- 日志记录器的滚动策略，按日期，按大小记录 -->   
          <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">   
            <fileNamePattern>${log.path}/error/log-error-%d{yyyy-MM-dd}.%i.log</fileNamePattern>   
            <timeBasedFileNamingAndTriggeringPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP">   
              <maxFileSize>100MB</maxFileSize>  
            </timeBasedFileNamingAndTriggeringPolicy>      
            <!--日志文件保留天数-->        
            <maxHistory>15</maxHistory>    
          </rollingPolicy>       
          <!-- 此日志文件只记录ERROR级别的 -->  
          <filter class="ch.qos.logback.classic.filter.LevelFilter">        
            <level>ERROR</level>         
            <onMatch>ACCEPT</onMatch>       
            <onMismatch>DENY</onMismatch>    
          </filter>    
        </appender>
        <!--        
          <logger>用来设置某一个包或者具体的某一个类的日志打印级别、以及指定<appender>。     
          <logger>仅有一个name属性，一个可选的level和一个可选的addtivity属性。   
          name:用来指定受此logger约束的某一个包或者具体的某一个类。  
          level:用来设置打印级别，大小写无关：TRACE, DEBUG, INFO, WARN, ERROR, ALL 和 OFF，如果未设置此属性，那么当前logger将会继承上级的级别。   
        -->  
        <!--   
          使用mybatis的时候，sql语句是debug下才会打印，而这里我们只配置了info，所以想要查看sql语句的话，有以下两种操作：  
          第一种把<root level="INFO">改成<root level="DEBUG">这样就会打印sql，不过这样日志那边会出现很多其他消息      
          第二种就是单独给mapper下目录配置DEBUG模式，代码如下，这样配置sql语句会打印，其他还是正常DEBUG级别：
        -->    

        <!--开发环境:打印控制台--> 
        <springProfile name="dev">     
          <!--可以输出项目中的debug日志，包括mybatis的sql日志-->    
          <logger name="com.pigskin" level="INFO"/>   
          <!--root节点是必选节点，用来指定最基础的日志输出级别，只有一个level属性   
            level:用来设置打印级别，大小写无关：TRACE, DEBUG, INFO, WARN, ERROR, ALL 和 OFF，默认是DEBUG 
            可以包含零个或多个appender元素。    
          -->       
          <root level="INFO"> 
            <appender-ref ref="CONSOLE"/>     
            <appender-ref ref="INFO_FILE"/>     
            <appender-ref ref="WARN_FILE"/>        
            <appender-ref ref="ERROR_FILE"/>     
          </root>   
        </springProfile> 
        <!--生产环境:输出到文件--> 
        <springProfile name="pro">        
          <root level="INFO">          
            <appender-ref ref="CONSOLE"/>     
            <appender-ref ref="DEBUG_FILE"/>   
            <appender-ref ref="INFO_FILE"/>        
            <appender-ref ref="ERROR_FILE"/>        
            <appender-ref ref="WARN_FILE"/>     
          </root>   
        </springProfile>
      </configuration>

# 将异常信息输出到异常信息文件中
-- 1、全局异常处理类添加@Slf4j注解
-- 2、在异常的地方添加异常输出语句：log.error(e.getMessage());

# 将异常堆栈信息输出到文件
-- 1、定义工具类，common下创建util包，创建ExceptionUtil.java工具类
	package com.pigskin.common_utils;
	
	import java.io.IOException;
	import java.io.PrintWriter;
	import java.io.StringWriter;
	
	public class ExceptionUtil { 
    public static String getMessage(Exception e) { 
      StringWriter sw = null;    
      PrintWriter pw = null; 
      try {          
        sw = new StringWriter(); 
        pw = new PrintWriter(sw);   
        //将出错的堆栈信息输出到pw中        
        e.printStackTrace(pw);         
        pw.flush();        
        sw.flush();   
      } finally {    
        if (sw != null) {    
          try {                
            sw.close();            
          } catch (IOException e1) {   
            e1.printStackTrace();           
          }         
        }        
        if (pw != null)         
        pw.close();     
      }        
      return sw.toString(); 
    }
  }
-- 2、在调用的地方使用以下方式：log.error(ExceptionUtil.getMessage(e));

-- 3、针对自定义异常需要重写toString方法
```



## 7、Json格式转换



## 8、Cron实现定时任务



## 9、Tomcat限制上传文件大小解决

```markdown
#配置文件中添加以下配置
spring.servlet.multipart.max-file-size:1M  #最大上传单个文件大小：默认1M
spring.servlet.multipart.max-request-size:10MB #最大总上传的数据大小：默认10M
```

## 10、解决nginx支持上传文件大小限制问题

```markdown
#nginx配置文件【nginx.conf】的【http{}】中创建配置如下内容
client_max_body_size 1021m;#根据实际需求设置大小
```



# 四、相关注解说明

## 1、基本注解

```markdown
# @Data
	-- 说明————用于生成属性的get/set方法
	-- 使用————实体类上
	
# @Profile({"dev", "test"})
	-- 说明————用于定义插件所启用的环境
	-- 使用————插件配置类方法

# @MapperScan("com.pigskin.mpdemo.mapper")
	-- 说明————用于扫描指定包下的mapper接口，找到其中的内容
	-- 使用————springboot启动类/配置类上，建议配置类中

# @Bean
	-- 说明————告诉Spring可以从该方法中取到一个Bean对象
	-- 使用————方法

# @Repository
	-- 说明————用于将类交给spring进行管理
	-- 使用————类

# @Autowired
	-- 说明————用于对象注入
	-- 使用————类中创建对象

# @Resource
	-- 说明————用于对象注入
	-- 使用————类中创建对象

# @Configuration
	-- 说明————标识该类是一个配置类
	-- 使用————类

# @RestController
	-- 说明————本质是@Controller和@Response的结合体
  -- 使用————控制器类

# @Controller
	-- 说明————用于表示将该类交由Spring管理
  -- 使用————控制器类
  
# @Response
  -- 说明————用于表示控制器响应请求时需要返回json数据
  -- 使用————控制器类
  
# @RequestMapping("URI")
	-- 说明————用于表示当前控制器的被请求URI
  -- 使用————控制器类
  
# @GetMapping("URI")
	-- 说明————用于注解get请求的方法
  -- 使用————控制器类中的方法

# @DeleteMapping("{id}")
	-- 说明————用于注解delete的相关请求方法
  -- 使用————控制器类中的方法

# @PathVariable
	-- 说明————用户获取路径中的参数
  -- 使用————控制器方法形参
  -- 示例————如下:
    @DeleteMapping("{id}")    
		public boolean deleteById(@PathVariable String id) {        
      return eduTeacherService.removeById(id);    
    }

# @ComponentScan(basePackages = {"com.pigskin"})
	-- 说明————用于设置当前模块扫描规则（因为外部的组件配置类需要在本模块项目启动时使用）
  -- 使用————启动类
  
# @RequestBody(required = false)
  -- 说明————表示使用json传递数据，将json数据封装到对应对象中
  -- 使用————控制器类中方法形式参数
  -- 注意
    -- 提交方式必须使用post方式，否则取不到值
    -- required = false————表示参数值可以没有

# @ResponseBody
	-- 说明————表示返回数据，返回json数据
  -- 使用————控制器类

# @ControllerAdvice   
  -- 说明
    -- 全局数据预处理
    -- 使用 @ControllerAdvice 实现全局异常处理，只需要定义类，添加该注解即可
    -- 全局数据绑定功能可以用来做一些初始化的数据操作，我们可以将一些公共的数据定义在添加了 @ControllerAdvice 注解的类中，这样，在每一个 Controller 的接口中，就都能够访问导致这些数据。
  -- 使用————类

# @AllArgsConstructor   
  -- 说明————用于生成有参构造
  -- 使用————类

# @NoArgsConstructor   
  -- 说明————用于生成无参构造
  -- 使用————类

# @CrossOrgin    
  -- 说明————用于解决跨域请求问题
  -- 使用————控制器类名上

# @EnableDiscoveryClient    
  -- 说明————用于让注册中心能够发现、扫描到该服务
  -- 使用————SpringBoot服务启动类

# @EnableFeignClients
  -- 说明————用于可以实现SpringCloud的服务远程调用
  -- 使用————调用端SpringBoot服务启动类

# @FeignClient(name="vod",fallback=对应实现类提供熔断机制.class)
  -- 说明————用于指定从哪个服务中调用功能 ，名称与被调用的服务名保持一致
  -- 使用————调用方创建的远端服务调用接口

# @RequestParam("videoIdList")
  -- 说明————将请求参数绑定到你控制器的方法参数上（是springmvc中接收普通参数的注解）
  -- 使用————控制器类中方法形式参数
```



## 2、Swagger相关注解

```markdown
# @EnableSwagger2
  -- 说明————用于表示启用Swagger
  -- 使用————Swagger配置类

# @Api(description = "讲师管理")
	-- 说明————对接口文档的类进行友好性提示
	-- 使用————类

# @ApiOperation(value = "根据id逻辑删除讲师")
	-- 说明————对接口文档的方法进行友好性提示
	-- 使用————方法

# @ApiParam(name = "id", value = "讲师id", required = true)
	-- 说明————对接口文档的方法参数进行友好性提示
	-- 使用————形式参数上
	-- 参数说明————required[标该参数识是否必须要有]

# @ApiModelProperty(value = "返回消息")
	-- 说明————对接口文档的方法参数进行友好性提示
	-- 使用————实体类属性
```

## 3、Spring相关注解

```markdown
# @Value("${aliyun.oss.file.bucketname}")
	-- 说明————设置类中属性的值为配置文件中的信息
	-- 使用————实体类属性
	-- 示例————如下:
		@Value("${spring.tencentcloud.sms.accessKeyId}")
    public String accessKeyId;

# @ConfigurationProperties(prefix = "spring.tencentcloud.sms")
	-- 说明————读取配置文件自定义的多个属性,将配置文件中的值一一设置到该类的属性值中
	-- 使用————类
	-- 参数说明————prefix[用于指定属性键的前缀,拼接上对应属性名的属性,就是对应的配置属性键]
```



## 3、MybatisPlus相关注解

```markdown
# @TableId（type=IdType.xxx）
	-- 说明————用于自动生成唯一值【主要用于主键生成】
	-- 使用————属性
	-- type属性值分类
		-- AUTO：自动增长
		-- ID_WORKER：mp自带生成19位的数字类型
		-- ID_WORKER_STR：mp自带生成19位的字符串类型
		-- INPUT：自定义
		-- UUID：随机唯一值
		-- NONE：不使用策略

# @TableField（fill=FieldFill.xxx）
	-- 说明————用于自动填充属性
	-- 使用————属性
	-- fill属性值分类
		-- DEFAULT:默认不处理
		-- INSERT:插入填充字段
		-- UPDATE:更新填充字段
		-- INSERT_UPDATE:插入和更新填充字段
		
# @TableLogic
	-- 说明————用于逻辑删除设置
	-- 使用————属性
	
# @Version
	-- 说明————用于乐观锁配置
	-- 使用————属性
	
```



## 4、Redis相关注解

```markdown
# @EnableCaching
	-- 说明————用于开启缓存注解
	-- 使用————缓存（Redis）配置类
@Cacheable【一般用在查询方法上】
	-- 说明————根据方法对其返回结果进行缓存，下次请求时如果缓存还存在，则直接读取缓存数据；如果缓存不存在，则执行方法并把返回的结果存入缓存中
	-- 属性值
		-- value【缓存名，必填，它指定了你的缓存存放在哪块命名空间】
		-- cacheNames【与value差不多，二选一即可】
		-- key【可选属性，可以使用SpEL标签自定义缓存的key】

# @CachePut【一般用在新增方法上】
	-- 说明————使用该注解标志的方法，每次都会执行，并将结果存入指定的缓存中。其他方法可以直接从响应的缓存中读取缓存数据，而不需要再去查询数据库
	-- 属性值
		-- value【缓存名，必填，它指定了你的缓存存放在哪块命名空间】
		-- cacheNames【与value差不多，二选一即可】
		-- key【可选属性，可以使用SpEL标签自定义缓存的key】

# @CacheEvict【一般用在更新或者删除方法上】
	-- 说明————使用该注解标志的方法，会清空指定的缓存
	-- 属性值
		-- value【缓存名，必填，它指定了你的缓存存放在哪块命名空间】
		-- cacheNames【与value差不多，二选一即可】
		-- key【可选属性，可以使用SpEL标签自定义缓存的key】
		-- allEntries【是否清空所有缓存，默认为false。如果指定为true，则方法调用后将立即清空所有的缓存】
		-- beforeInvocation【是否在方法执行前就清空，默认为false。如果指定为true，则在方法执行前就会清空缓存】
```





