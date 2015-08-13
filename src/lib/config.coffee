define (require) ->
    _ = require 'underscore'
    SUBDOMAIN =
        fi: 'palvelukartta'
        sv: 'servicekarta'
        en: 'servicemap'
    SUBDOMAIN: SUBDOMAIN
    LANGUAGE: _.invert SUBDOMAIN
    DEFAULT_IFRAME_PROPERTIES:
        style:
            'width': "100%"
            'min-height': '400px'
        frameborder: 0
