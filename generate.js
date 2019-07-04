const fs = require('fs');
const util = require('util');
const readDir = util.promisify(fs.readdir);
const readFile = util.promisify(fs.readFile);
const writeFile = util.promisify(fs.writeFile);
const mkDir = util.promisify(fs.mkdir);
const stat = util.promisify(fs.stat);
const path = require('path');

const ignoredDirectory = [
    'content'
];

const repos = ['quay.io', '5d08fcb2ca3915e50f7c2c55.registry.pl-waw-1.hyperone.cloud'];

async function saveTemplated(sourceFile, context, outputFile) {
    let content = await readFile(sourceFile, {encoding: 'utf-8'});
    for (const [key, value] of Object.entries(context)) {
        content = content.replace(new RegExp(`%%${key}%%`, 'g'), value);
    }
    await writeFile(outputFile, content, {encoding: 'utf-8'},);
    console.log(`Saved templated '${sourceFile}' into '${outputFile}'`)
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
            continue;
        }
        await saveTemplated(sourceFile, context, outputFile);
    }
};

const main = async () => {
    let buildContent = ['#!/bin/sh', 'set -eux'];
    let deployContent = ['#!/bin/sh', 'set -eux'];
    let testContent = ['#!/bin/sh', 'set -eux'];
    const files = await readDir(__dirname);
    for (const file of files) {
        if (file.startsWith('.') || ignoredDirectory.includes(file)) {
            continue;
        }
        const repositoryDir = path.join(__dirname, file);
        const s = await stat(repositoryDir);
        if (!s.isDirectory()) {
            continue;
        }
        const config = require(await path.join(repositoryDir, 'tags.json'));
        for (const tag of Object.keys(config)) {

            let testEnabled = true;
            await stat(path.join(repositoryDir, 'test')).catch(() => {
                testEnabled = false;
            });
            const source = path.join(repositoryDir, 'base');
            const output = path.join(repositoryDir, tag);
            await generateImage(source, output, config[tag].args || {});
            repos.forEach((name, index) => {
                const imageName = `${name}/hyperone/${file}:${tag}`;
                buildContent.push(`docker build -t ${imageName} ${file}/${tag}`);
                deployContent.push(`docker push ${imageName}`);
                if (index === 0 && testEnabled) {
                    testContent.push(`IMAGE="${imageName}" bats ${file}/test/*`);
                }
            });
        }
    }
    await writeFile(path.join(__dirname, 'build.sh'), buildContent.join("\n"));
    await writeFile(path.join(__dirname, 'test.sh'), testContent.join("\n"));
    await writeFile(path.join(__dirname, 'deploy.sh'), deployContent.join("\n"));
};

main().then(console.log).catch(err => {
    console.error(err);
    console.error(err.stack);
    process.exit(1);
});
