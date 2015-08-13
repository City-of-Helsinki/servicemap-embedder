URI = require 'URIjs'
data = require 'lib/config'

explode = (url) ->
    uri = URI url

    path = uri.segment()
    resource = path[0]
    id = path[1..]
    language = data.LANGUAGE[uri.subdomain()]
    query = uri.search true

    unless language
        throw new ReferenceError "Unknown subdomain in #{uri.host()}"
    if resource == ""
        resource = null

    id: id
    language: language
    resource: resource
    query: query

transform = (url, {language: lang, query: query}) ->
    uri = URI url
    if lang?
        uri.subdomain data.SUBDOMAIN[lang]
    if query?
        uri.search joinQueries(query)
    uri.toString()

module.exports =
    explode: explode
    transform: transform

joinQueries = (query) ->
    for key, val of query
        if val instanceof Array
            query[key] = val.join ','
    query

