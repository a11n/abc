AbcView = require './abc-view'
{CompositeDisposable} = require 'atom'

module.exports = Abc =
  abcView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @abcView = new AbcView(state.abcViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @abcView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'abc:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @abcView.destroy()

  serialize: ->
    abcViewState: @abcView.serialize()

  toggle: ->
    console.log 'Abc was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
