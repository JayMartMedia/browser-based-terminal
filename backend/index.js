const express = require('express');
const app = express();
const ws = require('express-ws')
const os = require('os');
const pty = require('node-pty');

ws(app);

const PORT = 8080;

// TODO: Move logging logic somewhere else
const logLevels = {
    DEBUG: 1,
    INFO: 2,
    WARN: 3,
    ERROR: 4
};

const logLevel = logLevels[process.env.LOG_LEVEL] ?? logLevels.INFO;

function log(level, ...rest) {
    if(!logLevel) return;
    if(level >= logLevel) {
        console.log(...rest);
    }
}

log(logLevels.INFO, "Starting...");

const shell = os.platform() === 'win32' ? 'powershell.exe' : 'bash';

app.use(express.static('public'));
// TODO: Fix these routes
app.use('/node_modules/xterm/lib', express.static('node_modules/xterm/lib'));
app.use('/node_modules/xterm-addon-fit/lib', express.static('node_modules/xterm-addon-fit/lib'));
app.use('/node_modules/xterm/css', express.static('node_modules/xterm/css'));

app.ws('/', (ws) => {
    // Create new PTY upon WS session creation
    const ptyProcess = pty.spawn(shell, [], {
        name: 'xterm-color',
        env: process.env,
        cwd: process.env.HOME,
        cols: 80,
        rows: 80,
    });
    log(logLevels.INFO, "New session...");
    
    // When UI sends message, resize or run command
    ws.on('message', message => {
        const processedMessage = messageProcessor(message)
        if (processedMessage.type === 'command') {
            ptyProcess.write(processedMessage.command);
        } else if (processedMessage.type === 'resize') {
            ptyProcess.resize(processedMessage.cols, processedMessage.rows)
        }
    })
    
    // When PTY returns data, send to UI
    ptyProcess.on('data', function (rawOutput) {
        const processedOutput = outputProcessor(rawOutput);
        ws.send(processedOutput);
    });
});

// Log and JSON parse message
const messageProcessor = function (message) {
    log(logLevels.DEBUG, JSON.parse(message));
    return JSON.parse(message);
}

const outputProcessor = function (output) {
    return output;
}

app.listen(PORT, () => {
    log(logLevels.INFO, "Listening...")
});
