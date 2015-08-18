React = require 'react'
RB = require 'react-bootstrap'
{t: t} = require 'lib/i18n'

EmbedHeader = React.createClass
    resourceHeaderKey: (resource) ->
        if resource == 'unit'
            if @props.resourceId?
                'page.summary.single_unit'
            else if @props.query.service?
                'page.summary.service_units'
        else if resource == 'address'
            'page.summary.address'
        else if resource == null
            'page.summary.other'
    render: ->
        <p>
            Upotuksen kohde on {t(@resourceHeaderKey(@props.resource))}.
        </p>

module.exports = EmbedHeader
