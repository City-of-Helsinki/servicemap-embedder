React = require 'react'
URI = require 'URIjs'
_ = require 'underscore'

require 'main.less'

ServiceMapIframe = React.createClass
    componentWillReceiveProps: ->
    #     if navigator.appName == 'Microsoft Internet Explorer'
    #         window.frames[0].document.execCommand 'Stop'
    #     else
    #         window.frames[0].stop()
    render: ->
        <div dangerouslySetInnerHTML={@props.html} />

module.exports = ServiceMapIframe

