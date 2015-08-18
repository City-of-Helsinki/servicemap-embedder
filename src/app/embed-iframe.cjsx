React = require 'react'
URI = require 'URIjs'
_ = require 'underscore'

require 'main.less'

ServiceMapIframe = React.createClass
    render: ->
        <div dangerouslySetInnerHTML={@props.html} />

module.exports = ServiceMapIframe
