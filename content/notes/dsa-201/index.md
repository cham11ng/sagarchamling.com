---
title: 'Data Structure and Algorithms 201'
summary: 'Data Structure and Algorithms Notes'
description: 'Data Structure and Algorithms Notes'
disableShare: true
editPost:
  disabled: true
hideSummary: false
comments: false
searchHidden: true
hiddenInHomeList: true
private: true
---

## greedy algorithms

- the simplest algorithms that exist, and they often seem to be a very natural thing to try when you're solving a problem.
- subproblem is a similar problem of smaller size.
- greedy choice is a safe choice if there is an optimal solution consistent with this first choice.

### ingredients

#### reduction to subproblem

- make some first choice
- then solve a problem of the same kind
- smaller: few digits, fewer patients
- this is called a 'subproblem'

#### safe choice

- a choice called safe if there is an optimal solution consistent with this first choice.
- not all first choices are safe.
- greedy choices are often unsafe.

### general strategy

- make a greedy choice
- prove that it is a safe choice.
- reduce to a subproblem
- solve the subproblem

```bash
          greedy choice
Problem -------------------------> Safe Choice
```
