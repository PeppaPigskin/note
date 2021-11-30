# 一、主流技术

## 1、

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

## 4、阿里云短信服务

## 5、腾讯云短信服务

## 6、微信登录（注册）实现

## 7、微信支付

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



# 二、开发经验

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



