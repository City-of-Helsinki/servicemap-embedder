React = require 'react/addons'
RB = require 'react-bootstrap'
_ = require 'underscore'
{t: t} = require 'lib/i18n'
config = require 'lib/config'
MultiValueInputPanel = require 'app/multivalue-input-panel'
update = React.addons.update
cx = require 'classnames'

ServiceMapEmbedControls = React.createClass
    getInitialState: ->
        bbox: null
        level: null
        language: null
    signalInterest: (key, val) ->
        ret = {}
        ret[key] = val
        @setState ret
    forgetInterests: ->
        @replaceState @getInitialState()
    changeHandler: (key, val) ->
        => @props.onChange key, val
    renderLanguages: (checked) ->
            <RB.Row>
                <RB.Col md={6}>
                    <p className={@helpClassName 'language', true}>
                        {t 'parameters.language', @state.language or @props.language, 'help'}
                    </p>
                </RB.Col>
                <RB.Col md={6}>
                  {  _.map config.LANGUAGES, (name, id) =>
                       <WrappedInput
                         className={@textClass 'language', id}
                         onMouseOver={=> @signalInterest('language', id)}
                         onMouseLeave={@forgetInterests}
                         wrappedComponent={RB.Input}

                         checked={id==checked}
                         type='radio'
                         name='language'
                         onChange= {@changeHandler('language', id)}
                         label={t 'parameters.language', id, 'label'}
                         key={id} />
                  }
                </RB.Col>
            </RB.Row>
    renderLevels: ->
        <RB.Panel>
        <RB.Row><RB.Col md={12}><h3 className={@helpClassName 'level'}>{t 'title.level'}</h3></RB.Col></RB.Row>
        {
            _.map ['all', 'common', 'none'], (level) =>
                <RB.Input type='radio' defaultChecked={@props.level == level}
                    onChange={@changeHandler('level', level)}
                    key={level}
                    name='level' label={t 'parameters.level', level, 'label'} />
        }
        </RB.Panel>
    textClass: (key, val) ->
        if @props[key] == val and (@state[key] == val or @state[key] == null)
             "text-primary"
        else if @state[key] == val
            "text-success"
        else
            ""
    hasTransientFocus: (key) ->
        @state[key] != null and @props[key] != @state[key]
    helpClassName: (key, help) ->
        cx 'parameter-help': help, 'text-success': @hasTransientFocus(key), 'text-primary': !@hasTransientFocus(key)
    render: ->
        <form>
            <MultiValueInputPanel
              keyName='language'
              values={_.keys config.LANGUAGES}
              selectedValue={@props.language}
              onChange={@props.onChange} />
            <MultiValueInputPanel
              keyName='bbox'
              values={[true, false]}
              selectedValue={@props.bbox}
              onChange={@props.onChange}/>
            {if @props.resource != 'unit'
                <MultiValueInputPanel
                  keyName='level'
                  values={['all', 'common', 'none']}
                  selectedValue={@props.level}
                  onChange={@props.onChange}/> }
        </form>

module.exports = ServiceMapEmbedControls
