React = require 'react'

ServiceMapIframe = React.createClass

    componentDidMount: ->
        html = React.renderToStaticMarkup @render()
        html = html.replace /\s/g, "\n  "
        html = html.replace '</', "\n</"
        html = html.replace '&amp;', '&'
        @props.onHtmlRendered html
    render: ->
          <iframe
            src={@props.url}
            frameBorder={@props.frameBorder}
            style={@props.style} />

module.exports = ServiceMapIframe
