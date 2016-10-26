let map = new Map([
    [0, 'zero'],
    [1, 'one'],
    [2, 'two'],
    [3, 'three'],
    [4, 'four'],
    [5, 'five'],
    [6, 'six'],
    [7, 'seven'],
    [8, 'eight'],
    [9, 'nine']
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
