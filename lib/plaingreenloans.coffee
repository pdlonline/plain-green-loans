PlaingreenloansView = require './plaingreenloans-view'
{CompositeDisposable} = require 'atom'

module.exports = Plaingreenloans =
  plaingreenloansView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @plaingreenloansView = new PlaingreenloansView(state.plaingreenloansViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @plaingreenloansView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'plaingreenloans:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @plaingreenloansView.destroy()

  serialize: ->
    plaingreenloansViewState: @plaingreenloansView.serialize()

  toggle: ->
    console.log 'Plaingreenloans was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
