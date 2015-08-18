define (require) ->
    _ = require 'underscore'
    SUBDOMAIN =
        fi: 'palvelukartta'
        sv: 'servicekarta'
        en: 'servicemap'
    DOMAIN: 'hel.fi'
    SUBDOMAIN: SUBDOMAIN
    LANGUAGE: _.invert SUBDOMAIN
    LANGUAGES:
        en: 'english'
        sv: 'svenska'
        fi: 'suomi'
    DEFAULT_IFRAME_PROPERTIES:
        style:
            width: '100%'
            minHeight: '400px'
        frameBorder: 0
