React = require 'react'

ServiceMapIframe = React.createClass
  render: ->
      <div className="commentBox">
        <p>width: {@props.style.width}</p>
        <p>min-height: {@props.style['min-height']}</p>
        <p>frameborder: {@props.frameborder}</p>
      </div>

module.exports = ServiceMapIframe
