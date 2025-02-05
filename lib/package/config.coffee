{terminal} = require '../connection'

config =
  juliaPath:
    type: 'string'
    default: 'julia'
    description: 'The location of the Julia binary.'
    order: 1
  juliaOptions:
    type: 'object'
    order: 2
    collapsed: true
    properties:
      bootMode:
        title: 'Boot Mode'
        type: 'string'
        description: '`Basic` spins up a local Julia process on demand and is the most
                      robust option. The `Cycler` will keep three local Julia processes
                      around at all times to reduce downtime when a process exits.
                      `External Terminal` opens an external terminal and connects it to Juno,
                      much like the `Connect Terminal` command.
                      `Remote` is similar to the `Start Remote Julia Process`
                      command but changes the default, so that evaluating a line
                      in the editor or pressing `Enter` in the REPL tab will start
                      a remote Julia process instead of a local one.'
        enum: ['Basic', 'Cycler', 'External Terminal', 'Remote']
        default: 'Cycler'
        radio: true
        order: 1
      optimisationLevel:
        title: 'Optimisation Level'
        description: 'Higher levels take longer to compile, but produce faster code.'
        type: 'integer'
        enum: [0, 1, 2, 3]
        default: 3
        radio: true
        order: 2
      deprecationWarnings:
        title: 'Deprecation Warnings'
        type: 'boolean'
        description: 'If disabled, hides deprecation warnings.'
        default: true
        order: 3
      numberOfThreads:
        title: 'Number of Threads'
        type: 'string'
        description: '`global` will use global setting, `auto` sets it to number of cores.'
        default: 'auto'
        order: 4
      startupArguments:
        title: 'Additional Julia Startup Arguments'
        type: 'array'
        description: '`-i`, `-O`, and `--depwarn` will be set by the above options
                      automatically, but can be overwritten here. Arguments are
                      comma-separated, and you should never need to quote
                      anything (even e.g. paths with spaces in them).'
        default: []
        items:
          type: 'string'
        order: 5
      externalProcessPort:
        title: 'Port for Communicating with the Julia Process'
        type: 'string'
        description: '`random` will use a new port each time, or enter an integer to set the port statically.'
        default: 'random'
        order: 6
      arguments:
        title: 'Arguments'
        type: 'array'
        description: 'Set `ARGS` to the following entries (comma-separated). Requires restart of Julia process.'
        default: []
        items:
          type: 'string'
        order: 7
      persistWorkingDir:
        title: 'Persist Working Directory'
        type: 'boolean'
        default: false
        order: 8
      workingDir:
        title: 'Working Directory'
        type: 'string'
        default: ''
        order: 9
      autoCompletionSuggestionPriority:
        title: 'Auto-Completion Suggestion Priority'
        description:
          '''
          Specify the sort order of Auto-completion suggestion from Julia-Client.
          Note the default providers like snippets have priority of 1.
          Requires Atom restart to take an effect.
          '''
        type: 'integer'
        default: 3
        order: 11
      noAutoParenthesis:
        title: 'Don\'t Insert Parenthesis on Function Auto-completion'
        description: 'If enabled, Juno will not insert parenthesis after completing a function.'
        type: 'boolean'
        default: false
        order: 12
  uiOptions:
    title: 'UI Options'
    type: 'object'
    order: 3
    collapsed: true
    properties:
      resultsDisplayMode:
        title: 'Result Display Mode'
        type: 'string'
        default: 'inline'
        enum: [
          {value:'inline', description:'Float results next to code'}
          {value:'block', description:'Display results under code'}
          {value:'console', description:'Display results in the console'}
        ]
        order: 1
      docsDisplayMode:
        title: 'Documentation Display Mode'
        type: 'string'
        default: 'pane'
        enum: [
          {value: 'inline', description: 'Show documentation in the editor'}
          {value: 'pane', description: 'Show documentation in the documentation pane'}
        ]
        order: 2
      # notifications:
      #   title: 'Notifications'
      #   type: 'boolean'
      #   default: true
      #   description: 'Enable notifications for evaluation.'
      #   order: 3
      errorNotifications:
        title: 'Error Notifications'
        type: 'boolean'
        default: true
        description: 'When evaluating a script, show errors in a notification as
                      well as in the console.'
        order: 4
      enableMenu:
        title: 'Enable Menu'
        type: 'boolean'
        default: false
        description: 'Show a Julia menu in the menu bar (requires restart).'
        order: 5
      enableToolBar:
        title: 'Enable Toolbar'
        type: 'boolean'
        default: false
        description: 'Show Julia icons in the tool bar (requires restart).'
        order: 6
      usePlotPane:
        title: 'Enable Plot Pane'
        type: 'boolean'
        description: 'Show plots in Atom.'
        default: true
        order: 7
      openNewEditorWhenDebugging:
        title: 'Open New Editor When Debugging'
        type: 'boolean'
        default: false
        description: 'Opens a new editor tab when stepping into a new file instead
                      of reusing the current one (requires restart).'
        order: 8
      cellDelimiter:
        title: 'Cell Delimiter'
        type: 'array'
        default: ['##', '#---', '#%%', '# %%']
        description: 'Regular expressions for determining cell delimiters.'
        order: 9
      layouts:
        title: 'Layout Options'
        type: 'object'
        order: 10
        collapsed: true
        properties:
          console:
            title: 'Console'
            type: 'object'
            order: 1
            collapsed: true
            properties:
              defaultLocation:
                title: 'Default location of Console Pane'
                type: 'string'
                enum: ['center', 'left', 'bottom', 'right']
                default: 'bottom'
                radio: true
                order: 1
              split:
                title: 'Splitting rule of Console Pane'
                type: 'string'
                enum: ['no split', 'left', 'up', 'right', 'down']
                default: 'no split'
                radio: true
                order: 2
          terminal:
            title: 'Terminal'
            type: 'object'
            order: 2
            collapsed: true
            properties:
              defaultLocation:
                title: 'Default location of Terminal Pane'
                type: 'string'
                enum: ['center', 'left', 'bottom', 'right']
                default: 'bottom'
                radio: true
                order: 1
              split:
                title: 'Splitting rule of Terminal Pane'
                type: 'string'
                enum: ['no split', 'left', 'up', 'right', 'down']
                default: 'no split'
                radio: true
                order: 2
          workspace:
            title: 'Workspace'
            type: 'object'
            order: 3
            collapsed: true
            properties:
              defaultLocation:
                title: 'Default location of Workspace Pane'
                type: 'string'
                enum: ['center', 'left', 'bottom', 'right']
                default: 'center'
                radio: true
                order: 1
              split:
                title: 'Splitting rule of Workspace Pane'
                type: 'string'
                enum: ['no split', 'left', 'up', 'right', 'down']
                default: 'right'
                radio: true
                order: 2
          documentation:
            title: 'Documentation Browser'
            type: 'object'
            order: 4
            collapsed: true
            properties:
              defaultLocation:
                title: 'Default location of Documentation Browser Pane'
                type: 'string'
                enum: ['center', 'left', 'bottom', 'right']
                default: 'center'
                radio: true
                order: 1
              split:
                title: 'Splitting rule of Documentation Browser Pane'
                type: 'string'
                enum: ['no split', 'left', 'up', 'right', 'down']
                default: 'right'
                radio: true
                order: 2
          plotPane:
            title: 'Plot Pane'
            type: 'object'
            order: 5
            collapsed: true
            properties:
              defaultLocation:
                title: 'Default location of Plot Pane'
                type: 'string'
                enum: ['center', 'left', 'bottom', 'right']
                default: 'center'
                radio: true
                order: 1
              split:
                title: 'Splitting rule of Plot Pane'
                type: 'string'
                enum: ['no split', 'left', 'up', 'right', 'down']
                default: 'right'
                radio: true
                order: 2
          debuggerPane:
            title: 'Debugger Pane'
            type: 'object'
            order: 6
            collapsed: true
            properties:
              defaultLocation:
                title: 'Default location of Debugger Pane'
                type: 'string'
                enum: ['center', 'left', 'bottom', 'right']
                default: 'right'
                radio: true
                order: 1
              split:
                title: 'Splitting rule of Debugger Pane'
                type: 'string'
                enum: ['no split', 'left', 'up', 'right', 'down']
                default: 'no split'
                radio: true
                order: 2
          profiler:
            title: 'Profiler'
            type: 'object'
            order: 7
            collapsed: true
            properties:
              defaultLocation:
                title: 'Default location of Profiler Pane'
                type: 'string'
                enum: ['center', 'left', 'bottom', 'right']
                default: 'center'
                radio: true
                order: 1
              split:
                title: 'Splitting rule of Profiler Pane'
                type: 'string'
                enum: ['no split', 'left', 'up', 'right', 'down']
                default: 'right'
                radio: true
                order: 2
          linter:
            title: 'Linter'
            type: 'object'
            order: 8
            collapsed: true
            properties:
              defaultLocation:
                title: 'Default location of Linter Pane'
                type: 'string'
                enum: ['center', 'left', 'bottom', 'right']
                default: 'bottom'
                radio: true
                order: 1
              split:
                title: 'Splitting rule of Linter Pane'
                type: 'string'
                enum: ['no split', 'left', 'up', 'right', 'down']
                default: 'no split'
                radio: true
                order: 2
          outline:
            title: 'Outline'
            type: 'object'
            order: 9
            collapsed: true
            properties:
              defaultLocation:
                title: 'Default location of Outline Pane'
                type: 'string'
                enum: ['center', 'left', 'bottom', 'right']
                default: 'left'
                radio: true
                order: 1
              split:
                title: 'Splitting rule of Outline Pane'
                type: 'string'
                enum: ['no split', 'left', 'up', 'right', 'down']
                default: 'down'
                radio: true
                order: 2
          defaultPanes:
            title: 'Default Panes'
            description: 'Specify panes that are opened by `Julia-Client:Restore-Default-Layout`.
                          The location and splitting rule of each pane follow the settings above.'
            type: 'object'
            order: 10
            properties:
              console:
                title: 'Console'
                type: 'boolean'
                default: true
                order: 1
              workspace:
                title: 'Workspace'
                type: 'boolean'
                default: true
                order: 2
              documentation:
                title: 'Documentation Browser'
                type: 'boolean'
                default: true
                order: 3
              plotPane:
                title: 'Plot Pane'
                type: 'boolean'
                default: true
                order: 4
              debuggerPane:
                title: 'Debugger Pane'
                type: 'boolean'
                default: false
                order: 5
              linter:
                title: 'Linter'
                type: 'boolean'
                default: false
                order: 6
              outline:
                title: 'Outline'
                type: 'boolean'
                default: false
                order: 7
          openDefaultPanesOnStartUp:
            title: 'Open Default Panes on Startup'
            description: 'If enabled, opens panes specified above on startup.
                          Note a layout deserialized from a previous window state
                          would be modified by that, i.e.: disable this if you want
                          to keep the deserialized layout.'
            type: 'boolean'
            default: true
            order: 11
  consoleOptions:
    type: 'object'
    order: 4
    collapsed: true
    properties:
      maximumConsoleSize:
        title: 'Scrollback Buffer Size'
        type: 'integer'
        default: 10000
        order: 1
      prompt:
        title: 'Terminal Prompt'
        type: 'string'
        default: 'julia>'
        order: 2
      shell:
        title: 'Shell'
        type: 'string'
        default: terminal.defaultShell()
        description: 'The location of an executable shell. Set to `$SHELL` by default,
                      and if `$SHELL` isn\'t set then fallback to `bash` or `powershell.exe` (on Windows).'
        order: 3
      terminal:
        title: 'Terminal'
        type: 'string'
        default: terminal.defaultTerminal()
        description: 'Command used to open an external terminal.'
        order: 4
      whitelistedKeybindingsREPL:
        title: 'Whitelisted Keybindings for the Julia REPL'
        type: 'array'
        default: ['Ctrl-C']
        description: 'The listed keybindings are not handled by the REPL and instead directly passed to Atom.'
        order: 5
      whitelistedKeybindingsTerminal:
        title: 'Whitelisted Keybindings for Terminals'
        type: 'array'
        default: []
        description: 'The listed keybindings are not handled by any terminals and instead directly passed to Atom.'
        order: 6
      cursorStyle:
        title: 'Cursor Style'
        type: 'string'
        enum: ['block', 'underline', 'bar']
        default: 'block'
        radio: true
        order: 7
      cursorBlink:
        title: 'Cursor Blink'
        type: 'boolean'
        default: false
        order: 8
      rendererType:
        title: 'Fallback Renderer'
        type: 'boolean'
        default: false
        description: 'Enable this if you\'re experiencing slowdowns in the built-in terminals.'
        order: 9
  remoteOptions:
    type: 'object'
    order: 5
    collapsed: true
    properties:
      remoteJulia:
        title: 'Command to execute Julia on the remote server'
        type: 'string'
        default: 'julia'
        order: 1
      tmux:
        title: 'Use a persistent tmux session'
        description: 'Requires tmux to be installed on the server you\'re connecting to.'
        type: 'boolean'
        default: false
        order: 2
      tmuxName:
        title: 'tmux session name'
        type: 'string'
        default: 'juno_tmux_session'
        order: 3
      agentAuth:
        title: 'Use SSH agent'
        description: 'Requires `$SSH_AUTH_SOCKET` to be set. Defaults to putty\'s pageant on Windows.'
        type: 'boolean'
        default: true
        order: 4
      forwardAgent:
        title: 'Forward SSH agent'
        type: 'boolean'
        default: true
        order: 5
  juliaSyntaxScopes:
    title: 'Julia Syntax Scopes'
    description:
      'The listed syntax scopes (comma separated) will be recoginized as Julia files.
       You may have to restart Atom to take an effect.\n
       **DO NOT** edit this unless you\'re sure about the effect.'
    type: 'array'
    default: ['source.julia', 'source.weave.md', 'source.weave.latex']
    order: 6

  firstBoot:
    type: 'boolean'
    default: true
    order: 99

if process.platform != 'darwin'
  config.consoleOptions.properties.whitelistedKeybindingsREPL.default =
    ['Ctrl-C', 'Ctrl-J', 'Ctrl-K', 'Ctrl-E', 'Ctrl-V', 'Ctrl-M']

if process.platform == 'darwin'
  config.consoleOptions.properties.macOptionIsMeta =
    title: 'Use Option as Meta'
    type: 'boolean'
    default: false
    order: 5.5

if process.platform == 'win32'
  config.juliaOptions.properties.enablePowershellWrapper =
    title: 'Enable Powershell Wrapper'
    type: 'boolean'
    default: true
    description: 'If enabled, use a Powershell wrapper to spawn Julia. Necessary to enable interrupts.'
    order: 99

module.exports = config
