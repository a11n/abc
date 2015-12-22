ABC = require './abcjs_basic_noraphael_2.3-min.js'
Raphael = require 'raphael'

{ScrollView} = require 'atom-space-pen-views'
{Disposable} = require 'atom'

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
    @text = @editor.getText()

  attached: ->
    ABCJS.renderAbc('abc-notation', @text)

  serialize: ->
    deserializer: @constructor.name
    editorId: @getEditorId()

  getEditorId: -> @editorId

  getTitle: -> @title
