React         = require 'react/addons'
Expandable    = require '../high_order/expandable'
Popover       = require '../common/popover'
Conditional   = require '../high_order/conditional'
ServerActions = require '../../actions/server_actions'
Lookup        = require '../common/lookup'

PopoverButton = (Key, ValueKey, Store, New, Items) ->
  format = (value) ->
    data = {}
    data[Key] = {}
    data[Key][ValueKey] = value
    return data
  component = React.createClass(
    displayname: Key.capitalize() + 'Button'
    mixins: [Store.mixin]
    storeDidChange: ->
      return unless @refs.entry?
      item = @refs.entry.getValue()
      if !New(item)
        @refs.entry.clear()
    add: (e) ->
      e.preventDefault() if e.preventDefault?
      item = @refs.entry.getValue()
      if New(item)
        ServerActions.add Key, @props.course_id, format(item)
      else
        alert 'That already exists for this course!'
    remove: (item_id) ->
      item = Store.getFiltered({ id: item_id })[0]
      ServerActions.remove Key, @props.course_id, format(item[ValueKey])
    stop: (e) ->
      e.stopPropagation()
    getKey: ->
      Key + '_button'
    render: ->
      placeholder = Key.capitalize()
      edit_row = (
        <tr className='edit'>
          <td>
            <form onSubmit={@add}>
              <Lookup model={Key}
                placeholder={placeholder}
                ref='entry'
                onSubmit={@add}
              />
              <button type="submit" className='button border'>Add</button>
            </form>
          </td>
        </tr>
      )

      <div className='pop__container' onClick={@stop}>
        <button className='button border plus' onClick={@props.open}>+</button>
        <Popover
          is_open={@props.is_open}
          edit_row={edit_row}
          rows={Items(@props, @remove)}
        />
      </div>
  )
  return Conditional(Expandable(component))


module.exports = PopoverButton
