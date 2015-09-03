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
cx = require 'classnames'

APP_ROOT = '/'

update = React.addons.update

Root = React.createClass
    changeLanguage: (lng) ->
        i18next.setLng lng, => @props.appReset lng

    getInitialState: ->
        url: @props.url
        parameters: @props.parameters
        iframeConfig: config.DEFAULT_IFRAME_PROPERTIES
        customWidth: config.DEFAULT_CUSTOM_WIDTH
        heightMode: 'ratio'
        fixedHeight: config.DEFAULT_CUSTOM_WIDTH
        ratioHeight: @props.initialRatio

    receiveAdjustments: (key, value) ->
        @setState (prevState, props) =>
            if key == 'width'
                if value == 'full'
                    width = '100%'
                else
                    width = prevState.customWidth
                return update prevState, {iframeConfig: {style: {width: {$set: width}}}}
            if key == 'height'
                return update prevState, {heightMode: {$set: value}}
            prevParameters = prevState.parameters
            parameters = switch key
                when 'bbox'
                    bbox = if value == true then props.initialBbox else null
                    update prevParameters, {query: {bbox: {$set: bbox}}}
                when 'level'
                    update prevParameters, {query: {level: {$set: value}}}
                when 'language'
                    update prevParameters, {language: {$set: value}}
                when 'map'
                    update prevParameters, {query: {map: {$set: value}}}
            url: smurl.transform prevState.url, parameters
            parameters: parameters

    renderWrapperStyle: (style) ->
        "position: relative; width:100%; padding-bottom:#{@state.ratioHeight}%;"
    iframeHtml: (url, style) ->
        if @state.heightMode == 'fixed'
            height = @state.fixedHeight
        if @state.heightMode == 'ratio'
            if @state.iframeConfig.style.width == '100%'
                html = """<div style="#{@renderWrapperStyle style}">
                   <iframe style="position: absolute; top: 0; left: 0; border: none; width: 100%; height: 100%;"
                   src="#{@embedUrl url}"></iframe></div>"""
            else
                height = parseInt(parseInt(@state.customWidth) * (parseInt(@state.ratioHeight) / 100.0))
        if height?
            width = @state.iframeConfig.style.width
            widthUnit = if width != '100%' then 'px' else ''
            html = """<iframe style="border: none; width: #{width}#{widthUnit}; height: #{height}px;"
                      src="#{@embedUrl url}"></iframe>"""
        return __html: html
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

    getCustomDimension: (key) ->
        return @state[key]

    setCustomDimension: (key, value) ->
        @setState (state) =>
            switch key
                when 'customWidth'
                    update state, {iframeConfig: {style: {width: {$set: value}}}, customWidth: {$set: value}}
                when 'ratioHeight'
                    update state, {ratioHeight: {$set: value}}
                when 'fixedHeight'
                    update state, {fixedHeight: {$set: value}}
    render: ->
        if not @state.url
            return false
        <div>

          <RB.Navbar inverse brand={t 'page.header'}>
            <p className="lead"></p>
            {#@renderLanguages @props.lang}
          </RB.Navbar>

          <div className='container'>

            <div className={cx 'iframe-container': true, 'visible-container': @state.iframeConfig.style.width=='100%'}>
              <ServiceMapIframe html={@iframeHtml(@state.url, @state.iframeConfig.style)}/>
            </div>

                <RB.Panel>
                  <h3>Osoite</h3>
                  <input
                      readOnly
                      type="text"
                      style={width: '100%'}
                      ref="url"
                      onClick={@selectText}
                      value={@embedUrl @state.url} />
                <EmbedHeader
                  resource={@getResource()}
                  resourceId={@state.parameters.id}
                  query={@state.parameters.query} />
                </RB.Panel>
                <ServiceMapEmbedControls
                    language = {@state.parameters.language}
                    resource = {@getResource()}
                    bbox = {'bbox' of @state.parameters.query}
                    level = {@state.parameters.query.level or 'none'}
                    city = {@state.parameters.query.city or 'all'}
                    map = {@state.parameters.query.map or 'servicemap'}
                    width = {if @state.iframeConfig.style.width =='100%' then 'full' else 'custom'}
                    height = {@state.heightMode}
                    getCustomDimension = {@getCustomDimension}
                    setCustomDimension = {@setCustomDimension}
                    parameters = {@state.parameters}
                    waitForConfirmation = {@waitForConfirmation}
                    onChange = {@receiveAdjustments} />
                <pre>
                    {@iframeHtml(@state.url, @state.iframeConfig.style).__html}
                </pre>
          </div>
        </div>

module.exports = Root
