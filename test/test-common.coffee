define ["chai", "underscore", "lib/servicemap-embed"], (chai, _, embed) ->
    expect = chai.expect

    PROTOCOL = 'http'
    EXAMPLE_OPTIONS =
        language: 'fi',
        type: 'single-unit'
        spec: id: 1

    describe 'Passing language parameters to baseUrl', ->
        RESULTS =
            fi: 'palvelukartta.hel.fi',
            sv: 'servicekarta.hel.fi',
            en: 'servicemap.hel.fi'

        it 'should generate language specific URLs', ->
            for lang, result of RESULTS
                expect(embed.baseUrl(lang)).to.equal "#{PROTOCOL}://#{result}/embed"

    describe 'Generating urls', ->
        it 'should generate only URLs ending in /', ->
            expect(embed.url EXAMPLE_OPTIONS).to.match /\/$/
