## 1、Vscode



## 2、ES6



## 3、Vue



## 4、ElementUI



## 5、Axios



## 6、Node.js



## 7、Npm



## 8、Babel



## 9、模块化



## 10、WebPack

```bash
1、说明
	一个将多个静态资源文件，打包成一个文件，可以减少页面请求次数的前端资源加载/打包工具，根据模块的依赖关系进行静态分析，然后将这些模块暗转指定的规则生成对应的静态资源
2、安装
	# 全局安装
	npm install webpack@4.16.5 -g
	npm i webpack -D
	npm i webpack-cli -D
	npm install webpack-cli@3.1.0 -g
	# 安装后查看版本号
	webpack -v
3、使用
	# 打包js文件
		-- 创建js文件，用于打包操作
			common.js、utils.js用于定义方法
			main.js引入common.js和utils.js
		-- 项目根目录下，创建webpcak配置文件【webpack.config.js】，配置打包信息
			// 引入Node.js内置模块
			const path=require("path");
			module.exports={    
				//配置入口文件    
				entry:'./src/main.js',    
				output:{        
					//输出路径，【_dirname:当前文件所在路径】        
					path:path.resolve(__dirname,'./dist'),        
					//输出文件        
					filename:'bundle.js'    
				}
			}
		-- 使用命令执行打包操作
			// 有黄色警告
			webpack
			// 没有警告
			webpack --mode=development/production
		-- 最终测试
			创建html文件——>引入打包后生成的js文件——>在浏览器打开html文件，看效果
			
	# 打包css文件
		-- 创建css文件，用于打包操作
			body{    
				background-color: red;
			}
		-- 在main.js中引入css文件
			require('./style.css')
		-- 安装css加载工具style-loader和css-loader
			npm install --save-dev style-loader@0.19.1 css-loader@0.28.3
		-- 修改webpack.config.js
			//追加以下内容：
			module:{        
				rules:[{                
					// 打包规则应用到以.css结尾的文件上                
					test:/\.css$/,                
					use:['style-loader','css-loader']            
				}]    
			}
		-- 使用命令执行打包操作
			// 有黄色警告
			webpack
			// 没有警告
			webpack --mode=development/production
		-- 6、最终测试
			创建html文件——>引入打包后生成的js文件——>在浏览器打开html文件，看效果
	# 其他打包方式
		-- 可以配置项目的npm运行命令，修改package.json文件
			"scripts":{    
				"dev":"webpack --mode=development"
			}
		-- 运行npm命令执行打包
			npm run dev
```



## 11、富文本编辑器

```html
1、说明
	多样化文本编辑器
2、整合步骤
	# 复制富文本编辑器相关组件[commponents][static]
	# 项目配置文件【build/webpack.dev.conf.js】添加配置信息,用于找到路径
		new HtmlWebpackPlugin({    
			......,    
			templateParameters: {        
				BASE_URL: config.dev.assetsPublicPath + config.dev.assetsSubDirectory    
			}
		})
	# 项目中的【index.html】文件中引入脚本，之后需重启
		<!-- 富文本相关js -->
		<script src=<%=BASE_URL %>/tinymce4.7.5/tinymce.min.js ></script>
		<script src=<%=BASE_URL %>/tinymce4.7.5/langs / zh_CN.js ></script>
3、使用步骤
	# 引入组件
  	import Tinymce from '@/components/Tinymce'
  # 声明组件
  	export default {    
			components: { Tinymce },    
			......
		}
  # 使用组件模板
  	<tinymce :height="300" v-model="courseInfo.description"/>
  # 可使用样式美化
  	<style scoped>
      .tinymce-container {  
        line-height: 29px;
      }
		</style>
```



## 12、NUXT框架

```html
1、说明
	NUXT是基于node.js的封装(框架)而成的一种服务端渲染技术.其目的在于更好的解决了Ajax不利于SEO的问题
2、使用
	# 找到nuxt压缩文件【starter-template-master】
	# 添加到工作区
	# 使用项目下载依赖
		npm install
	# 启动项目
		npm run dev
3、目录结构
	# .nuxt————前端编译文件
	# assets————放项目中使用到的静态资源（CSS/JS/图片）
	# components————放项目中用到的第三方组件
	# layouts————定义网页的布局
	# middleware————放相关组件
	# node_modules————放下载的依赖
	# pages————项目页面
4、NUXT路由
 	# 固定路由————路径是固定地址，不发生改变
 		# to属性设置路由跳转地址（在pages中创建course文件夹，文件夹下创建index.vue,就会跳转）				
		<router-linkto="/" tag="li" active-class="current" exact>
 			<a>首页</a>
 		</router-link>
	# 动态路由————每次生成的路由地址都不相同
		# 规则————以_开头的vue文件，参数名称为下划线后边的文件名
5、页面整合
	# 插件整合
		// 安装
			npm install vue-awesome-swiper
		// 配置插件
			# 在plugins文件夹下新建文件nuxt-swiper-plugin.js，内容如下:
        import Vue from 'vue'
        import VueAwesomeSwiper from 'vue-awesome-swiper/dist/ssr'
        Vue.use(VueAwesomeSwiper)
			# 在nuxt.config.js文件中配置插件
				#将plugins和css节点复制到module.exports节点下
				module.exports={
					//somenuxtconfig...
					plugins:[{
						src:'~/plugins/nuxt-swiper-plugin.js',
						ssr:false
					}],
					css:['swiper/dist/css/swiper.css']
				}
		// 整合幻灯片
			<!--幻灯片开始-->
			<div v-swiper:mySwiper="swiperOption">
        <div class="swiper-wrapper">
          <div class="swiper-slide" style="background:#040B1B;">
            <a target="_blank"href="/">
              <img src="~/assets/photo/banner/1525939573202.jpg" alt="首页banner">
            </a>
          </div>
          <div class="swiper-slide" style="background:#F3260B;">
            <a target="_blank"href="/">
              <img src="~/assets/photo/banner/153525d0ef15459596.jpg" alt="首页banner">
            </a>
          </div>
        </div>
        <div class="swiper-pagination swiper-pagination-white"></div>
        <div class="swiper-button-prev swiper-button-white" slot="button-prev"></div>
        <div class="swiper-button-next swiper-button-white" slot="button-next"></div>
			</div>
			<!--幻灯片结束-->
	# 资源复制
		// 复制项目使用静态资源到assets目录
		// 复制布局文件到layouts中
		// 复制index.vue到pages中
6、插件使用
  import VueQriously from 'vue-qriously'
  //element-ui的全部组件
  import ElementUI from 'element-ui'
  //element-ui的css文件
  import 'element-ui/lib/theme-chalk/index.css'

  Vue.use(ElementUI)
  Vue.use(VueQriously)
```



## 13、登陆功能知识点

### 	1、验证码有效时间倒计时原理

```javascript
// 1、通过定时器方法实现
	//每隔一段时间执行一次js方法
	setInterval("方法","间隔时长")
// 2、js代码
	// 设置获取验证码定时器    
	timeDown() {      
    let result = setInterval(() => {        
      --this.second;        
      this.codeTest = this.second+"后重新获取";        
      if (this.second < 1) {          
        clearInterval(result);          
        this.sending = true;          
        this.second = 60;          
        this.codeTest = "获取验证码";        
      }      
    }, 1000);    
	},
```

### 	2、手机号验证

```javascript
//手机号校验    
checkPhone(rule, value, callback) {      
  if (this.params.mobile === "") {        
    //信息提示        
    this.$message({          
      type: "warning",          
      message: "请输入手机号",        
    });        
    return;      
  }      
  if (!/^1[34578]\d{9}$/.test(value)) {        
    return callback(new Error("手机号格式不正确"));      
  }      
  return callback();    
},
```



## 14、JS-Cookie

```javascript
// 1、下载安装
	npm insatll js-cookie

// 2、引入js-cookie
	import cookie from "js-cookie";

// 3、将登录成功后后台返回的token字符串放入cookie中
  // 三个参数（"cookie的名字"，"cookie的值","参数作用范围"）
  cookie.set("edu_token", response.data.token, { domain: "localhost" });

// 4、在【request.js】的request拦截器中当cookie中有token时，将其放入header（请求头）中
	//request拦截器
	service.interceptors.request.use(  
    config => {    
      //判断cookie中是否有token    
      if (cookie.get("edu_token")) {      
        //有的话将其放入header中      
        config.headers['token'] = cookie.get('edu_token')    
      }    
      return config  
    },  
    err => {    
      return Promise.reject(err);  
    }
  )
// 5、根据token值获取用户信息，并将用户信息记录到cookie
  //根据token值获取用户信息        
  loginApi.getLoginUserInfo().then((response) => {          
    this.loginInfo = response.data.member;          
    //将用户信息记录到cookie          
    cookie.set("edu_ucenter", this.loginInfo, { domain: "localhost" });          
    //页面跳转          
    window.location.href = "/";        
  });
// 6、其他地方可以从cookie中获取用户信息
  //从cookie中获取用户信息    
  getUcenterFromCookie() {      
    if (cookie.get("edu_ucenter")) {        
      var userStr = cookie.get("edu_ucenter");        
      if (userStr) {          
        //将字符串转换为json对象          
        this.loginInfo = JSON.parse(userStr);        
      }      
    }    
  },
// 7、退出时清空cookie值即可
    logout() {      
      //清除cookie      
      cookie.set("edu_ucenter", "", { domain: "localhost" });  
      cookie.set("edu_token", "", { domain: "localhost" });      
      //跳转页面     
      window.location.href = "/";    
    },
```



## 15、JS中页面跳转方式

```js
// 方式一
window.location.href = "/";
// 方式二
this.$router.push({ path: "/login" });
```



## 16、Vue异步调用

```javascript
// 异步调用(params:路径中的值，error:错误信息)只会调用一次  
asyncData({ isDev, route, store, env, params, query, req, res, redirect, error }) {   	//return 必须写，且不能换行    
  return teacherApi.getTeacherFrontList(1, 8).then((response) => {
    console.log(response.data);      
    //不用定义，直接传，就会帮我们创建，并赋值      
    return { data: response.data.pageParams };    
  });  
}
```



## 17、原始分页功能

```html
<!-- 公共分页 开始 -->        
<div v-if="data.total > 0">          
  <div class="paging">            
    <!-- undisable这个class是否存在，取决于数据属性hasPrevious -->            
    <a              
       :class="{ undisable: !data.hasPrevious }"              
       href="#"              
       title="首页"              
       @click.prevent="gotoPage(1, data.hasPrevious)">首页</a>            
    <a              
       :class="{ undisable: !data.hasPrevious }"              
       href="#"              
       title="前一页"              
       @click.prevent="gotoPage(data.current - 1, data.hasPrevious)"></a>            		 <a                                                                           				 v-for="page in data.pages"                                                             			 :key="page"              
       :class="{ current: data.current == page, undisable: !data.current == page }"              				href="#"                                                                              			 :title="'第' + page + '页'"                                                                                      			 @click.prevent="gotoPage(page)">{{ page }}</a>            
    <a              
       :class="{ undisable: !data.hasNext }"              
       href="#"              
       title="后一页"              
       @click.prevent="gotoPage(data.current + 1, data.hasNext)"></a>            
    <a              
       :class="{ undisable: !data.hasNext }"              
       href="#"              
       title="末页"              
       @click.prevent="gotoPage(data.pages, data.hasNext)">尾页</a>            
    <div class="clear"></div>          
  </div>        
</div>        
<!-- 公共分页 结束 -->
```



## 18、[Echarts](https://echarts.apache.org/zh/index.html)

```javascript
<!-- 说明 -->
	Echarts是百度的一个项目,后来百度把 Chart捐给 apache
<!-- 作用 -->
	用于图表展示,提供了常规的振线图、柱状图、散点图、饼图、K线图,用于统计的盒形图,用于地理数据可视化的地图、热力图、线图,用于关系数据可视化的关系图、 treemap旭日图,多维数据可视化的平行坐标,还有用于BI的漏斗图,仪表盘,并且支持图与图之间的混搭。
<!-- 使用（项目整合）-->

```

