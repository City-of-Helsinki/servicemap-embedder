chai = require 'chai'
_ = require 'underscore'
smurl = require 'lib/url'
expect = chai.expect
URI = require 'URIjs'

CORRECT_URLS =
    fi: [
        'http://palvelukartta.hel.fi/',
        'http://palvelukartta.hel.fi/unit/1',
        'http://palvelukartta.hel.fi/division/helsinki/kaupunginosa:kallio',
        '''http://palvelukartta.hel.fi/
           division?ocd_id=helsinki%2Fkaupunginosa:kallio,
           helsinki%2Fkaupunginosa:sörnäinen'''
    ],
    sv: [
        'http://servicekarta.hel.fi/',
        'http://servicekarta.hel.fi/unit/1',
        'http://servicekarta.hel.fi/division/helsinki/kaupunginosa:kallio',
    ],
    en: [
        'http://servicemap.hel.fi/',
        'http://servicemap.hel.fi/unit/1',
        '''http://servicemap.hel.fi/division/helsinki/
           kaupunginosa:kallio?level=all&bbox=1,2,3,4''',
    ]

describe 'Transforming a URL', ->
    it 'should return an identical URL with identical parameters', ->
        for lang in ['fi', 'sv', 'en']
            for url in CORRECT_URLS[lang]
                parameters = smurl.explode url
                transformed = smurl.transform url, parameters
                expect(URI(transformed).equals(url)).to.be.ok

    it 'should include new query parameters in the URL', ->
        uri = URI smurl.transform('http://palvelukartta.hel.fi/unit/1',
            query: bbox: '1,2,3,4'
        )
        expect(uri.equals('http://palvelukartta.hel.fi/unit/1?bbox=1,2,3,4')).to.be.ok
        uri = URI smurl.transform(
            'http://palvelukartta.hel.fi/division/helsinki/kaupunginosa:kallio',
            query: level: 'none'
        )
        newUrl = '''
            http://palvelukartta.hel.fi/division/\
            helsinki/kaupunginosa:kallio?level=none
            '''
        expect(uri.equals(newUrl)).to.be.ok

    it 'should replace modified query parameters in the URL', ->
        uri = URI smurl.transform(
            'http://servicekarta.hel.fi/address/espoo/olarintie/1?level=all&bbox=foo',
            query:
                level: 'none',
                bbox: 'bar'
        )
        newUrl = 'http://servicekarta.hel.fi/address/espoo/olarintie/1?level=none&bbox=bar'
        expect(uri.equals(newUrl)).to.be.ok

    it 'should append appended query parameters in the URL', ->
        uri = URI smurl.transform(
            'http://palvelukartta.hel.fi/division?ocd_id=helsinki%2Fkaupunginosa:kallio',
            query:
                ocd_id: ['helsinki/kaupunginosa:kallio', 'helsinki/kaupunginosa:sörnäinen']
        )
        newUrl = '''
            http://palvelukartta.hel.fi/division?ocd_id=helsinki%2Fkaupunginosa:kallio,\
            helsinki%2Fkaupunginosa:sörnäinen'''
        expect(uri.equals(newUrl)).to.be.ok

    it 'should delete removed query parameters from the URL', ->
        uri = URI smurl.transform(
            'http://servicemap.hel.fi/address/vantaa/tikkuraitti/13?bbox=valueOfBbox&level=all',
            query:
                level: 'all'
        )
        newUrl = 'http://servicemap.hel.fi/address/vantaa/tikkuraitti/13?level=all'
        expect(uri.equals(newUrl)).to.be.ok
