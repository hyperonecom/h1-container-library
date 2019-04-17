const fs = require('fs');
const util = require('util');
const readDir = util.promisify(fs.readdir);
const readFile = util.promisify(fs.readFile);
const writeFile = util.promisify(fs.writeFile);
const mkDir = util.promisify(fs.mkdir);
const stat = util.promisify(fs.stat);
const path = require('path');

PHP_VERSION = ['7.2', '5.6'];

async function saveTemplated(sourceFile, context, outputFile) {
    let content = await readFile(sourceFile, {encoding: 'utf-8'});
    for (const [key, value] of Object.entries(context)) {
        content = content.replace(new RegExp(`%%${key}%%`, 'g'), value);
    }
    await writeFile(outputFile, content, {encoding: 'utf-8'}, );
    console.log(`Saved templated '${sourceFile}' into '${outputFile}'`)
}

const generateImage = async (source, output, context) => {
    const files = await readDir(source);
    await mkDir(output).catch(err => {
        if(err.code !== 'EEXIST') throw err;
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
    let buildContent = ['#!/bin/sh'];
    const files = await readDir(__dirname);
    for (const file of files) {
        if(file.startsWith('.')){
            continue;
        }
        const repositoryDir = path.join(__dirname, file);
        const s = await stat(repositoryDir);
        if (!s.isDirectory()) {
            continue;
        }
        for (const version of PHP_VERSION) {
            const source = path.join(repositoryDir, 'base');
            const output = path.join(repositoryDir, version);
            console.log({file, version});
            await generateImage(source, output, {
                PHP_VERSION: version
            });
            buildContent.push(`docker build -t hyperone/${file}:${version} ${file}/${version}`)
        }
    }
    await writeFile(path.join(__dirname, 'build.sh'), buildContent.join("\n"));
};

main().then(console.log).catch(err => {
    console.error(err);
    console.error(err.stack);
});