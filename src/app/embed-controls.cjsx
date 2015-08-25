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
                <RB.Row>
                <MultiValueInputPanel
                  keyName='language'
                  values={_.keys config.LANGUAGES}
                  selectedValue={@props.language}
                  onChange={@props.onChange} />
                </RB.Row>
            </RB.Panel>
            {if (@props.resource != null)
                <RB.Panel>
                    <RB.Row>
                    <MultiValueInputPanel
                      keyName='bbox'
                      values={[true, false]}
                      selectedValue={@props.bbox}
                      onChange={@props.onChange} />
                    </RB.Row>
                </RB.Panel>
            }
            {if (@props.resource != 'unit')
                <RB.Panel>
                <RB.Row>
                    <MultiValueInputPanel
                      keyName='level'
                      values={['all', 'common', 'none']}
                      selectedValue={@props.level}
                      onChange={@props.onChange} />
                </RB.Row>
                </RB.Panel>
            }
            <RB.Panel>
                <RB.Row>
                <MultiValueInputPanel
                  keyName='map'
                  values={config.BACKGROUND_MAPS}
                  selectedValue={@props.map}
                  onChange={@props.onChange} />
                </RB.Row>
            </RB.Panel>
            <RB.Panel>
                <RB.Row>
                    <RB.Col md={6}>
                        <h3 className='text-primary'>
                            {t 'title.minHeight'}
                        </h3>
                    </RB.Col>
                <DimensionControl
                    keyName='minHeight'
                    handleValue={@props.setCustomDimension}
                    getValue={@props.getCustomDimension} />
                </RB.Row>
                <hr />
                <RB.Row>
                <MultiValueInputPanel
                  keyName='width'
                  values={['full', 'custom']}
                  selectedValue={@props.width}
                  onChange={@props.onChange}
                  injectContents={<DimensionControl
                    hidden={@props.width != 'custom'}
                    noOffset={true}
                    keyName='width'
                    handleValue={@props.setCustomDimension}
                    getValue={@props.getCustomDimension} />}
                   />
                </RB.Row>
            </RB.Panel>
        </form>

module.exports = ServiceMapEmbedControls
