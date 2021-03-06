#= Helpers for course views
module CourseHelper
  def find_course_by_slug(slug)
    course = Course.where(listed: true).find_by_slug(slug)
    if course.nil?
      fail ActionController::RoutingError.new('Not Found'), 'Course not found'
    end
    return course
  end

  def current?(course)
    # FIXME: 'current' should only be defined in one place. It's also defined
    # from an application.yml parameter in course.rb
    month = 2_592_000 # number of seconds in 30 days
    course.start < Time.now && course.end > Time.now - month
  end
end
