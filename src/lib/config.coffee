define (require) ->
    _ = require 'underscore'
    SUBDOMAIN =
        fi: 'palvelukartta'
        sv: 'servicekarta'
        en: 'servicemap'
    DOMAIN: 'hel.fi'
    SUBDOMAIN: SUBDOMAIN
    LANGUAGE: _.invert SUBDOMAIN
    DEFAULT_IFRAME_PROPERTIES:
        style:
            width: '100%'
            minHeight: '400px'
        frameBorder: 0
