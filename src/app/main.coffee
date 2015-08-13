_ = require 'underscore'
React = require 'react'
i18n = require 'lib/i18n'

require '../../vendor/stylesheets/hel-bootstrap.min.css'

smurl = require 'lib/url'
config = require 'lib/config'
Root = require 'app/root'

div = document.createElement('div')
document.body.appendChild div

props = {}
appInit = =>
    React.render React.createElement(Root, props), div

props.appReset = appInit

i18n.init appInit
