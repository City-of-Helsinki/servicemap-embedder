define ["chai", "underscore", "lib/servicemap-embed"], (chai, _, embed) ->
    expect = chai.expect

    PROTOCOL = 'http'
    EXAMPLE_OPTIONS =
        language: 'fi',
        type: 'single-unit'
        spec: id: 1
    CORRECT_UNIT_IDS = (x for x in [1..2000] by 564)
    FAULTY_UNIT_IDS = [-1, 'a word', undefined, null, {}]

    describe 'Embedding a single unit', ->
        it 'should generate a correct URL for valid parameters', ->
            for uid in CORRECT_UNIT_IDS
                opts =
                    language: 'fi',
                    type: 'single-unit',
                    spec: id: uid
                result = "#{PROTOCOL}://palvelukartta.hel.fi/embed/unit/#{uid}/"
                expect(embed.url(opts)).to.equal result

        it 'should throw for incorrect unit ids', ->
            for uid in FAULTY_UNIT_IDS
                opts =
                    language: 'fi',
                    type: 'single-unit',
                    spec: id: uid
                result = "#{PROTOCOL}://palvelukartta.hel.fi/embed/unit/#{uid}/"
                expect(-> embed.url(opts)).to.throw(Error)

    describe 'Generating embedding properties', ->
        it 'should work for the default options for a single unit', ->
            expect(embed.embedProperties(EXAMPLE_OPTIONS)).to.deep.equal
                frameborder: 0
                src: "#{PROTOCOL}://palvelukartta.hel.fi/embed/unit/1/",
                style:
                    'width': '100%',
                    'min-height': '400px'
