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
        __dirname + '/node_modules',
        __dirname + '/vendor/styles']
    extensions: [
        "",
        ".css",
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
        },
        { test: /\.css$/, loader: "style-loader!css-loader" },
      #{ test: /\.woff$/,   loader: "url-loader?limit=10000&mimetype=application/font-woff" },
      { test: /\.woff$/,   loader: "file-loader" },
            { test: /\.woff2$/,   loader: "file-loader" },
      { test: /\.ttf$/,    loader: "file-loader" },
      { test: /\.eot$/,    loader: "file-loader" },
      { test: /\.svg$/,    loader: "file-loader" }
    ]

  plugins: [
    new HtmlWebpackPlugin
        chunks: ['app']
        title: 'Servicemap embedding preview'
  ]
