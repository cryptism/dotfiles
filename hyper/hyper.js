module.exports = {
  config: {

    fontSize: 12,

    fontFamily: '"Source Code Pro", "DejaVu Sans Mono", "Lucida Console", monospace',

    cursorShape: 'BLOCK',

    padding: '12px 14px 18px 14px',

    hyperline: {
      plugins: [
        {
          name: 'hostname',
          options: {
            color: 'red',
            username: true,
          },
        },
        {
          name: 'memory',
          options: {
            color: 'lightYellow',
          },
        },
        {
          name: 'cpu',
          options: {
            colors: {
              high: 'lightRed',
              moderate: 'lightYellow',
              low: 'lightGreen',
            },
          },
        },
        {
          name: 'network',
          options: {
            color: 'lightCyan',
          },
        },
        {
          name: 'ip',
          options: {
            color: 'blue',
          },
        },
      ],
    },
  },

  plugins: [
    'hyperlinks',
    'hyperterm-paste',
    'hyperterm-visor',
    'hyperterm-lastpass',
    'hyperterm-overlay',
  ],

  localPlugins: [
    'hyperline',
    'dark-dracula-theme'
  ]
};

module.exports.onWindow = browserWindow => browserWindow.setVibrancy('dark');
