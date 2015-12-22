ABC = require './abcjs_basic_noraphael_2.3-min.js'
Raphael = require 'raphael'

{ScrollView} = require 'atom-space-pen-views'
{Disposable, CompositeDisposable} = require 'atom'

editorFor = (editorId) ->
  for editor in atom.workspace.getTextEditors()
    return editor if editor.id?.toString() is editorId.toString()
  null

module.exports =
class AbcView extends ScrollView
  @content: ->
    @div class: 'native-key-bindings abc', tabindex: -1, =>
      @div id: 'abc-notation'

  onDidChangeTitle: -> new Disposable ->
  onDidChangeModified: -> new Disposable ->

  initialize: ({@editorId}) ->
    @editor = editorFor(@editorId)
    @title = @editor.getTitle()

    changeHandler = =>
      @renderAbc()

    @disposables = new CompositeDisposable
    @disposables.add @editor.getBuffer().onDidStopChanging -> changeHandler()

  attached: ->
    @renderAbc()

  serialize: ->
    deserializer: @constructor.name
    editorId: @getEditorId()

  destroy: ->
    @disposables.dispose()

  getEditorId: -> @editorId

  getTitle: -> @title

  renderAbc: -> ABCJS.renderAbc('abc-notation', @editor.getText())
