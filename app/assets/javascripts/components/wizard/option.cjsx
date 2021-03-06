React             = require 'react/addons'
Marked            = require 'marked'
MarkedRenderer    = require '../../utils/marked_renderer'
WizardActions     = require '../../actions/wizard_actions'

Option = React.createClass(
  displayName: 'Option'
  select: ->
    WizardActions.toggleOptionSelected @props.panel_index, @props.index
  expand: ->
    $(React.findDOMNode(@refs.expandable)).toggleHeight()
    WizardActions.toggleOptionExpanded @props.panel_index, @props.index
  render: ->
    className = 'wizard__option section-header'
    className += ' selected' if @props.option.selected
    checkbox = <div className='wizard__option__checkbox'></div> if @props.multiple
    if @props.option.description?
      expand_text = 'Read More'
      expand_className = 'wizard__option__description'
      more_className = 'wizard__option__more'
      if @props.option.expanded
        expand_text = 'Read Less'
        expand_className += ' open'
        more_className += ' open'
      expand = (
        <div className={expand_className} ref='expandable'>
          <div dangerouslySetInnerHTML={{__html: Marked(@props.option.description, { renderer: MarkedRenderer })}}></div>
        </div>
      )
      expand_link = (
        <button className={more_className} onClick={@expand}><p>{expand_text}</p></button>
      )
    if @props.option.blurb?
      blurb = (
        <div dangerouslySetInnerHTML={{__html: Marked(@props.option.blurb, { renderer: MarkedRenderer })}}></div>
      )

    <div className={className}>
      <button onClick={@select}>
        {checkbox}
        <h3>{@props.option.title}</h3>
        {blurb}
        {expand}
      </button>
      {expand_link}
      <div className='wizard__option__border'></div>
    </div>
)

module.exports = Option