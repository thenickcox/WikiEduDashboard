class StatsPresenter

  def initialize(params)
    @params = params
  end

  def dashboard_title
    ENV['dashboard_title']
  end

  def course_count
    course_scope.count
  end

  def course_scope
    Course.where(submitted: false).where(listed: true)
  end

  def course_description
    I18n.t('courses.course_description')
  end

  def cohort
    slug = @params[:cohort] || Figaro.env.default_cohort
    cohort = Cohort.includes(:students).find_by_slug(slug)
    OpenStruct.new(
      slug: slug,
      student_count: cohort.students.count,
      title: cohort.title
    )
  end
end
