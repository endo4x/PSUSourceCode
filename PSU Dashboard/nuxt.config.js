import webpack from 'webpack'

const commitHash = require('child_process')
  .execSync('git rev-parse HEAD')
  .toString()

export default {
  // Global page headers (https://go.nuxtjs.dev/config-head)
  head: {
    title: 'PSU',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Perth Scripting Utilities, providing the best tool for scripters since 2020.' },
      { name: 'keywords', content: 'Perth Scripting Utilities, PSU, psu.dev, Lua Obfuscator, lua, obfuscator, roblox lua, perth' },
      { name: 'theme-color', content: '#0A5235' }

    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/psu_icon.png' }]
  },
  ssr: false,

  build: {
    plugins: [
      new webpack.DefinePlugin({
        __COMMIT_HASH__: JSON.stringify(commitHash),
        __COMPILED_WITH__: JSON.stringify(process.platform),
        __COMPILED_AT_: JSON.stringify(new Date().toISOString().slice(0, 19).replace(/-/g, '/').replace('T', ' '))
      })
    ],
    extend: (config, ctx) => {
      // Process our web-workers.
      if (ctx.isClient) {
        config.module.rules.push({
          test: /\.worker\.js$/,
          loader: 'worker-loader',
          exclude: /(node_modules)/
        })
      }

      const svgRule = config.module.rules.find(rule => rule.test.test('.svg'))

      svgRule.test = /\.(png|jpe?g|gif|webp)$/

      config.module.rules.push({
        test: /\.svg$/,
        use: [
          'babel-loader',
          'vue-svg-loader'
        ]
      })
    }
  },

  // Global CSS (https://go.nuxtjs.dev/config-css)
  css: [
    '@/assets/css/colours.css',
    '@/assets/css/core.css',
    '@/assets/css/pageCommon.scss',
    'vue-select/dist/vue-select.css'
  ],

  // Plugins to run before rendering page (https://go.nuxtjs.dev/config-plugins)
  plugins: [
    '~/plugins/clickOutside.js',
    '~/plugins/projectAPI.js',
    '~/plugins/workers/workerManager.js',
    '~/plugins/tippyGlobal.js',
    '~/plugins/fontAwesome.js',
    '~/plugins/vueSelect.js'
  ],

  // Auto import components (https://go.nuxtjs.dev/config-components)
  components: true,

  recaptcha: {
    siteKey: '6LeVOA0aAAAAAG6jonMq5dCph4sJlTOWB02RCiea',
    version: 2
  },

  // Modules (https://go.nuxtjs.dev/config-modules)
  modules: [
    '@nuxtjs/recaptcha'
  ]
}
