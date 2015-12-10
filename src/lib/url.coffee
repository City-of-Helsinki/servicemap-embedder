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
        if query.city?
            if query.city == 'all'
                delete query.city
        uri.search joinQueries(query)
    uri.toString()

strip = (url, parameters) ->
    unless parameters.resource?
        return url

    if parameters.query.bbox?
        delete parameters.query.bbox
    uri = URI url
    query = uri.search true
    if query.bbox?
        delete query.bbox
    uri.search query
    uri.toString()

IE_FAULTY_URL = /#(.*[\/\?].*)+$/

verify = (url) ->
    uri = URI url
    # Internet Explorer < 10 emits
    # faulty URL paths.
    fragmentSearch = null
    if url.search(IE_FAULTY_URL) > 0
        fragment = uri.fragment()
        fragmentUri = URI fragment
        fragmentSearch = fragmentUri.search true
        fragmentUri.search ''
        pathname = uri.pathname() + fragmentUri.toString()
        uri.fragment ''
           .pathname pathname
    host = uri.hostname()
    query = uri.search true
    if fragmentSearch?
        query = _.defaults query, fragmentSearch
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
    strip: strip

joinQueries = (query) ->
    for key, val of query
        if val instanceof Array
            query[key] = val.join ','
    query

