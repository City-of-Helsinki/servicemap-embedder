React = require 'react/addons'
RB = require 'react-bootstrap'
ServiceMapIframe = require 'app/embed-iframe'
ServiceMapEmbedControls = require 'app/embed-controls'
EmbedHeader = require 'app/embed-header'
config = require 'lib/config'
smurl = require 'lib/url'
URI = require 'URIjs'
{t: t} = require 'lib/i18n'
_ = require 'underscore'
i18next = require 'i18next-client'

APP_ROOT = '/'

update = React.addons.update

Root = React.createClass
    changeLanguage: (lng) ->
        i18next.setLng lng, => @props.appReset lng

    getInitialState: ->
        url: @props.url
        parameters: @props.parameters
        iframeConfig: config.DEFAULT_IFRAME_PROPERTIES
        iframeSource: null

    receiveAdjustments: (key, value) ->
        @setState (prevState, props) =>
            prevParameters = prevState.parameters
            parameters = switch key
                when 'bbox'
                    bbox = if value == true then props.initialBbox else null
                    update prevParameters, {query: {bbox: {$set: bbox}}}
                when 'level'
                    update prevParameters, {query: {level: {$set: value}}}
                when 'language'
                    update prevParameters, {language: {$set: value}}
            url: smurl.transform prevState.url, parameters
            parameters: parameters

    renderStyle: (style) ->
        "width:#{style.width}; min-height:#{style.minHeight}; border:none;"
    iframeHtml: (url, style) ->
        __html: """
            <iframe src="#{@embedUrl url}"
            style="#{@renderStyle style}"></iframe>"""

    getResource: ->
        @state.parameters.resource

    renderLanguages: (lang) ->
        <RB.Nav activeKey={lang} right>
        {
            _.map config.LANGUAGES, (v, k) =>
                <RB.NavItem
                   className='language-nav'
                   key={k}
                   href="#!"
                   eventKey={k}
                   onClick={@changeLanguage.bind(@, k)}>{v}</RB.NavItem>
        }
        </RB.Nav>

    embedUrl: (url) ->
        uri = URI url
        uri.segment _.union(['embed'], uri.segment())
        URI.decode uri

    selectText: ->
        React.findDOMNode(@refs.url).select()

    render: ->
        if not @state.url
            return false
        <div>

          <RB.Navbar inverse brand={t 'page.header'}>
            <p className="lead"></p>
            {@renderLanguages @props.lang}
          </RB.Navbar>

          <div className='container'>

            <ServiceMapIframe html={@iframeHtml(@state.url, @state.iframeConfig.style)}/>

            <EmbedHeader
              resource={@getResource()}
              resourceId={@state.parameters.id}
              query={@state.parameters.query} />

            <RB.Panel bsStyle='success'>
                <RB.Panel>
                  <h3>Osoite</h3>
                  <input
                      readOnly
                      type="text"
                      style={width: '100%'}
                      ref="url"
                      onClick={@selectText}
                      className='parameter-help'
                      value={@embedUrl @state.url} />
                </RB.Panel>
                <ServiceMapEmbedControls
                    language = {@state.parameters.language}
                    resource = {@getResource()}
                    bbox = {'bbox' of @state.parameters.query}
                    level = {@state.parameters.query.level or 'none'}
                    parameters = {@state.parameters}
                    onChange = {@receiveAdjustments} />
                <pre>
                    {@iframeHtml(@state.url, @state.iframeConfig.style).__html}
                </pre>
            </RB.Panel>
          </div>
        </div>

module.exports = Root
