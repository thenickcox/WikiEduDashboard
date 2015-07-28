React = require 'react/addons'

Article = React.createClass(
  displayName: 'Article'
  render: ->
    className = 'article'
    chars = 'Chars Added: ' + @props.article.character_sum + ', Views: ' + @props.article.view_count
    ratingClass = 'rating ' + @props.article.rating
    ratingMobileClass = ratingClass + ' tablet-only'
    languagePrefix = if @props.article.language then "#{@props.article.language}:" else ''
    formattedTitle = "#{languagePrefix}#{@props.article.title}"

    <tr className={className}>
      <td className='popover-trigger desktop-only-tc'>
        <p className="rating_num hidden">{@props.article.rating_num}</p>
        <div className={ratingClass}><p>{@props.article.pretty_rating || '-'}</p></div>
        <div className="popover dark">
          <p>{I18n.t('articles.rating_docs.' + (@props.article.rating || '?'))}</p>
        </div>
      </td>
      <td>
        <div className={ratingMobileClass}><p>{@props.article.pretty_rating || '-'}</p></div>
        <p className="title">
          <a onClick={@stop} href={@props.article.url} target="_blank" className="inline">{formattedTitle} {(if @props.article.new then ' (new)' else '')}</a>
        </p>
      </td>
      <td className='desktop-only-tc'>{@props.article.character_sum}</td>
      <td className='desktop-only-tc'>{@props.article.view_count}</td>
      <td></td>
    </tr>
)

module.exports = Article
