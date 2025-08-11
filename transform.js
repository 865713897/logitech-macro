const transform = (str = '') => {
  const arr = str.replaceAll('&#', '').split(';');
  return `Utf8Char(${arr.join(',')})`
};
