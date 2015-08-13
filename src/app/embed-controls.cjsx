React = require 'react'
RB = require 'react-bootstrap'

ServiceMapEmbedControls = React.createClass
    render: ->
        <form>
            <RB.Panel>
                <RB.Input
                  type='radio'
                  name='bbox'
                  label="Use pre-set coordinates"
                  help='Uses the bounds that the map had when clicking on the "embed" link.'></RB.Input>
                <RB.Input type='radio' name='bbox' label="Use automatically bounded view"></RB.Input>
            </RB.Panel>
            <RB.Panel>
            <RB.Input type='radio' name='level' label='Show all units' />
            <RB.Input type='radio' name='level' label='Show popular public services' />
            <RB.Input type='radio' name='level' label='Do not show any units' />
            </RB.Panel>
        </form>

module.exports = ServiceMapEmbedControls
