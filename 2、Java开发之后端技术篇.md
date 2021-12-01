# 一、主流技术

## 1、MybatisPlus

## 2、Swagger

## 3、Nginx

## 4、Tomcat

## 5、EasyExcel

## 6、SpringBoot

## 7、SpringCloud

## 8、Nacos

## 9、Redis

## 10、JWT

## 11、MD5加密

## 12、OAuth2

## 13、Canal数据同步工具

## 14、Spring Security权限框架

## 15、Git

## 16、Jenkins

## 17、Docker



# 二、第三方服务技术

## 1、阿里云oss

```xml
1、说明
	解决海量存储和弹性扩容
2、开通
	# 打开阿里云网址：https://www.aliyun.com/
	# 注册阿里云账户，使用支付宝实名认证
	# 找到产品中的【对象存储OSS】
	# 点击立即开通
	# 进入管理控制台
	# 创建Bucket
3、java代码实现文件上传到阿里云oss
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

```java
1、说明
	视频点播（ApsaraVideo VoD，简称VoD）是集视频采集、编辑、上传、媒体资源管理、自动化转码处理（窄带高清™）、视频审核分析、分发加速于一体的一站式音视频点播解决方案。
2、开通
	# 打开阿里云网址：https://www.aliyun.com/<br>
	# 找到产品中的【视频服务】中的【视频点播】
	# 选择【按流量计费】开通
3、管理控制台使用
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
4、java代码实现相关功能
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
    public static DefaultAcsClientinitVodClient(String accessKeyId,String accessKeySecret)throws ClientException{
    	StringregionId="cn-shanghai";//点播服务接入区域                                                                                                 			DefaultProfile profile=DefaultProfile.getProfile(regionId,accessKeyId,accessKeySecret);
      DefaultAcsClient client=new DefaultAcsClient(profile);
      return client;                                                                                                                     		 }
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
         @Override    
         public void removeMoreVideo(List<String> videoIdList) {
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

```java
1、文档地址
	https://help.aliyun.com/document_detail/61064.html
2、基本使用流程
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

```vue
4、项目整合
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

```java
1、说明
	实现短信验证
2、开通
	# 登录阿里云
	# 选择短信服务，免费开通
	# 国内消息
		-- 模板管理
			用于显示内容设置
		-- 签名管理
3、项目整合
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

```java
1、说明
	实现短信验证
2、Java SDK文档地址
	https://cloud.tencent.com/document/product/382/43194
3、开通过程
	和阿里云类似
4、项目整合
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

```
1、准备工作
	# 注册开发者资质(仅支持企业,注册后提供微信ID和密钥)
		https://open.weixin.qq.com/
	# 申请网站应用名称
	# 需要域名地址
2、开发过程
	# https://developers.weixin.qq.com/doc/oplatform/Website_App/WeChat_Login/Wechat_Login.html
```

<img src="image/img2_6_2_1.png" style="zoom:50%;" />

```java
3、后端功能实现
	# 配置文件添加配置
		# 微信开放平台 app_id    
  	wx.open.app_id=wxed9954c01bb89b47    
  	# 微信开放平台 app_secret    		
  	wx.open.app_secret=a7482517235173ddb4083788de60b90e    
  	# 微信开放平台 重定向url    
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
          String userInfoUrl = String.format(baseUserInfoUrl,  
                                             access_token,            
                                             openid);              
          //4、发送请求(获取扫码人信息)            
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

```vue
4、前端代码实现
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

```java
1、后端
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

```vue
2、前端
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
              <span class="success-info">
                订单提交成功，请您及时付款！订单号：{{ payObj.out_trade_no }}
              </span>     
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

```java
1、说明
	不需要浏览器，也能模拟浏览器发送请求和得到数据过程,多用于安卓和IOS
2、使用
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
  # 编写工具类代码
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
          public static String post(String url, String body, String mimeType, String charset, Integer connTimeout, Integer readTimeout)
                  throws ConnectTimeoutException, SocketTimeoutException, Exception {
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
          public static String postForm(String url, Map<String, String> params, Map<String, String> headers, Integer connTimeout, Integer readTimeout) throws ConnectTimeoutException,
                  SocketTimeoutException, Exception {

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
                  if (url.startsWith("https") && client != null
                          && client instanceof CloseableHttpClient) {
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

                  SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslContext, new X509HostnameVerifier() {

                      @Override
                      public boolean verify(String arg0, SSLSession arg1) {
                          return true;
                      }

                      @Override
                      public void verify(String host, SSLSocket ssl)
                              throws IOException {
                      }

                      @Override
                      public void verify(String host, X509Certificate cert)
                              throws SSLException {
                      }

                      @Override
                      public void verify(String host, String[] cns,
                                         String[] subjectAlts) throws SSLException {
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
  # 调用其中方法，实现get/post请求
```



# 三、开发经验

## 1、开发模式

```
1、前后端分离
	# 概念
		-- 前端
		 	作用：数据展示
		 	ajax异步请求操作，调用接口
		-- 后端
			作用：操作数据/返回数据（json）
			接口开发：开发controller\service\mapper过程,调用结果的返回
```

## 2、前后端联调常见问题

```tex
1、请求方式有问题get/post
2、传输格式混乱错误json/x-wwww-form-urlencoded
3、后台必要的参数,前台省略了
4、数据类型不匹配
5、空指针异常
6、分布式ID生成器生成的ID长度过长(19位),JS无法解析(最多只能16位),需修改ID生成策略
```

## 3、分布式系统的CAP原理

```
1、CAP是什么?
	# 指的是在一个分布式系统中,Consistency(一致性)Availability(可用性)Partiation tolarance(分区容错性)三者不可同时获得
	# 一致性
		-- 在分布式系统中的所有数据备份,在同一时刻是否具有相同值(所有节点在同一时间的数据完全一致,越多节点,数据同步耗时越多)
	# 可用性
		-- 负载过大后,集群整体是否还能响应客户端的读写请求(服务一直可以用,而且响应时间正常)
	# 分区容错性
		-- 高可用性,一个节点崩了,不影响其他节点(100个节点,崩了几个,不影响服务,越多机器越好)
2、不能同时三者满足的原因
	# CA满足,P不能满足
		数据同步(A)需要时间,也要正常的时间内响应(A),那么机器数量就要少(P不满足)
	# CP满足,A不能满足
		数据同步(A)需要时间,机器数量(P)也多,但同步数据需要时间,所以不能在正常时间内响应(A不满足)
	# AP满足,C不能满足
		机器数量多(P),也要正常的时间内响应(A),那么数据就不能及时同步到其他节点(C不满足)
```

## 4、统一返回结果处理

## 5、统一异常处理

## 6、统一日志处理

## 7、Json格式转换

## 8、Cron实现定时任务

# 四、相关注解说明

## 1、基本注解

```java
@RestController
	# 说明————本质是@Controller和@Response的结合体
  # 使用————控制器类
@Controller
	# 说明————用于表示将该类交由Spring管理
  # 使用————控制器类
@Response
	# 说明————用于表示控制器响应请求时需要返回json数据
  # 使用————控制器类
@RequestMapping("URI")
	# 说明————用于表示当前控制器的被请求URI
  # 使用————控制器类
@GetMapping("URI")
	# 说明————用于注解get请求的方法
  # 使用————控制器类中的方法
@DeleteMapping("{id}")
	# 说明————用于注解delete的相关请求方法
  # 使用————控制器类中的方法
@PathVariable
	# 说明————用户获取路径中的参数
  # 使用————控制器方法形参
  # 示例————如下:
    @DeleteMapping("{id}")    
		public boolean deleteById(@PathVariable String id) {        
      return eduTeacherService.removeById(id);    
    }
@ComponentScan(basePackages = {"com.pigskin"})
	# 说明————用于设置当前模块扫描规则（因为外部的组件配置类需要在本模块项目启动时使用）
  # 使用————启动类
@RequestBody(required = false)
  # 说明————表示使用json传递数据，将json数据封装到对应对象中
  # 使用————控制器类中方法形式参数
  # 注意
    -- 提交方式必须使用post方式，否则取不到值
    -- required = false————表示参数值可以没有
@ResponseBody
	# 说明————表示返回数据，返回json数据
  # 使用————控制器类
@ControllerAdvice   
  # 说明
    -- 全局数据预处理
    -- 使用 @ControllerAdvice 实现全局异常处理，只需要定义类，添加该注解即可
    -- 全局数据绑定功能可以用来做一些初始化的数据操作，我们可以将一些公共的数据定义在添加了 @ControllerAdvice 注解的类中，这样，在每一个 Controller 的接口中，就都能够访问导致这些数据。
  # 使用————类
@AllArgsConstructor   
  # 说明————用于生成有参构造
  # 使用————类
@NoArgsConstructor   
  # 说明————用于生成无参构造
  # 使用————类
@CrossOrgin    
  # 说明————用于解决跨域请求问题
  # 使用————控制器类名上
@EnableDiscoveryClient    
  # 说明————用于让注册中心能够发现、扫描到该服务
  # 使用————SpringBoot服务启动类
@EnableFeignClients
  # 说明————用于可以实现SpringCloud的服务远程调用
  # 使用————调用端SpringBoot服务启动类
@FeignClient(name="vod",fallback=对应实现类提供熔断机制.class)
  # 说明————用于指定从哪个服务中调用功能 ，名称与被调用的服务名保持一致
  # 使用————调用方创建的远端服务调用接口
@RequestParam("videoIdList")
  # 说明————将请求参数绑定到你控制器的方法参数上（是springmvc中接收普通参数的注解）
  # 使用————控制器类中方法形式参数
```

## 2、Swagger相关注解

```
@EnableSwagger2
  # 说明————用于表示启用Swagger
  # 使用————Swagger配置类
@Api(description = "讲师管理")
	# 说明————对接口文档的类进行友好性提示
	# 使用————类文件
@ApiOperation(value = "根据id逻辑删除讲师")
	# 说明————对接口文档的方法进行友好性提示
	# 使用————方法
@ApiParam(name = "id", value = "讲师id", required = true)
	# 说明————对接口文档的方法参数进行友好性提示
	# 使用————形式参数上
	# 参数说明————required[标该参数识是否必须要有]
@ApiModelProperty(value = "返回消息")
	# 说明————对接口文档的方法参数进行友好性提示
	# 使用————实体类属性
```

## 3、Redis相关注解

```java
@EnableCaching
	# 说明————用于开启缓存注解
	# 使用————缓存（Redis）配置类
@Cacheable【一般用在查询方法上】
	# 说明————根据方法对其返回结果进行缓存，下次请求时如果缓存还存在，则直接读取缓存数据；如果缓存不存在，则执行方法并把返回的结果存入缓存中
	# 属性值
		-- value【缓存名，必填，它指定了你的缓存存放在哪块命名空间】
		-- cacheNames【与value差不多，二选一即可】
		-- key【可选属性，可以使用SpEL标签自定义缓存的key】
@CachePut【一般用在新增方法上】
	# 说明————使用该注解标志的方法，每次都会执行，并将结果存入指定的缓存中。其他方法可以直接从响应的缓存中读取缓存数据，而不需要再去查询数据库
	# 属性值
		-- value【缓存名，必填，它指定了你的缓存存放在哪块命名空间】
		-- cacheNames【与value差不多，二选一即可】
		-- key【可选属性，可以使用SpEL标签自定义缓存的key】
@CacheEvict【一般用在更新或者删除方法上】
	# 说明————使用该注解标志的方法，会清空指定的缓存
	# 属性值
		-- value【缓存名，必填，它指定了你的缓存存放在哪块命名空间】
		-- cacheNames【与value差不多，二选一即可】
		-- key【可选属性，可以使用SpEL标签自定义缓存的key】
		-- allEntries【是否清空所有缓存，默认为false。如果指定为true，则方法调用后将立即清空所有的缓存】
		-- beforeInvocation【是否在方法执行前就清空，默认为false。如果指定为true，则在方法执行前就会清空缓存】
```





