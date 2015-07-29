require 'rails_helper'

describe StatsPresenter do
  let(:params) {{}}
  subject { described_class.new(params) }
  describe '#course_scope' do
    it 'counts listed, submitted courses' do
      expect(subject.course_scope.to_sql).to eq('SELECT `courses`.* FROM `courses`  WHERE `courses`.`submitted` = 0 AND `courses`.`listed` = 1')
    end
  end

  describe '#cohort_student_count' do
    subject { described_class.new(params).cohort_student_count }
    context 'params has cohort no cohort' do
      it 'returns the default cohort' do
        expect { subject }
      end
    end
  end

  describe '#cohort' do
    subject { described_class.new(params).cohort }
    let(:params) {{}}
    let!(:course) { create(:course) }
    let!(:user)   { create(:user) }
    let!(:cohort) { create(:cohort) }
    let!(:cohort_course) { create(:cohorts_course, cohort_id: cohort.id, course_id: course.id) }
    let!(:courses_user) { create(:courses_user, user_id: user.id, course_id: course.id) }

    context 'params[:cohort] is nil' do
      it 'returns an openstruct based on default cohort' do
        expect(subject.slug).to eq(Figaro.env.default_cohort)
        expect(subject.student_count).to eq(1)
        expect(subject.title).to eq(cohort.title)
      end
    end

    context 'params[:cohort] is different cohort' do
      let(:slug)    { 'wintr_cohort' }
      let(:title)   { 'WINTR cohort' }
      let!(:cohort) { create(:cohort, slug: slug, title: title) }
      let(:params)  {{ cohort: cohort.slug }}
      it 'returns an openstruct based on cohort in params' do
        expect(subject.slug).to eq(slug)
        expect(subject.student_count).to eq(1)
        expect(subject.title).to eq(title)
      end
    end
  end

end
