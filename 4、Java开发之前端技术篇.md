## 1、Vscode

```vue
1、使用
	# 安装
		brew install vscode
	# 插件安装
		Chinese:中文语言包
		Liver Service:内置服务器，模拟tomcat的效果
		Vetur:Vue开发工具
		Vue-helper:Vue开发工具
	# 创建工作区
		-- 本地创建空文件夹
		-- 使用VsCode打开该文件夹
		-- 将文件夹另存为工作区
2、抽取代码片段
	# 设置
		文件->首选项->用户代码片段->新建全局代码片段/文件夹代码片段
	# 使用
		根据设置的快捷键快速插入
3、 相关插件
-- Chinese (Simplified) Language Pack for Visual Studio Code————汉化插件
-- Bracket Pair Colorizer————彩色括号
-- Auto Close Tag————标签自动补全
-- Auto Rename Tag————修改标签名自动同步闭合标签
-- Draw.io Integration————画流程图
-- Git版本控制
	1、Git Graph————可以查看git提交历史 现在所处分支 提交内容明细 以及回滚删除分支等操作
	2、Git Lens————可在代码行中查看谁提交的 清晰追溯 目前我只用到这个工具中的这个功能
-- LeetCode————力扣刷算法题的插件
-- Vetur————可以高亮Vue代码 格式化代码等
-- Chinese————简体中文包
-- EsLint————ES语法检查工具
-- HTML CSS Support————Html Css支持
-- JavaScript (ES6) code snippets————JavaScript语法提示
-- Live Server————实时服务器
-- open in browser————在浏览器打开页面插件
```

## 2、ES6

```markdown
# 说明
	一套JS标准

# ES6和ES5区别
	ES6简洁,但兼容差

# 基本语法
	-- let
		1、var定义变量没有作用范围
		2、let定义变量有作用范围	
		3、var 可以声明多次，let只能声明一次
	-- const
		1、const用于声明常量
		2、常量值一旦定义就不能更改
		3、常量定义必须初始化
	-- 数组解构
  	1、传统写法
    	let a=1,b=2,c=3
      console.log(a,b,c)
		2、es6写法
    	let [x,y,z]=[1,2,3]
      console.log(x,y,z)
	-- 对象解构
  	1、传统写法
    	let name=user.name
      let age=user.age
      console.log(name,age)
		2、es6写法
    	let {nage,age}=user
      console.log(name,age)
	-- [``]模板字符串
  	1、可实现换行效果
    2、包含的字符串可插入表达式和变量，使用${变量名}
		3、包含的字符串中可调用方法，使用${方法调用}
	-- 声明对象
  	1、传统方式
    	const user1={name:name,age:age}
    2、es6写法
    	const user2={name,age}
	-- 定义方法
  	1、传统方式
    	//定义
    	const p={    
        sayHi:function(){
          console.log("Hi")
        }
      }
      //调用
      p.sayHi()
		2、es6方式
    	//定义
    	const p={
        sayHi(){
          console.log("Hi")
        }
      }
      //调用
      p.sayHi()
	-- 对象扩展运算符
  	1、拷贝对象
    	let p={name:"A",age=10}
      let cp={...p}
      console.log(cp)//{name:"A",age=10}
		2、合并对象
    	let p={name:"A"}
      let a={age=10}
      let cp={...p,...a}
      console.log(cp)//{name:"A",age=10}
	-- 箭头函数
  	1、传统定义函数
    	var f1=function(a){    
        return a
      }
      console.log(f1(1))
		2、ES6
    	var f2=a=>a
      console.log(f2(1))
		3、说明
    	// 当箭头函数没有参数时，需要用（）括起来
    	// 函数体中包含多条 执行语句时需要用{}括起来
      // 函数体只有一行语句，可以省略{}，结果会自动返回
    	// 多用于定义匿名函数
```



## 3、Vue

```markdown
# 说明
	一套用于构建用户界面的渐进式框架

# 基本使用
	1、创建html
	2、引入vue的js文件
		<script src="vue.min.js"></script>
	2、创建div标签，并添加id属性
		<div id="app "></div>
	4、编写vue代码，固定格式
		<script>
      //创建一个vue对象
      new Vue({
        el: "#app",//绑定Vue作用的范围
        data:{//定义页面中显示的数据模型
          message:'Hello!'
        },
        methods:{//定义多个方法
          search(){}
        }
      })
		</script>
	5、使用插值表达式，绑定vue中的data数据
		{{message}}

# 基本数据渲染和语法指令
	-- v-bind
		1、作用：单项数据绑定
		2、使用对象：标签属性中，获取值
		3、示例： 
			<h1 v-bind:title="message">            
        {{content}}
			</h1>
			<!-- 简写形式 -->
			<h1 :title="message">
        {{content}}
			</h1>
	-- v-model
		1、作用：双向数据绑定
		2、使用对象：内容绑定
		3、示例：
			<!-- v-model使用 -->
			<!-- 单向绑：此处变，其他地方不变定 -->
			<input type="text" :value="searchMap.keyWord">        
			<!-- 双向绑定：一个地方变，其他跟着变 -->
			<input type="text" v-model="searchMap.keyWord">
			<p>{{searchMap.keyWord}}</p>
  -- v-on:事件名称
		1、作用：用于事件绑定
		2、使用对象：事件的响应
		3、示例：
			<!-- v-on:事件名 - 进行事件绑定-->
			<button v-on:click="search()">查询</button>
			<!-- 简写形式 -->
			<button @click="search()">查询</button>
	-- .prevent
		1、作用：用于指出一个指令应该以特殊的方式绑定
		2、示例：
			.prevent告诉v-on指令对于触发的时事件调用js的preventDefault()
			<!-- 修饰符 -->
			<form action="save" @submit.prevent="onSubmitForm()">            
        <input type="text" name="name" v-model="user.name"/>
        <button type="submit">保存</button>
			</form>
	-- v-if
		1、作用：条件渲染
		2、示例：
			<!-- 条件渲染 -->
			<input type="checkbox" v-model="ok"/>是否同意
			<h1 v-if="ok">阿达</h1>
			<h1 v-else>好的</h1>
	-- v-for
		1、作用：循环输出
		2、示例： 
      <!-- 循环遍历 -->
      <!-- 简单的列表渲染 -->
      <ul>
        <li v-for="n in 10">{{n}}</li>
      </ul>
      <!-- 带索引的 -->
      <ul>
        <li v-for="(n,index) in 5">{{n}}={{index}}</li>
      </ul>

# 组件
	-- 局部组件
		1、定义
			new Vue({
				el: '#app',
				data: {
				},
				components:{//定义vue使用的组件
					// 组件名字
					'Navbar':{
						//组件内容
						template:'<ul><li>首页</li><li>学员管理</li></ul>'
					}
				}
			})
		2、使用
			标签使用：<Navbar></Navbar>
	-- 定义全局组件
		1、定义
			//创建单独的js文件，在其中定义全局组件
			Vue.component(
				// 组件名字
				'Navbar',{
					//组件内容
					template:'<ul><li>首页</li><li>学员管理</li></ul>'
				}
			)
		2、使用
			//引入该全局组件js
			<script src="components/Navbar.js"></script>
			//标签使用：<Navbar></Navbar>
	-- 父子组件数据传递
		1、说明————子组件给父组件传递数据
			使用事件机制:子组件给父组件发送一个事件,携带上数据
		2、实现步骤
			1)子组件创建事件,并在事件中向父组件发送数据
				// 节点单击事件(节点数据对象,当前节点,节点组件本身)  
        nodeClick(data, node, component) {   
        	console.log(data, node, component);     
          // 子组件向父组件发送数据(事件名,任何数据...) 
          this.$emit("tree-node-click", data, node, component);  
        },
      2)父组件使用子组件的地方注册发送过来的事件名的事件,用来感知到子组件的事件
      	<category @tree-node-click="treeNodeClick"></category>
      	
      	// 感知子组件(树节点)被点击事件    
      	treeNodeClick(data, node, component) {   
        	console.log("感知子组件(树节点)被点击事件", data, node, component);    
          console.log(data.catId)  
        },

# 生命周期	
	-- created（）————在页面渲染之前执行
	-- mounted（）————在页面渲染之后执行
	-- 示例：
		new Vue({
			el: '#app',
			data: {
			},
			//在页面渲染之前执行            	
			created(){
				debugger
				console.log("created...")
			},
			//在页面渲染之后执行
			mounted(){
				debugger
				console.log("mounted...")
			}
		})

# 路由使用
	-- 引入js，在vue.js之后
		<script src="vue-router.min.js"></script>
	-- 编写Html
		<div id="app">
      <h1>Hello App!</h1>
      <p>
        <!-- 使用router-link组件来导航 -->
        <!-- 通过传入`to`属性指定链接 -->
        <!-- <router-link>默认会被渲染成一个`<a>`标签 -->
        <router-link to="/">首页</router-link>
        <router-link to="/student">学生管理</router-link>
        <router-link to="/teacher">教师管理</router-link>
      </p>
      <!-- 使用router-view定义路由出口，路由匹配到的组件将渲染在这里 -->
      <router-view></router-view>
		</div>
	-- 编写JS
		<script>
      // 1、定义路由组件，可以从其他文件import进来
      const Welcome={template:'<div>欢迎访问首页</div>'}
      const Student={template:'<div>Student list</div>'}
      const Teacher={template:'<div>Teacher list</div>'}
      // 2、定义路由，每个路由应该映射一个组件
      const routes=[
        {path:'/',redirect:'/welcome'},//设置默认指向的路径
        {path:'/welcome',component:Welcome},
        {path:'/student',component:Student},
        {path:'/teacher',component:Teacher},
      ]
      // 3、创建router实例，然后传入定义的路由配置
      const router=new VueRouter({
        routes
      })
      // 4、创建和挂载根实例
      const app=new Vue({
        el: '#app',
        data: {
        },
        router
      })
		</script>
	-- 实现数据回显
		1、回显处使用router-link组件来导航，通过传入`to`属性指定链接
			<!-- TODO:传值跳转 -->
			<router-link :to="`/teacher/edit/${scope.row.id}`">
        <el-button size="mini" icon="el-icon-edit" type="primary">编辑</el-button>
			</router-link>
		2、路由index页面中添加隐藏路由
			// 用于数据回显的编辑讲师路由
			{
				path: 'edit/:id',
				name: '编辑讲师',
				component: () => import('@/views/edu/teacher/save'),
				meta: { title: '编辑讲师', noCache: true },        		
				hidden: true
			}
		3、在api接口中创建获取回显数据的接口
			// 获取讲师信息
			getTeacherInfoById(id) {
				return request({
					url: `/edu_service/teacher/getTeacher/${id}`,
					method: 'get'
				})
			},
		4、在需要回显的页面调用接口，进行数据的回显
			 // 根据讲师id获取讲师信息    
			getEditTeacherInfoById(id) {
				teacher.getTeacherInfoById(id)
				.then(response => {
					this.teacherInfo = response.data.teacher
				})
				.catch(error => {
					this.$message({
						type: 'error',
						message: '获取信息失败!'
					})        
				})
			}
		5、如何判断是修改还是添加操作（两个页面公共时）
			// 根据路由参数重是否传入id参数,来判断是否为修改界面    
			if (this.$router.params && this.$router.params.id) {      
				const id = this.$$router.params.id
				this.getEditTeacherInfoById(id)
			}

# 使用问题解决
	-- 使用vue的监听解决数据回显问题
		//vue监听  
		watch: {
			//表示路由变化的方式 ：当路由发生变化，方法就会执行
			$$route(to, from) {
				this.init()
			}
		},
```



## 4、ElementUI

```javascript
1、说明
	基于Vue.js的后台组件库
2、官方地址
	https://element-plus.gitee.io/zh-CN/#/zh-CN/component/installation
```



## 5、Axios

```javascript
1、说明
	独立的项目，不是vue的一部分，使用axios经常和vue一起使用，实现ajax操作
2、普通使用
	# 引入vue.js和axios.js
		 <script src="vue.min.js"></script>
		 <script src="axios.min.js"></script>
	# 编写代码
		-- 创建json文件，创建模拟数据
    	{    
        "success":true,    
        "code":20000,    
        "message":"成功",    
        "data":{
          "items":[
            {"name":"lucky","age":20},
            {"name":"mary","age":50},
            {"name":"tom","age":35}
          ]    
        }
      }
		-- 使用axios发送ajax请求，请求文件，得到数据，在页面显示
    	<script>        
      	new Vue({
      		el: '#app',            
      		// 固定结构            
      		data: {// 定义变量和初始值
            // 定义变量
            userList:[]
          },
      		created(){// 页面渲染之前执行
            // 调用定义的方法
            this.getUserList()
          },
        	methods:{//编写具体的方法
            // 创建方法，查询所有用户数据
            getUserList(){
              // 使用axios发送ajax请求
              // axios.提交方式（"请求接口路径"）.then() .catch()
              axios.get("data.json")
              	// 请求成功执行then方法
                .then(response=>{//response就是请求之后返回的数据
                	this.userList = response.data.data.items
              	})
              	// 请求失败执行catch方法
                .catch(error=>{
                	console.log(error)
              	})
            }
          }
    		})
			</script>
3、封装使用
	-- 依赖下载
  	npm install axios
  -- 封装Axios
		-- src下创建一个utils文件夹
    -- 在文件夹中创建request.js文件，并添加如下内容:
    	// 引入axios组件
    	import axios from 'axios'
			// 创建axios实例
			const service = axios.create({  
        // api的base_url  
        BASE_API: '"http://localhost:9001"',  
        // 请求超时时间  
        timeout: 2000
      })
      // 让其可以被引用
      export default service、

```



## 6、Node.js

```bash
1、说明
	Node.js就是运行在服务端的JavaScript.JavaScript的运行环境，用于执行JavaScript代码的环境.
2、作用
	不需要浏览器，直接使用node.js运行JavaScript代码.模拟服务器效果，比如tomcat.
3、使用
	# 安装node.js,终端查看node -v
		-- 安装教程————https://www.runoob.com/nodejs/nodejs-install-setup.html
	# 使用node.js执行js代码
		终端进入当前js文件所在目录，使用node xxx.js，执行该js文件
	# 使用node.js模拟服务器效果
		-- 创建js文件，内容如下:
			const http=require("http");
			http.createServer(function(request,response){    
				// 发送HTTP头部    
				// Http状态值：200：OK    
				// 内容类型：text/plain    
				response.writeHead(200,{'Content-Type':'text/plain'});    
				// 发送响应数据 "Hello Server"    
				response.end('Hello Server');
				}).listen(8888);
				console.log('Server running at http://127.0.0.1:8888/')
		-- 使用如下命令在终端执行
			node xxx.js
	# vscode使用node.js问题
		-- 在vscode终端中使用node -v，没有出现版本号，解决方式如下:
			-- 关闭vscode
			-- 找到vscode运行文件，设置其属性为以管理员身份运行此程序
			-- 还是不行，先确定是否安装成功，不成功就卸载重装，确定成功就重启电脑
```



## 7、Npm

```bash
1、说明
	Node.js包管理工具，相当于后端的Maven
2、安装
	# 在进行安装node.js时会自动安装
	# 查看是否安装
		npm -v
3、使用
	# npm项目初始化操作
		-- 使用命令：npm init -y————[-y:全部使用默认值]
			-- 说明
				package name: (npmdemo)————项目名称
				version: (1.0.0)————项目版本号
				description:---项目描述
				entry point: (index.js)---项目入口
				test command:---测试的东西
				git repository:---git仓库
				keywords:---{Array}关键词，便于用户搜到项目
				author:---作者
				license: (ISC)
		-- 项目初始化之后，生成文件package.json,类似后端的pom.xml文件
	# 修改npm镜像仓库
		-- 原始仓库
			http://npmjs.com----"https://registry.npmjs.org/"
		-- 淘宝镜像
			http://npm.taobao.org/----"https://registry.npm.taobao.org"
		--切换命令
			npm config set registry https://registry.npm.taobao.org
		-- 查看配置信息
			npm config list
	# npm下载项目依赖包
		-- 执行命令
			npm install 依赖名称
		-- 示例
			//下载最新版本
			npm install jquery
			//下载指定版本
			npm install jquery@2.1.X
			//当前项目安装
			npm install --save-dev eslint
			npm install -D eslint
			//全局安装
			npm install -g webpack
			//更新/卸载包
			npm update/uninstall 包名
			//全局更新/卸载包
			npm update/uninstall -g 包名
		-- package-lock.json文件作用
			锁定可使用的版本
		-- 直接使用以下命令在当前文件目录执行,即可根据当前package.json文件下载依赖
			npm install
```



## 8、Babel

```bash
1、说明
	一个将ES6代码转换成ES5代码的转换器
2、安装
	npm install --global babel-cli
3、查看是否安装成功
	babel --version
4、使用
	# 创建JS文件,编写ES6格式文件
		let input =[1,2,3]
		input=input.map(item=>item+1)
		console.log(input)
	# 项目根目录创建.babelrc文件,用于设置转码规则和插件
		{    
			"presets": ["es2015"],    
			"plugins": []
		}
	# 安装转码器
		npm install --save-dev babel-preset-es2015
	# 使用命令进行转码
		-- 根据文件转码
			babel src/example.js --out-file dist1/compiled.js
			babel src/example.js -o dist1/compiled.js
		-- 根据文件夹转码
			babel src --out-dir dist2
			babel src -d dist2
```





## 9、模块化

```javascript
1、说明
	后端模块化————开发后端接口的时候，开发controller service mapper,controller注入service,service注入mapper。在后端中，类与类之间的调用称为后端模块化操作
	前端模块化————在前端中，js与js之间的调用称为前端模块化操作
2、实现
	# ES5实现步骤
		-- 创建model文件夹
		-- 添加被调用模块01.js
			// 创建js方法
    	const sum=function(a,b){    
        return parseInt(a)+parseInt(b)
      }
      const subtract=function(a,b){    
        return parseInt(a)-parseInt(b)
      }
      // 设置可被其他js调用的方法
      module.exports={    
        sun,
        subtract
      }
		-- 创建调用者
    	// 调用01.js方法
    	// 引入01.js文件【./】——当前目录，【../】——上层目录
    	const m=require('./01.js')
      console.log(m.sum(1,2))
			console.log(m.subtract(2,1))
		-- 测试
    	// 在终端当前目录运行以下命令
    	node 02.js
  # ES6实现步骤
  	-- 注意
    	使用es6写法实现模块化操作，在node.js环境中不能直接运行，需要使用babel将es6代码转换es5代码，才可以在node.js中进行运行
		-- 实现步骤
    	-- 文件01.js定义方法,设置那些方法可以被其他js调用
				export default{    
          getList(){
            console.log('getList......')
          },    
          save(){    
            console.log('save...')
          }
        }
			-- 文件02.js引入01.js进行调用
				// 写法一
				import {getList,save} from './01.js'
				console.log(getList())
				console.log(save())
				// 写法二
    		import m from './01.js'
				console.log(m.getList())
				console.log(m.save())
			-- 终端执行如下命令,将es6模块化的代码使用babel转换成es5的代码
      	babel 文件夹1 -d 文件夹2
      -- 测试
      	//在终端当前目录运行
      	node 02.js    
```



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
			npm install --save-dev style-loader @0.19.1 css-loader@0.28.3
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

