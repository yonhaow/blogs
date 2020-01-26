module.exports = {
  // 网站标题
  title: "Yonhaow's Blog",
  // 网站描述
  description: "今天不想做，所以才要做。  ------From 春上村树",
  // 打包目录
  dest: "./dist",
  // vuepress主题
  theme: "meteorlxy",
  // vuepress插件
  plugins: [
    // "@vuepress/active-header-links",
    // "@vuepress/back-to-top",
    "@vuepress/medium-zoom"
    // "@vuepress/nprogress"
  ],
  // 设置站点根路径，如果你在访问的地址是 'www.xxxx.com/wxDocs' 那么就设置成 '/wxDocs/'
  base: "/blogs",
  // 添加 github 链接，但是这个要放在公司的内网服务器，所以为空
  // repo: 'https://yonhaow.gitee.io/blogs/'
  // 网站语言
  // locales: {
  //   "/": {
  //     lang: "zh-CN"
  //   }
  // },
  head: [
    [
      "link",
      {
        rel: "icon",
        href: "/images/icon.jpg"
        // "https://blobs.officehome.msocdn.com/images/content/images/favicon-8f211ea639.ico"
      }
    ]
  ],
  // 主题设置
  themeConfig: {
    // 主题语言
    // lang: "zh-CN",
    lang: "en-US",

    // 个人信息（没有或不想设置的，删掉对应字段即可）
    personalInfo: {
      // 昵称
      nickname: "Yonhaow",

      // 个人简介 (支持 HTML)
      description: "Happy Coding<br/>Happy Life",

      // 电子邮箱
      email: "yonhaow@163.com",

      // 所在地
      location: "Xintai City, HeBei, China",

      // 组织
      organization: "Hebei Normal University",

      // 头像
      // 设置为外部链接
      // avatar: "https://www.meteorlxy.cn/assets/img/avatar.jpg",
      // 或者放置在 .vuepress/public 文件夹，例如 .vuepress/public/img/avatar.jpg
      avatar: "/images/avatar.jpg",

      // 社交平台帐号信息
      sns: {
        // Github 帐号和链接
        github: {
          account: "yonhaow",
          link: "https://github.com/yonhaow"
        },

        // 新浪微博 帐号和链接
        weibo: {
          account: "@小hao的也许",
          link: "https://weibo.com/u/5843973544"
        },

        // 知乎 帐号和链接
        zhihu: {
          account: "meteorlxy.cn",
          link: "http://www.zhihu.com/people/jia-zhuang-you-ge-hao-ming-zi"
        }
      }
    },

    // 上方 header 的相关设置
    header: {
      // header 的背景，可以使用图片，或者随机变化的图案（geopattern）
      background: {
        // 使用图片的 URL，如果设置了图片 URL，则不会生成随机变化的图案，下面的 useGeo 将失效
        url: "/images/background.jpg",
        // 使用随机变化的图案，如果设置为 false，且没有设置图片 URL，将显示为空白背景
        useGeo: true
      },

      // 是否在 header 显示标题
      showTitle: true
    },

    // 底部 footer 的相关设置
    footer: {
      // 是否显示 Powered by VuePress
      poweredBy: true,

      // 是否显示使用的主题
      poweredByTheme: true,

      // 添加自定义 footer (支持 HTML)
      custom:
        'Copyright 2020-present <a href="https://github.com/yonhaow" target="_blank">Yonhaow</a> | MIT License'
    },

    // 个人信息卡片相关设置 (可选)
    infoCard: {
      // 卡片 header 的背景，可以使用图片，或者随机变化的图案（geopattern）
      headerBackground: {
        // 使用图片的 URL，如果设置了图片 URL，则不会生成随机变化的图案，下面的 useGeo 将失效
        // url: '/assets/img/bg.jpg',

        // 使用随机变化的图案，如果设置为 false，且没有设置图片 URL，将显示为空白背景
        useGeo: true
      }
    },

    // 是否显示文章的最近更新时间
    lastUpdated: true,

    // 侧边栏 自动生成
    sidebar: "auto",
    // 侧边栏 标题嵌套层级
    sidebarDepth: 2,

    // 导航栏配置
    nav: [
      { text: "Home", link: "/", exact: true },
      { text: "Archives", link: "/archives/" },
      { text: "Posts", link: "/posts/" }
      // { text: "Daily", link: "/daily/" }
    ],

    // 评论配置 管理
    comments: false,

    // 分页配置
    pagination: {
      perPage: 5
    },

    // 默认页面
    defaultPages: {
      // 是否允许主题自动添加 Home 页面 (url: /)
      home: true,
      // 是否允许主题自动添加 Posts 页面 (url: /posts/)
      posts: true
    }
  }
};
