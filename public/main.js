const {FitAddon} = window.FitAddon;

const PORT = 8080;

const WSS_URL = `ws://${window.location.host}`;

const socket = new WebSocket(WSS_URL);
socket.onmessage = (event) => {
    term.write(event.data);

}

socket.onopen = () => {
    console.log('Connected');
    sendResize();
}

const term = new window.Terminal({
    cursorBlink: true,
    cols: 80,
});
const fitAddon = new FitAddon();
term.loadAddon(fitAddon);
term.open(document.getElementById('terminal'));

function init() {
    if (term._initialized) {
        return;
    }

    term._initialized = true;

    term.onKey(keyObj => {
        runCommand(keyObj.key);
    });

    fitAddon.fit();   

    window.onresize = () => {
        fitAddon.fit()
    }

    term.onResize(() => sendResize())
}

function runCommand(command) {
    console.debug(`Sending command: "${command}"`);
    socket.send(JSON.stringify({
        type: "command",
        command: command
    }));

}

function sendResize() {
    socket.send(JSON.stringify({
        type: "resize",
        rows: term.rows,
        cols: term.cols
    }))
}

init();
