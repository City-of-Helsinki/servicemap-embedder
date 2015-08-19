React = require 'react/addons'
RB = require 'react-bootstrap'
_ = require 'underscore'
{t: t} = require 'lib/i18n'
config = require 'lib/config'
update = React.addons.update
cx = require 'classnames'

MultiValueInputPanel = require 'app/multivalue-input-panel'
DimensionControl = require 'app/dimension-control'

ServiceMapEmbedControls = React.createClass
    helpClassName: (key, help) ->
        cx 'parameter-help': help, 'text-success': @hasTransientFocus(key), 'text-primary': !@hasTransientFocus(key)
    render: ->
        <form onSubmit={(ev) => ev.preventDefault()}>
            <RB.Panel>
                <MultiValueInputPanel
                  keyName='language'
                  values={_.keys config.LANGUAGES}
                  selectedValue={@props.language}
                  onChange={@props.onChange} />
            </RB.Panel>
            <RB.Panel>
                <MultiValueInputPanel
                  keyName='bbox'
                  values={[true, false]}
                  selectedValue={@props.bbox}
                  onChange={@props.onChange} />
            </RB.Panel>
            {if (@props.resource != 'unit')
                <RB.Panel>
                    <MultiValueInputPanel
                      keyName='level'
                      values={['all', 'common', 'none']}
                      selectedValue={@props.level}
                      onChange={@props.onChange} />
                </RB.Panel>
            }
            <RB.Panel>
                <RB.Row>
                    <RB.Col md={12}>
                        <h3 className='text-primary'>
                            {t 'title.minHeight'}
                        </h3>
                    </RB.Col>
                </RB.Row>
                <DimensionControl
                    keyName='minHeight'
                    handleValue={@props.setCustomDimension}
                    getValue={@props.getCustomDimension} />
                <hr />
                <MultiValueInputPanel
                  keyName='width'
                  values={['full', 'custom']}
                  selectedValue={@props.width}
                  onChange={@props.onChange} />
                <DimensionControl
                  hidden={@props.width != 'custom'}
                  keyName='width'
                  handleValue={@props.setCustomDimension}
                  getValue={@props.getCustomDimension} />
            </RB.Panel>
        </form>

module.exports = ServiceMapEmbedControls
