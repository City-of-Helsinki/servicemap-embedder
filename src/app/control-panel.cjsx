React = require 'react'
RB = require 'react-bootstrap'
cx = require 'classnames'
{t: t} = require 'lib/i18n'
_ = require 'underscore'

ControlPanel = React.createClass
    getInitialState: ->
        value: null
    signalInterest: (val) ->
        @setState value: val
    forgetInterests: ->
        @replaceState @getInitialState()
    value: ->
        @state.value
    textClass: (val) ->
        if @props.selectedValue == val and (@value() == val or @value() == null)
             "text-primary"
        else if @value() == val
            "text-success"
        else
            ""
    changeHandler: (value) ->
        => @props.onChange @props.keyName, value
    hasTransientFocus: ->
        @value() != null and @props.selectedValue != @value()
    helpClassName: (help) ->
        cx 'parameter-help': help, 'text-success': @hasTransientFocus(), 'text-primary': !@hasTransientFocus()
    render: ->
            valueType = if @props.values instanceof Array
                'array'
            else if @props.values instanceof Object
                'object'
            else
                null
            unless valueType
                return null
            getValue = (value, key) =>
                if valueType == 'array' then value else key
            <RB.Panel>
                <RB.Row>
                    <RB.Col md={12}><h3 className={@helpClassName false}>{t 'title', @props.keyName}</h3></RB.Col>
                </RB.Row>
                <RB.Row>
                  <RB.Col md={6}>
                      <p className={@helpClassName true}>
                        {t 'parameters', @props.keyName, (if @value()? then @value() else @props.selectedValue), 'help'}
                      </p>
                  </RB.Col>
                  <RB.Col md={6}>
                    { _.map @props.values, (value, key) =>
                        <div onMouseOver={=> @signalInterest getValue(value, key)}
                             onMouseLeave={@forgetInterests}
                             className={@textClass value}
                             key={value}>
                        <RB.Input
                          type='radio'
                          name={@props.keyName}
                          label={t 'parameters', @props.keyName, getValue(value, key), 'label'}
                          checked={@props.selectedValue == getValue(value, key)}
                          onChange={@changeHandler getValue(value, key)} />
                        </div>
                    }
                  </RB.Col>
                </RB.Row>
            </RB.Panel>

module.exports = ControlPanel
