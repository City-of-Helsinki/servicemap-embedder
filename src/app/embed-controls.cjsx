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
            {if (@props.resource not in ['unit', 'search'])
                <RB.Panel>
                <RB.Row>
                    <MultiValueInputPanel
                      keyName='level'
                      values={['none', 'common', 'all']}
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
                <MultiValueInputPanel
                  keyName='city'
                  values={['espoo', 'helsinki', 'vantaa', 'kauniainen', 'all']}
                  selectedValue={@props.city}
                  onChange={@props.onChange} />
                </RB.Row>
            </RB.Panel>
            <RB.Panel>
              <RB.Row>
                  <MultiValueInputPanel
                    keyName='width'
                    values={['full', 'custom']}
                    selectedValue={@props.width}
                    onChange={@props.onChange} >
                        <DimensionControl
                            hidden={@props.width != 'custom'}
                            noOffset={true}
                            keyName={'customWidth'}
                            handleValue={@props.setCustomDimension}
                            getValue={@props.getCustomDimension} />
                  </MultiValueInputPanel>
                </RB.Row>
                <hr />
                <RB.Row>
                <MultiValueInputPanel
                  keyName='height'
                  values={['ratio', 'fixed']}
                  selectedValue={@props.height}
                  onChange={@props.onChange}>
                    <DimensionControl
                       noOffset={true}
                       waitForConfirmation={@props.waitForConfirmation}
                       keyName={@props.height + 'Height'}
                       handleValue={@props.setCustomDimension}
                       getValue={@props.getCustomDimension} />
                </MultiValueInputPanel>
                </RB.Row>

            </RB.Panel>
        </form>

module.exports = ServiceMapEmbedControls
