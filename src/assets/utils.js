export function weightedRandom(items) {
  const totalWeight = items.reduce((sum, item) => sum + item.count, 0);
  let r =  Math.random() * totalWeight;

  for (const item of items) {
    r -= item.count;
    if (r <= 0) {
      return item;
    }
  }
}

export function sleep(ms) {
  return new Promise((r) => setTimeout(r, ms));
}