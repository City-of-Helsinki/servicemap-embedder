React = require 'react/addons'
RB = require 'react-bootstrap'
_ = require 'underscore'
{t: t} = require 'lib/i18n'
config = require 'lib/config'
MultiValueInputPanel = require 'app/multivalue-input-panel'
update = React.addons.update
cx = require 'classnames'

ServiceMapEmbedControls = React.createClass
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
                  onChange={@props.onChange}/>
            }
        </form>

module.exports = ServiceMapEmbedControls
