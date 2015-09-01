_ = require 'underscore'
URI = require 'URIjs'
data = require 'lib/config'

explode = (url) ->
    uri = URI url

    path = uri.segment()
    if path[0] == 'embed' or path[0] == 'embedder'
        path.shift()
    resource = path[0]
    id = path[1..]
    language = data.LANGUAGE[uri.subdomain()]
    query = uri.search true

    unless language
        if uri.hostname() == 'localhost'
            language = 'fi'
        else
            throw new ReferenceError "Unknown subdomain in #{uri.host()}"
    if resource == ""
        resource = null
    if id.length < 1
        id = null

    id: id
    language: language
    resource: resource
    query: query

transform = (url, {language: lang, query: query}) ->
    uri = URI url
    if lang?
        uri.subdomain data.SUBDOMAIN[lang]
    if query?
        delete query.ratio
        unless query.bbox?
            delete query.bbox
        if query.map?
            if query.map == 'servicemap'
                delete query.map
        uri.search joinQueries(query)
    uri.toString()

verify = (url) ->
    uri = URI url
    host = uri.hostname()
    query = uri.search true
    ratio = query.ratio
    delete query.ratio
    directory = uri.directory()
    directory = directory.replace data.BASE_URL, ''
    uri.directory directory
    uri.search query

    if host.match /^localhost/
        uri.port '9001'
        return url: uri.toString(), ratio: ratio
    result = false
    _.each data.SUBDOMAIN, (subdomain) =>
        if host == "#{subdomain}.#{data.DOMAIN}"
            result = uri.toString()
    url: result, ratio: ratio

module.exports =
    explode: explode
    transform: transform
    verify: verify

joinQueries = (query) ->
    for key, val of query
        if val instanceof Array
            query[key] = val.join ','
    query

