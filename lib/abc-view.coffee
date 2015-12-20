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
    display.textContent = data
    display.classList.add('display')
    @element.appendChild(display)
