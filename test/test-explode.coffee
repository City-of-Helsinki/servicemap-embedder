chai = require 'chai'
_ = require 'underscore'
smurl = require 'lib/url'
expect = chai.expect

CORRECT_URLS =
    fi: [
        'http://palvelukartta.hel.fi/',
        'http://palvelukartta.hel.fi/unit/1',
        'http://palvelukartta.hel.fi/division/helsinki/kaupunginosa:kallio',
    ],
    sv: [
        'http://servicekarta.hel.fi/',
        'http://servicekarta.hel.fi/unit/1',
        'http://servicekarta.hel.fi/division/helsinki/kaupunginosa:kallio',
    ],
    en: [
        'http://servicemap.hel.fi/',
        'http://servicemap.hel.fi/unit/1',
        'http://servicemap.hel.fi/division/helsinki/kaupunginosa:kallio',
    ]

describe 'Exploding an URI', ->
    it 'should generate a correct object with language detected', ->
        for lang in ['fi', 'sv', 'en']
            for url in CORRECT_URLS[lang]
                result = smurl.explode url
                expect(result).to.be.an 'object'
                expect(result).to.have.a.property 'language'
                expect(result.language).to.equal lang

    it 'should detect the correct resource', ->
        result = smurl.explode 'http://palvelukartta.hel.fi/unit/1'
        expect(result.resource).to.equal 'unit'
        result = smurl.explode 'http://servicekarta.hel.fi/'
        expect(result.resource).to.equal null
        result = smurl.explode 'http://palvelukartta.hel.fi'
        expect(result.resource).to.equal null
        result = smurl.explode 'http://servicemap.hel.fi/division?ocd_id=any'
        expect(result.resource).to.equal 'division'
        result = smurl.explode 'http://servicemap.hel.fi/address/helsinki/mannerheimintie/5'
        expect(result.resource).to.equal 'address'

    it 'should throw for an unknown subdomain', ->
        f = ->
            smurl.explode 'https://news.ycombinator.com/'
        expect(f).to.throw(ReferenceError)
        f = ->
            smurl.explode 'https://news.hel.fi'
        expect(f).to.throw(ReferenceError)

    it 'should extract query parameter filters correctly', ->
        url = 'http://palvelukartta.hel.fi/bing/bong?level=all&bbox=253,235,235,2'
        result = smurl.explode url
        expect(result.query).to.be.an 'object'
        expect(result.query).to.have.a.property 'level'
        expect(result.query).to.have.a.property 'bbox'
        expect(_.size(result.query)).to.equal 2

    it 'should extract any multi part id correctly', ->
        url = 'http://servicekarta.hel.fi/address/helsinki/mannerheimintie/5'
        result = smurl.explode url
        expect(result.resource).to.equal 'address'
        expect(result.id).to.deep.equal ['helsinki', 'mannerheimintie', '5']
        url = 'http://servicemap.hel.fi/unit?service=1'
        result = smurl.explode url
        expect(result.id).to.equal null
