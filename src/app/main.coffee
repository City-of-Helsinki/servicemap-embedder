_ = require 'underscore'
React = require 'react'
ReactDOM = require 'react-dom'
i18n = require 'lib/i18n'
smurl = require 'lib/url'
URI = require 'URIjs'

require '../../vendor/stylesheets/hel-bootstrap.min.css'

smurl = require 'lib/url'
config = require 'lib/config'
Root = require 'app/root'

div = document.createElement('div')
document.body.appendChild div

# SERVICE_URL = "http://palvelukartta.hel.fi/unit?service=33423"
# UNIT_URL = "http://palvelukartta.hel.fi/unit/8215"
# ADDRESS_URL = "http://palvelukartta.hel.fi/address/helsinki/lontoonkatu/6"
# BBOX_URL = "http://palvelukartta.hel.fi/?bbox=60.201456226,24.8981159927,60.190874505,24.8834907630&level=none"
SERVICE_URL = "http://localhost:9001/unit?service=33423"
UNIT_URL = "http://localhost:9001/unit/8215"
ADDRESS_URL = "http://localhost:9001/address/helsinki/lontoonkatu/6"
BBOX_URL = "http://localhost:9001/?bbox=60.201456226,24.8981159927,60.190874505,24.8834907630&level=none"
#url = smurl.verify SERVICE_URL
#url = smurl.verify ADDRESS_URL
#url = smurl.verify UNIT_URL
#url = smurl.verify BBOX_URL
{url: url, ratio: ratio} = smurl.verify window.location.href
parameters = smurl.explode url
url = smurl.strip url, parameters
initialRatio = if ratio? then ratio else 62

props =
    url: url
    initialBbox: unless parameters.resource? then parameters.query.bbox
    initialRatio: initialRatio
    parameters: parameters

appInit = (lang) =>
    props.lang = lang
    rootEl = React.createElement(Root, props)
    ReactDOM.render rootEl, div

props.appReset = appInit

lang = 'fi'
i18n.init lang, appInit
