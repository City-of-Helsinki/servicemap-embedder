define ['underscore', 'request'], (_, request) ->

    BACKEND_ROOT = 'http://api.hel.fi/servicemap/v1'

    backendUrl = (path) ->
        result = [BACKEND_ROOT, path...].join '/'
        "#{result}/"

    autocompleteUnit: (language, input, onSuccess) ->
        url = backendUrl ['search']
        cb = (err, res, body) ->
            if !err and res.statusCode == 200
                res = JSON.parse(body)
                onSuccess res
            else
                throw new Error 'network error', err

        query =
            input: input,
            lang: language,
            page_size: 4
            only: 'unit.name'
        request {url: url, qs: query}, cb
