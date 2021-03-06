json.assignments course.assignments do |assignment|
  json.(assignment, :id, :user_id, :article_id, :article_title, :role)
  json.article_title assignment.article_title.gsub('_', ' ')
  json.article_url article_url(assignment.article)
  json.user_wiki_id assignment.user.wiki_id
end