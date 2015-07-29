McFly           = require 'mcfly'
Flux            = new McFly()
API             = require '../utils/api.coffee'
ServerActions   = require '../actions/server_actions'

_stats = {
  stats:
    dashboard_title: ''
    course_count: ''
    course_description: ''
}

setStats = (data) ->
  $.extend(true, _stats, data)
  StatsStore.emitChange()

StatsStore = Flux.createStore
  getStats: ->
    return _stats
, (payload) ->
  setStats(payload.data)

module.exports = StatsStore
