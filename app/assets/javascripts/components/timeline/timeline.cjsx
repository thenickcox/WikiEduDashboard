React           = require 'react'
Router          = require 'react-router'

RDnD            = require 'react-dnd'
HTML5Backend    = require 'react-dnd/modules/backends/HTML5'
DDContext       = RDnD.DragDropContext

Week            = require './week'
CourseLink      = require '../common/course_link'

WeekActions     = require '../../actions/week_actions'
BlockActions    = require '../../actions/block_actions'

BlockStore      = require '../../stores/block_store'

Timeline = React.createClass(
  displayName: 'Timeline'
  addWeek: ->
    WeekActions.addWeek()
  deleteWeek: (week_id) ->
    WeekActions.deleteWeek(week_id)
  moveBlock: (block_id, after_block_id) ->
    return if block_id == after_block_id
    block = BlockStore.getBlock block_id
    after_block = BlockStore.getBlock after_block_id
    if block.week_id == after_block.week_id   # dragging within a week
      old_order = block.order
      block.order = after_block.order
      after_block.order = old_order
      BlockActions.updateBlock block, true
      BlockActions.updateBlock after_block
    else
      block.week_id = after_block.week_id
      BlockActions.insertBlock block, after_block.week_id, after_block.order
  meetingsForWeek: (index) ->
    return '' if @props.course.weekdays == '0000000'
    week_start = moment(@props.course.timeline_start).add(7 * index, 'day')
    weekdays = @props.course.weekdays.split('')
    exceptions = @props.course.day_exceptions.split(',')
    ms = []
    meetings = [0..6].forEach (i) =>
      added = moment(week_start).add(i, 'day')
      if weekdays[parseInt(added.format('e'))] == '1' && !(added.format('YYYYMMDD') in exceptions)
        ms.push moment.localeData().weekdaysShort(added)
    if ms.length == 0
      '()'
    else
      "(#{ms.join(', ')})"
  render: ->
    week_components = []
    i = 0
    @props.weeks.forEach (week) =>
      unless week.deleted
        while @meetingsForWeek(i) == '()'
          week_components.push (
            <Week
              blocks={[]}
              week={title: null}
              index={i + 1}
              key={"noweek_#{i}"}
              start={@props.course.timeline_start}
              end={@props.course.timeline_end}
              editable=false
              meetings='(No meetings this week)'
            />
          )
          i++
        week_components.push (
          <Week
            week={week}
            index={i + 1}
            key={week.id}
            start={@props.course.timeline_start}
            end={@props.course.timeline_end}
            editable={@props.editable}
            blocks={BlockStore.getBlocksInWeek(week.id)}
            moveBlock={@moveBlock}
            deleteWeek={@deleteWeek.bind(this, week.id)}
            meetings={@meetingsForWeek(i)}
          />
        )
        i++
    if @props.editable
      add_week = (
        <li className="row view-all">
          <div>
            <button className='button dark' onClick={@addWeek}>Add New Week</button>
          </div>
          <br />
          <div>
            {@props.controls(null, false, true)}
          </div>
        </li>
      )
    unless week_components.length
      no_weeks = (
        <li className="row view-all">
          <div><p>This course does not have a timeline yet</p></div>
        </li>
      )

    start = moment(@props.course.timeline_start)
    end = moment(@props.course.timeline_end)
    timeline_full = Math.ceil(end.diff(start, 'days') / 7) - @props.weeks.length <= 0
    if timeline_full
      wizard_link = <div className='button dark disabled' title='You cannot use the assignment design wizard when your timeline is full. Delete at least one week to make room for a new assignment.'>Add Assignment</div>
    else
      wizard_link = <CourseLink to='wizard' className='button dark'>Add Assignment</CourseLink>

    <div>
      <div className="section-header">
        <h3>Timeline</h3>
        <CourseLink to='wizard', text='Open Wizard', className='button large dark' />
        {@props.controls(wizard_link)}
      </div>
      <ul className="list">
        {week_components}
        {no_weeks}
        {add_week}
      </ul>
    </div>
)

module.exports = DDContext(HTML5Backend)(Timeline)