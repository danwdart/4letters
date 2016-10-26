// DANGEROUS! I'm not responsible if you bork your system.
let parserfile = process.argv[2],
    parser = require('./parsers/' + parserfile),
    results = new Map();

for (let i = 1; i <= 1000000; i++) {
    console.log(i);
    let out = i,
        out2 = null,
        visited = new Set();

    while (out2 !== out && !visited.has(out)) {
        out2 = out;
        out = parser(out2);
        visited.add(out);
    }
    console.log(visited);
    let freq = results.get(out);
    results.set(out, (freq ? freq + 1 : 1));
    //console.log(i, '=>', out2);
}

console.log(results);
