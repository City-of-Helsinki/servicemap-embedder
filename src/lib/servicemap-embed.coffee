define ['underscore', 'lib/servicemap-backend'], (_, smBackend) ->

    DOMAIN = 'hel.fi'
    SUBDOMAIN =
        fi: 'palvelukartta'
        sv: 'servicekarta'
        en: 'servicemap'
    RESOURCE =
        'single-unit': 'unit'
        'division-units': 'unit'
        'rectangular-area': 'area'
    DEFAULT_STYLE =
        'width': "100%"
        'min-height': '400px'

    isValidId = (i) ->
        (i? and Number.isInteger(i) and i > 0)

    baseUrl: (language) ->
        "http://#{SUBDOMAIN[language]}.#{DOMAIN}/embed"

    path:
        'single-unit': (spec) ->
            unless spec?
                throw new TypeError 'No valid spec received'
            unless isValidId spec.id
                throw new TypeError 'Unit ids should be integers'
            return spec.id

    url: (language: language, type: type, spec: spec) ->
        result = [
            @baseUrl(language), RESOURCE[type],
            @path[type](spec)].join '/'
        "#{result}/"

    embedProperties: (options) ->
        src: @url(options),
        style: (options.style or DEFAULT_STYLE),
        frameborder: 0
