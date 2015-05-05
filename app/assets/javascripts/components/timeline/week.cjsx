React           = require 'react'
Block           = require './block'
BlockActions    = require '../../actions/block_actions'
WeekActions     = require '../../actions/week_actions'
BlockStore      = require '../../stores/block_store'
GradeableStore  = require '../../stores/gradeable_store'
TextInput       = require '../common/text_input'

Week = React.createClass(
  displayName: 'Week'
  addBlock: ->
    BlockActions.addBlock this.props.week.id
  deleteBlock: (block_id) ->
    BlockActions.deleteBlock block_id
  updateWeek: (value_key, value) ->
    to_pass = $.extend({}, this.props.week)
    to_pass['title'] = value
    WeekActions.updateWeek to_pass
  render: ->
    blocks = this.props.blocks.map (block, i) =>
      unless block.deleted
        <Block
          block={block}
          key={block.id}
          editable={this.props.editable}
          gradeable={GradeableStore.getGradeableByBlock(block.id)}
          deleteBlock={this.deleteBlock.bind(this, block.id)}
        />
    if this.props.editable
      addBlock = <li className="row view-all">
                    <div>
                      <a onClick={this.addBlock}>Add New Block</a>
                    </div>
                  </li>
      deleteWeek = <a onClick={this.props.deleteWeek}>Delete week</a>

    <li className="week">
      <p>
        <span>Week {this.props.index}&nbsp;&nbsp;&mdash;&nbsp;&nbsp;</span>
        <TextInput
          onChange={this.updateWeek}
          value={this.props.week.title}
          value_key={'title'}
          editable={this.props.editable}
        />
      </p>
      {deleteWeek}
      <ul className="list">
        {blocks}
        {addBlock}
      </ul>
    </li>
)

module.exports = Week