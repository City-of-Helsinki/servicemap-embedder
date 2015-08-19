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
            <RB.Panel>
                <RB.Row>
                    <RB.Col md={12}>
                        <h3 className={@helpClassName false}>{t 'title', @props.keyName}</h3>
                    </RB.Col>
                </RB.Row>
                <RB.Row>
                  <RB.Col md={6}>
                      <p className={@helpClassName true}>
                        {t 'parameters', @props.keyName, (if @value()? then @value() else @props.selectedValue), 'help'}
                      </p>
                  </RB.Col>
                  <RB.Col md={6}>
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
                </RB.Row>
            </RB.Panel>

module.exports = MultiValueInputPanel
