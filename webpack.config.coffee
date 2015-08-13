HtmlWebpackPlugin = require 'html-webpack-plugin'
webpack = require 'webpack'
glob = require("glob")
module.exports =
  context: __dirname + '/src'
  entry:
    app: './app/main.coffee'
    test: glob.sync(__dirname + "/test/*.coffee")

  output:
    path: __dirname + '/dist'
    filename: '[name].js'

  resolve:
    root: [
        __dirname + '/src/',
        __dirname + '/node_modules']
    extensions: [
        "",
        ".webpack.coffee",
        ".web.js",
        ".js",
        ".coffee",
        ".cjsx"
    ]

  module:
    devtool: 'source-map',
    loaders: [
        {
          test: /\.json$/,
          loader: 'json'
        },
        {
          test: /\.coffee$/
          loader: 'coffee-loader'
        },
        {
          test: /\.cjsx$/,
          loaders: ['coffee', 'cjsx']
        }
    ]

  plugins: [
    new HtmlWebpackPlugin
        chunks: ['app']
        title: 'Servicemap embedding preview'
  ]
