ABC = require './abcjs_basic_noraphael_2.3-min.js'
Raphael = require 'raphael'

module.exports =
class AbcView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('abc')

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  setData: (data) ->
    display = document.createElement('div')
    display.classList.add('display')
    display.id = "display"
    @element.appendChild(display)
    ABCJS.renderAbc('display', data)
