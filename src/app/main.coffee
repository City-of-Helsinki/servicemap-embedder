_ = require 'underscore'
React = require 'react'
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
url = smurl.verify UNIT_URL
#url = smurl.verify BBOX_URL
parameters = smurl.explode url

props =
    url: url
    initialBbox: parameters.query.bbox
    parameters: parameters

appInit = (lang) =>
    props.lang = lang
    React.render React.createElement(Root, props), div

props.appReset = appInit

silentErrorHandler = => true
window.onerror=silentErrorHandler

lang = 'fi'
i18n.init lang, appInit
