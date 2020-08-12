本项目是一个基于开源项目Vblog的二次开发。

# 项目效果

是一个类似简书的小论坛，用户可以注册，可以登录，可以写博客让别的用户看，也可以进行实时评论的项目。

# 快速运行  

1.克隆本项目到本地  

```
git@github.com:lenve/VBlog.git
```

2.在根目录下找到sql语句，在MySQL数据库中执行  
3.根据自己本地情况修改数据库配置，数据库配置在SpringBoot项目的application.properties中  
4.在IntelliJ IDEA中运行blogserver项目  

5.进入到vueblog目录中，在命令行依次输入如下命令：  

```
# 安装依赖
npm install

# 在 localhost:8080 启动项目
npm run dev
```

之后在localhost:8080即可访问到项目了。

6.最后可以用WebStorm等工具打开vueblog项目，继续开发，开发完成后，当项目要上线时，依然进入到vueblog目录，然后执行如下命令：  

```
npm run build
```

该命令执行成功之后，vueblog目录下生成一个dist文件夹，将该文件夹中的两个文件static和index.html拷贝到SpringBoot项目中resources/static/目录下，然后就可以像第4步那样直接访问了。  


