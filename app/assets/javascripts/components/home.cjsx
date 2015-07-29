React         = require 'react'
Router        = require 'react-router'
RouteHandler  = Router.RouteHandler

StatDisplay   = require '../components/stat_display'

Home = React.createClass(
  displayName: 'HomeCourses'
  opts:
    className: 'courses'
  render: ->
    <StatDisplay />
    #<YourCourses />
    #<CourseList />
)

module.exports = Home
