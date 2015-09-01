React = require 'react'
RB = require 'react-bootstrap'

DimensionControl = React.createClass
    handleChange: (ev) ->
        @setState value: ev.target.value
    handleSave: (ev) ->
        @props.handleValue @props.keyName, @state.value
    getInitialState: ->
        value: @props.getValue @props.keyName
    getStyle: (hidden) ->
        if hidden
            visibility: 'hidden'
        else
            {}
    getDefaultProps: ->
        noOffset: false
    componentWillReceiveProps: (props) ->
        if props.keyName != @props.keyName
            @setState value: @props.getValue(props.keyName)
    hasPendingModifications: ->
        @state.value != @getInitialState().value
    getButtonStyle: ->
        if @hasPendingModifications() then null else 'success'
    render: ->
        <div style={@getStyle @props.hidden}>
            <RB.Col md={4} mdOffset={unless @props.noOffset then 6} >
                <RB.Input
                    type='text'
                    ref='input'
                    addonAfter={if @props.keyName in ['customWidth', 'fixedHeight'] then 'px' else '%'}
                    onChange={@handleChange}
                    value={@state.value} />
            </RB.Col>
            <RB.Col md={2}>
                <RB.Button
                    bsStyle={if @hasPendingModifications() then 'success'}
                    disabled={!@hasPendingModifications()}
                    onClick={@handleSave}>
                        Tallenna
                </RB.Button>
            </RB.Col>
        </div>

module.exports = DimensionControl
