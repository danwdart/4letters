// DANGEROUS! I'm not responsible if you bork your system.
const parserfile = process.argv[2];

(async () => {
    const parser = (await import(`./parsers/${parserfile}`)).default;

    for (let i = 1; i <= 100; i++) {
        let out = i,
            //n = 0,
            minimum = Infinity;

        //while (true) {
        const out2 = parser(out);
        minimum = Math.min(minimum, out);
        //console.log({i, minimum, out, out2});
        //n++;
        out = out2;
        //}
        //console.log({i, n, minimum});
    }
})();
