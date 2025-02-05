module.exports =
  consumeToolBar: (bar) ->
    return unless atom.config.get 'julia-client.uiOptions.enableToolBar'

    @bar = bar 'julia-client'

    # Files & Folders

    @bar.addButton
      icon: 'file-code'
      iconset: 'fa'
      tooltip: 'New Julia File'
      callback: ->
        atom.workspace.open().then (ed) ->
          ed.setGrammar(atom.grammars.grammarForScopeName('source.julia'))

    @bar.addButton
      icon: 'save'
      iconset: 'fa'
      tooltip: 'Save'
      callback: 'core:save'

    @bar.addButton
      icon: 'folder-open'
      iconset: 'fa'
      tooltip: 'Open File...'
      callback: 'application:open-file'

    # Julia process

    @bar.addSpacer()

    @bar.addButton
      icon: 'globe'
      tooltip: 'Start Local Julia Process'
      callback: 'julia-client:start-julia'

    @bar.addButton
      iconset: 'ion'
      icon: 'planet'
      tooltip: 'Start Remote Julia Process'
      callback: 'julia-client:start-remote-julia-process'

    @bar.addButton
      icon: 'pause'
      iconset: 'ion'
      tooltip: 'Interrupt Julia'
      callback: 'julia-client:interrupt-julia'

    @bar.addButton
      icon: 'stop'
      iconset: 'ion'
      tooltip: 'Stop Julia'
      callback: 'julia-client:kill-julia'

    # Evaluation

    @bar.addSpacer()

    @bar.addButton
      icon: 'zap'
      tooltip: 'Run Block'
      callback: 'julia-client:run-and-move'

    @bar.addButton
      icon: 'play'
      iconset: 'ion'
      tooltip: 'Run All'
      callback: 'julia-client:run-all'

    @bar.addButton
      icon: 'format-float-none'
      iconset: 'mdi'
      tooltip: 'Format Code'
      callback: 'julia-client:format-code'

    # Windows & Panes

    @bar.addSpacer()

    @bar.addButton
      icon: 'terminal'
      tooltip: 'Show Console'
      callback: 'julia-client:open-console'

    @bar.addButton
      icon: 'book'
      tooltip: 'Show Workspace'
      callback: 'julia-client:open-workspace'

    @bar.addButton
      icon: 'list-unordered'
      tooltip: 'Show Outline'
      callback: 'julia-client:open-outline-pane'

    @bar.addButton
      icon: 'info'
      tooltip: 'Show Documentation Browser'
      callback: 'julia-client:open-documentation-browser'

    @bar.addButton
      icon: 'graph'
      tooltip: 'Show Plots'
      callback: 'julia-client:open-plot-pane'

    @bar.addButton
      icon: 'bug'
      tooltip: 'Show Debugger Pane'
      callback: 'julia-debug:open-debugger-pane'

  deactivate: ->
    @bar?.removeItems()
