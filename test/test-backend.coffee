define ["chai", "underscore", "lib/servicemap-backend"], (chai, _, backend) ->
    expect = chai.expect

    PROTOCOL = 'http'
    EXAMPLE_OPTIONS =
        language: 'fi',
        type: 'single-unit'
        spec: id: 1
    CORRECT_UNIT_IDS = (x for x in [1..2000] by 564)
    FAULTY_UNIT_IDS = [-1, 'a word', undefined, null, {}]

    describe 'Requesting autocomplete results', ->
        result = null

        it 'should give well formed results', (done) ->
            backend.autocompleteUnit 'fi', 'kal', (obj) ->
                unless obj?
                    err = new Error 'No results got from the backend.'
                unless (
                    obj.count? and
                    obj.results? and
                    obj.results?.length?
                )
                    err = new Error 'Malformed results', obj
                done err
