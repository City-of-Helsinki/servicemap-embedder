React = require 'react'
RB = require 'react-bootstrap'
cx = require 'classnames'
{t: t} = require 'lib/i18n'
_ = require 'underscore'

MultiValueInputPanel = React.createClass
    getInitialState: ->
        value: null
    signalInterest: (val) ->
        @setState value: val
    getDefaultProps: ->
        inputType: 'radio'
    forgetInterests: ->
        @replaceState @getInitialState()
    value: ->
        @state.value
    activeValue: ->
        if @value()? then @value() else @props.selectedValue
    changeHandler: (value) ->
        => @props.onChange @props.keyName, value
    hasTransientFocus: ->
        @value() != null and @props.selectedValue != @value()
    helpClassName: (help) ->
        cx 'parameter-help': help, 'text-success': @hasTransientFocus(), 'text-primary': !@hasTransientFocus()
    textClassName: (val) ->
        if @props.selectedValue == val and (@value() == val or @value() == null)
             "text-primary"
        else if @value() == val
            "text-success"
        else
            ""
    render: ->
        <div>
              <RB.Col md={6}>
                    <h3 className={@helpClassName false}>
                        {t 'title', @props.keyName}
                    </h3>
                  <p className={@helpClassName true}>
                    {t 'parameters', @props.keyName, @activeValue(), 'help'}
                  </p>
              </RB.Col>
              <RB.Col md={6} className='multivalue-group-inputs'>
                { _.map @props.values, (value) =>
                    <div onMouseOver={=> @signalInterest value}
                         onMouseLeave={@forgetInterests}
                         className={@textClassName value}
                         key={value}>
                        <RB.Input
                            type={@props.inputType}
                            name={@props.keyName}
                            label={t 'parameters', @props.keyName, value, 'label'}
                            checked={@props.selectedValue == value}
                            onChange={@changeHandler value} />
                    </div>
                }
              </RB.Col>
              {@props.children}
        </div>

module.exports = MultiValueInputPanel
