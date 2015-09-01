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
    BACKGROUND_MAPS: ['servicemap', 'ortographic', 'accessible_map']
    DEFAULT_IFRAME_PROPERTIES:
        style:
            width: '100%'
            height: '100%'
        frameBorder: 0
    DEFAULT_CUSTOM_WIDTH: '400'
    BASE_URL: '/embedder'
