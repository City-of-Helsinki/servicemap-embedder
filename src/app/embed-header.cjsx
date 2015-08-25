React = require 'react'
RB = require 'react-bootstrap'
{t: t} = require 'lib/i18n'

EmbedHeader = React.createClass
    resourceHeaderKey: (resource) ->
        if not resource?
            return 'page.summary.other'
        if resource == 'unit'
            if @props.resourceId?
                'page.summary.single_unit'
            else if @props.query.service?
                'page.summary.service_units'
        else
            "page.summary.#{resource}"
    render: ->
        <p>
            <br/>
            {t 'page.summary_header'} {t(@resourceHeaderKey(@props.resource))}.
        </p>

module.exports = EmbedHeader
