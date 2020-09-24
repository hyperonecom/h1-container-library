'use strict';
const fs = require('fs');
const path = require('path');

const repository = 'h1cr.io/website';
const indexFile = 'README.md';
const markerStart = `<!-- toc-start -->\n`;
const markerEnd = `<!-- toc-end -->\n`;

const listImage = async () => {
    const images = [];
    for (const name of fs.readdirSync(__dirname)) {
        let config;
        try {
            config = require(await path.join(__dirname, name, 'tags'));
        } catch (err) {
            continue;
        }
        const tags = Object.keys(config);
        const packages = Object.values(config).map(x => x.packages).flat().filter(x => !!x);

        images.push({ name, tags, packages })
    }
    return images;
};

const quote = (v) => '```' + v + '```';

const generateToc = (images) => {
    const line = [];
    line.push('| Image | Tag | Repology latest |')
    line.push('|------ | --- | --------------- |');
    for (const image of images) {
        const row = [
            quote(`${repository}/${image.name}`),
            image.tags.map(x => quote(x)).join(', '),
            image.packages.map(x => `![Package: ${x}](https://repology.org/badge/latest-versions/${x}.svg?header=${x})`).join(' ')
        ];
        line.push(`| ${row.join(' | ')} |`);
    };
    return line.join("\n") + "\n";
};

const updateIndex = async (index) => {
    const source = await fs.promises.readFile(indexFile, { encoding: 'utf-8' });
    const start = source.substring(0, source.indexOf(markerStart));
    const end = source.substring(source.indexOf(markerEnd) + markerEnd.length);
    const output = `${start}${markerStart}${index}${markerEnd}${end}`;
    await fs.promises.writeFile(indexFile, output);
};

const main = async () => {
    const images = await listImage();
    const index = generateToc(images);
    await updateIndex(index);
};

main().then(console.log).catch(err => {
    console.error(err);
    console.error(err.stack);
    process.exit(1);
});
