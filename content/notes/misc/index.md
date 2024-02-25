---
title: 'Miscellaneous Notes'
summary: 'Unorganized to be Organized'
description: 'Unorganized to be Organized'
disableShare: true
editPost:
  disabled: true
hideSummary: false
comments: false
searchHidden: true
hiddenInHomeList: true
private: true
---

## RGB Representation

- Why in Hexadecimal? convenient representation, makes easier to understand.
  - Hexadecimal -> `#FF FF FF`
  - Binary -> `#11111111 11111111 11111111`
  - Decimal -> `#255 255 255`
- FF -> represents 255

```bash
# Deep Understanding
  16^1 = 16   16^0 = 1
      *          *
      F          F
  = 16 * 15 + 1 * 15 = 255
```

## Big O vs Omega

- Big O - upper bound (O)
- Omega - lower bound (Ω)
- Theta -> both same
- space and time complexity are converse
- bubble sort sometimes can win if already sorted.

## Data Structure

- orphaned memory leads memory leaks. (linked list)

## Algorithms

### Weird Algorithm

```bash
sleep_sort() {
  while [ -n "$1" ]
  do
    (sleep $1; echo $1) &
    shift
  done
  wait
}
```
