let timer;

export const debounce = (value, handler) => {
  clearTimeout(timer);
  timer = setTimeout(() => {
    handler(value)
  }, 750);
};
