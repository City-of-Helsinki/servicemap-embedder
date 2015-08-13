React = require 'react'
RB = require 'react-bootstrap'
ServiceMapIframe = require 'app/embed-iframe'
ServiceMapEmbedControls = require 'app/embed-controls'
config = require 'lib/config'
url = require 'lib/url'
{t: t} = require 'lib/i18n'
_ = require 'underscore'
i18next = require 'i18next-client'

APP_ROOT = '/'

Root = React.createClass
    changeLanguage: (lng) ->
        i18next.setLng lng, => @props.appReset()
    render: ->
        if not @state.url
            return false
        <div>
          <RB.Navbar>
            <RB.PageHeader>{t 'page.header'}</RB.PageHeader>
            <p className="lead"></p>
            <a onClick={@changeLanguage.bind(null, 'fi')}>suomi</a>
            <a onClick={@changeLanguage.bind(null, 'sv')}>svenska</a>
            <a onClick={@changeLanguage.bind(null, 'en')}>English</a>
          </RB.Navbar>
          <div className='container'>
            <RB.Panel header='Osoite' bsStyle='primary'>{@state.url}</RB.Panel>
            <ServiceMapIframe
                url            = {@state.url}
                style          = {@state.iframeConfig.style}
                frameBorder    = {@state.iframeConfig.frameBorder}
                src            = {@state.url}
                onHtmlRendered = {@onIframeHtmlRendered}>
            </ServiceMapIframe>
            <RB.Panel header='Asetukset' bsStyle='primary'><ServiceMapEmbedControls /></RB.Panel>
            <RB.Panel header='Upotuskoodi' bsStyle='primary'><pre>{@state.iframeSource}</pre></RB.Panel>
        </div></div>
    getInitialState: ->
        url: "http://palvelukartta.hel.fi/embed?bbox=60.263,24.8776,60.2738,24.9&level=all"#url.verify document.referrer
        iframeConfig: config.DEFAULT_IFRAME_PROPERTIES
        iframeSource: null
    onIframeHtmlRendered: (html) ->
        console.log html
        @setState iframeSource: html

module.exports = Root
