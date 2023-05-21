# Todo

## Multipass *not* working with a mount

*Why cannot it resolve the file?*

```
$ multipass shell

$ cd work

ubuntu@a746ae:~/work$ bun run ./index.js


error: Could not resolve: "/home/ubuntu/work/index.js"

import * as start from '/home/ubuntu/work/index.js';
                       ^
bun:main:3:24 85

error: Could not resolve: "/home/ubuntu/work/index.js"

export * from '/home/ubuntu/work/index.js';
              ^
```

<!--
```
multipass exec a746ae -- sh -c 'pwd && bun run start'
/home/ubuntu/work
$ bun run index.ts


error: Could not resolve: "/home/ubuntu/work/index.ts"

import * as start from '/home/ubuntu/work/index.ts';
                       ^
bun:main:3:24 85

error: Could not resolve: "/home/ubuntu/work/index.ts"

export * from '/home/ubuntu/work/index.ts';
              ^
bun:main:4:15 129error: script "start" exited with code 1 (SIGHUP)
make: *** [all] Error 1
```
-->

`bun run start` starts, because it prints `bun run index.ts` - but then cannot even read `index.ts`.
