{CompositeDisposable} = require 'atom'

AbcView = null

abcUri = /abc:\/\/editor\/(\d+)/

editorIdFrom = (uri) ->
  return uri.match(abcUri)[1]

createAbcView = (state) ->
  AbcView ?= require './abc-view'
  new AbcView(state)

isAbcView = (object) ->
  AbcView ?= require './abc-view'
  object instanceof AbcView

atom.deserializers.add
  name: 'AbcView'
  deserialize: (state) -> createAbcView(state)

module.exports = Abc =
  activate: ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.workspace.addOpener (uri) ->
      createAbcView(editorId: editorIdFrom(uri)) if uri.match(abcUri)

    atom.commands.add 'atom-workspace', 'abc:toggle': => @toggle()

  toggle: ->
    if isAbcView(atom.workspace.getActivePaneItem())
      atom.workspace.destroyActivePaneItem()
      return

    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    uri = "abc://editor/#{editor.id}"
    atom.workspace.open(uri, searchAllPanes: true, split: 'right')

  deactivate: ->
    @subscriptions.dispose()
