AbcView = require './abc-view'
{CompositeDisposable} = require 'atom'

module.exports = Abc =
  abcView: null
  rightPanel: null
  subscriptions: null

  activate: (state) ->
    @abcView = new AbcView(state.abcViewState)
    @rightPanel = atom.workspace.addRightPanel(item: @abcView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'abc:toggle': => @toggle()

  deactivate: ->
    @rightPanel.destroy()
    @subscriptions.dispose()
    @abcView.destroy()

  serialize: ->
    abcViewState: @abcView.serialize()

  toggle: ->
    console.log 'Abc was toggled!'

    if @rightPanel.isVisible()
      @rightPanel.hide()
    else
      data = atom.workspace.getActiveTextEditor().getText()
      @rightPanel.show()
      @abcView.setData(data)
