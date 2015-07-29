React         = require 'react'
Router        = require 'react-router'
RouteHandler  = Router.RouteHandler
ServerActions = require '../actions/server_actions'
StatsStore    = require '../stores/stats_store'

StatDisplay = React.createClass(
  displayName: 'StatDisplay'
  mixins: [StatsStore.mixin]
  getInitialState: ->
    StatsStore.getStats()
  storeDidChange: ->
    @setState StatsStore.getStats()
  componentWillMount: ->
    ServerActions.fetchStats()

  render: ->
    <header className="main-page">
      <div className="container">
        <h1>{@state.stats.dashboard_title}</h1>
        <div className="stat-display">
          <div className="stat-display__stat">
            <h1>{@state.stats.course_count}</h1>
            <small>{@state.stats.course_description}</small>
          </div>
        </div>
      </div>
    </header>
)

module.exports = StatDisplay
