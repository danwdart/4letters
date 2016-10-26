let map = new Map([
    [0, 'zero'],
    [1, 'un'],
    [2, 'deux'],
    [3, 'trois'],
    [4, 'quatre'],
    [5, 'cinq'],
    [6, 'six'],
    [7, 'sept'],
    [8, 'huit'],
    [9, 'neuf']
]);

module.exports = (n) => {
    let sn = String(n),
        str = '';
    for (let c = 0; c < sn.length; c++) {
        let ch = sn.charAt(c),
            chn = Number(ch);
        str += map.get(chn);
    }
    return str.length;    
};
