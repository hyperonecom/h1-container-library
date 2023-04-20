const {spawn} = require('child_process');

const runProcess = (cmd, args = [], opts = {}) => new Promise((resolve, reject) => {
    const env = opts.env || {};
    console.log(`Started: ${cmd} ${args.join(' ')}`);
    const proc = spawn(cmd, args, {
        env: { ...process.env, ...env},
        stdio: 'inherit'
    });
    proc.on('close', (code) => {
        if (code !== 0) {
            return reject(new Error(`Process exited with code ${code}`));
        }
        return resolve();
    });
});

module.exports = {
    runProcess
};
