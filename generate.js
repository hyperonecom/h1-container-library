const fs = require('fs');
const util = require('util');

const readDir = util.promisify(fs.readdir);
const readFile = util.promisify(fs.readFile);
const writeFile = util.promisify(fs.writeFile);
const mkDir = util.promisify(fs.mkdir);
const stat = util.promisify(fs.stat);
const chmod = util.promisify(fs.chmod);
const { runProcess } = require('./lib');
const path = require('path');
const Mustache = require('mustache');
const argv = require('minimist')(process.argv.slice(2));
Mustache.escape = function (text) { return text; };

const ignoredDirectory = [
    'content',
    'node_modules'
];

const repo = argv.repository || 'h1cr.io/website';

async function saveTemplated(sourceFile, context, outputFile) {
    const template = await readFile(sourceFile);
    if (outputFile.endsWith('.db')) {
        await writeFile(outputFile, template);
    } else {
        const content = Mustache.render(template.toString('utf-8'), context);
        await writeFile(outputFile, content, { encoding: 'utf-8' });
    }
    console.log(`Saved templated '${sourceFile}' into '${outputFile}'`);
}

const generateImage = async (source, output, context) => {
    const files = await readDir(source);
    await mkDir(output).catch(err => {
        if (err.code !== 'EEXIST') throw err;
    });
    for (const file of files) {
        const sourceFile = path.join(source, file);
        const outputFile = path.join(output, file);
        const s = await stat(sourceFile);
        if (s.isDirectory()) {
            await generateImage(sourceFile, outputFile, context);
            continue;
        }
        await saveTemplated(sourceFile, context, outputFile);
        await chmod(outputFile, s.mode);
    }
};

const usage = `
Usage: node generate.js -f image [--bats bats-path] [-g|-b|-t|-p]

-f image directory (one or more, separated by coma, eg: node,node-console)
-g generate
-b build
-p push
-t test
`.trimStart();

const main = async () => {
    if (!argv.f) {
        console.error(usage);
        process.exit(-1);
    }

    if (!argv.g && !argv.b && !argv.t && !argv.p) {
        console.error('Abort. Nothing to do!');
        return;
    }
    const files = await readDir(__dirname);

    for (const file of files) {
        if (file.startsWith('.') || ignoredDirectory.includes(file)) {
            continue;
        }
        if (!argv.f.split(',').includes(file)) {
            continue;
        }
        const repositoryDir = path.join(__dirname, file);
        const s = await stat(repositoryDir);
        if (!s.isDirectory()) {
            continue;
        }
        const sourceDir = path.join(repositoryDir, 'base');
        try {
            await stat(sourceDir);
        } catch {
            console.log(`Unable to access ${sourceDir}. Skip file`);
            continue;
        }
        const config = require(await path.join(repositoryDir, 'tags'));
        for (const tag of Object.keys(config)) {
            let testEnabled = true;
            await stat(path.join(repositoryDir, 'test')).catch(() => {
                testEnabled = false;
            });
            const source = path.join(repositoryDir, 'base');
            const output = path.join(repositoryDir, tag);
            const tagContext = config[tag].args || {};
            const imageName = `${repo}/${file}`;

            const imageConfig = {
                IMAGE_NAME: imageName,
                TAG: tag,
                LATEST: config[tag].latest
            };
            await stat(path.join(output, '.skip_base')).catch(err => {
                if (err.code !== 'ENOENT') throw err;
                if (argv.g) {
                    return generateImage(source, output, { ...imageConfig, ...tagContext });
                };
            });
            if (argv.b) {
                await build(imageName, tag, file, config);
            }
            if (argv.t) {
                if (!testEnabled) {
                    console.log(`Tests not available for ${imageName}`);
                } else {
                    await test(imageName, tag, tagContext, file);
                }
            };
            if (argv.p) {
                await push(imageName, tag, config);
            }
        }
    }
};

main().catch(err => {
    console.error(err);
    console.error(err.stack);
    process.exit(1);
});

async function push(imageName, tag, config) {
    await runProcess('docker', ['push', `${imageName}:${tag}`]);
    if (config[tag].latest) {
        await runProcess('docker', ['tag', `${imageName}:${tag}`, `${imageName}:latest`]);
        await runProcess('docker', ['push', `${imageName}:latest`]);
    }
}

async function test(imageName, tag, tagContext, file) {
    const env = { IMAGE: `${imageName}:${tag}` };
    console.log('testing', env);
    Object.entries(tagContext).map(([key, value]) => {
        env[`TEST_${key}`] = JSON.stringify(value);
    });
    await runProcess(process.env.BATS_PATH || 'bats', [`${file}/test/run.bats`], { env });
}

async function build(imageName, tag, file) {
    let cache = ['--cache-from', `${imageName}:${tag}`];
    await runProcess('docker', ['pull', `${imageName}:${tag}`]).catch(err => {
        console.log(`Fail to pull '${imageName}:${tag}':${err}`);
        cache = [];
    });
    await runProcess('docker', ['build', ...cache, '-t', `${imageName}:${tag}`, `${file}/${tag}`]);
}

