React = require 'react'
RB = require 'react-bootstrap'

DimensionControl = React.createClass
    handleSave: ->
        @props.handleValue @props.keyName, @state.value
    getInitialState: ->
        value: @props.getValue @props.keyName
    getStyle: (hidden) ->
        if hidden
            visibility: 'hidden'
        else
            {}
    hasPendingModifications: ->
        @state.value != @props.getValue @props.keyName
    getButtonStyle: ->
        if @hasPendingModifications() then null else 'success'
    render: ->
        <RB.Row style={@getStyle @props.hidden}>
            <RB.Col md={4} mdOffset={6} >
                <RB.Input
                    type='text'
                    ref='input'
                    value={@state.value}
                    onChange={(e) => @setState value: e.target.value} />
            </RB.Col>
            <RB.Col md={2}>
                <RB.Button
                    bsStyle='success'
                    disabled={!@hasPendingModifications()}
                    onClick={@handleSave}>
                        Tallenna
                </RB.Button>
            </RB.Col>
        </RB.Row>

module.exports = DimensionControl
