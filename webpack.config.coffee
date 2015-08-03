HtmlWebpackPlugin = require 'html-webpack-plugin'
webpack = require 'webpack'
module.exports =
  context: __dirname + '/src'
  entry: './app/main.coffee'
  output:
    path: __dirname + '/dist'
    filename: 'bundle.js'
  resolve:
    root: [__dirname + '/src/', __dirname + '/node_modules']
    extensions: ["", ".webpack.coffee", ".web.js", ".js", ".coffee"]
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
        }
    ]
  plugins: [
    new HtmlWebpackPlugin title: 'React Webpack and Mocha starter'
  ]
  node:
    console: 'empty',
    fs: 'empty',
    net: 'empty',
    tls: 'empty'
  target: 'node'
