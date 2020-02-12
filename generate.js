const fs = require('fs');
const util = require('util');
const readDir = util.promisify(fs.readdir);
const readFile = util.promisify(fs.readFile);
const writeFile = util.promisify(fs.writeFile);
const mkDir = util.promisify(fs.mkdir);
const stat = util.promisify(fs.stat);
const path = require('path');
const Mustache = require('mustache');

Mustache.escape = function(text) {return text;};

const ignoredDirectory = [
    'content',
    'node_modules',
];

const repo = 'h1cr.io/website';


async function saveTemplated(sourceFile, context, outputFile) {
    const template = await readFile(sourceFile, { encoding: 'utf-8' });
    const content = Mustache.render(template, context);
    await writeFile(outputFile, content, { encoding: 'utf-8' });
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
            await generateImage(sourceFile, outputFile, context);
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
        const sourceDir = path.join(repositoryDir, 'base');
        try{
            await stat(sourceDir);
        }catch{
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
            const tagConfig = config[tag].args || {};
            const imageName = `${repo}/${file}:${tag}`;

            const imageConfig = {
                IMAGE_NAME: imageName
            };

            await stat(path.join(output, '.skip_base')).catch(err => {
                if (err.code !== 'ENOENT') throw err;
                return generateImage(source, output, { ...imageConfig, ...tagConfig });
            });
            buildContent.push(`docker pull ${imageName} || echo 'Fail to pull ${imageName}'`);
            buildContent.push(`docker build --cache-from ${imageName} -t ${imageName} ${file}/${tag}`);
            deployContent.push(`docker push ${imageName}`);
            if (testEnabled) {
                const env = Object.entries(tagConfig).map(([key, value]) => `TEST_${key}=${JSON.stringify(value)}`).join(" ");
                testContent.push(`IMAGE="${imageName}" ${env} bats ${file}/test/*.bats`);
            }
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
