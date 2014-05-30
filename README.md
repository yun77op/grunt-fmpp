# grunt-fmpp

> 用于freemarker模板转换成html的grunt插件。

本grunt插件用于把freemarker模板转换成html，本质上是调用fmpp这个工具，fmpp官网下的程序是不支持模板中的java调用的，所以使用了同事修改过的fmpp_heroyang.jar。

得益于grunt的生态，可以把grunt-fmpp这个任务和watch及connect一起使用，构建前端模拟开发环境

## The "fmpp" task

### Options

#### options.appDir
Type: `String`

应用目录

#### options.lib
Type: `String`

自定义的Java库目录

### Usage Examples

#### 配置fmpp

fmpp的示例配置在`example/fmpp`下有`config.fmpp`和`fmpp.properties`两个文件

 - `config.fmpp`, fmpp的主配置文件，比如配置模板的目录`sourceRoot`，其他配置参考[fmmp文档](http://fmpp.sourceforge.net/settings.html)
 - `fmpp.properties`, 包含在模板中调用的java类映射

#### 配置grunt-fmpp

```js
grunt.initConfig({
  fmpp: {
    dev: {
      options: {
        appDir: 'example/fmpp',
        lib: 'example/fmpp/lib'
      }
    }
  },
});
```


## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/).