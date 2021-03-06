React           = require 'react/addons'
Router          = require 'react-router'
Link            = Router.Link
RouteHandler    = Router.RouteHandler
TransitionGroup = require '../../utils/TransitionGroup'

Timeline        = require './timeline'
Grading         = require './grading'
Editable        = require '../high_order/editable'
Meetings        = require './meetings'

ServerActions   = require '../../actions/server_actions'

CourseStore     = require '../../stores/course_store'
WeekStore       = require '../../stores/week_store'
BlockStore      = require '../../stores/block_store'
GradeableStore  = require '../../stores/gradeable_store'

getState = ->
  course: CourseStore.getCourse()
  weeks: WeekStore.getWeeks()
  blocks: BlockStore.getBlocks()
  gradeables: GradeableStore.getGradeables()

TimelineHandler = React.createClass(
  displayName: 'TimelineHandler'
  componentWillMount: ->
    ServerActions.fetch 'timeline', @props.course_id
  render: ->
    <div>
      <TransitionGroup
        transitionName="wizard"
        component='div'
        enterTimeout={500}
        leaveTimeout={500}
      >
        <RouteHandler key='wizard_handler' {...@props} weeks={@props.weeks.length} />
      </TransitionGroup>
      <Meetings
        current_user={@props.current_user}
        course_id={@props.course_id}
        course={@props.course}
      />
      <Timeline {...@props} />
      <Grading {...@props} />
    </div>
)

module.exports = Editable(TimelineHandler, [WeekStore, BlockStore, GradeableStore], ServerActions.saveTimeline, getState)
