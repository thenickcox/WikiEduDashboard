require_relative '../../presenters/stats_presenter'

stats_presenter = StatsPresenter.new(params)

json.stats do
  json.dashboard_title      stats_presenter.dashboard_title
  json.course_count         stats_presenter.course_count
  json.course_description   stats_presenter.course_description
  json.cohort_student_count status_presenter.cohort_student_count
end
