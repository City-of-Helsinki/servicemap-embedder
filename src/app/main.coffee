_ = require 'underscore'
React = require 'react'

smurl = require 'lib/url'
config = require 'lib/config'
ServiceMapIframe = require 'app/embed-iframe'

div = document.createElement('div')
document.body.appendChild div

React.render React.createElement(
    ServiceMapIframe, config.DEFAULT_IFRAME_PROPERTIES), div
