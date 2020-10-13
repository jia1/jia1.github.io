---
title: "TypeScript Shortcuts"
date: 2020-10-01T19:01:00+08:00
draft: false
tags: ["software","javascript","typescript"]
---
TL;DR: I learnt how to (invert a map) and (copy a map and override the values of the copy) in TypeScript. Ctrl+F `TYPESCRIPT_SHORTCUT_1` and `TYPESCRIPT_SHORTCUT_2` to get to the code.

Context: Yesterday, I did not invest time into inverting a TypeScript `Map<string, string>`. Today, I received feedback that I should extract the encode logic into a function of its own. I decided to put in more effort.

Here's the new original code:

```typescript
import { AES } from 'crypto-js';
import Utf8 from 'crypto-js/enc-utf8';

const passphrase = 'blah';
const substitutionsAfterEncryption: Map<string, string> = new Map([
    ['+', '-'],
    ['/', '_'],
    ['=', '~'],
]);
const substitutionsBeforeDecryption: Map<string, string> = new Map([
    ['-', '+'],
    ['_', '/'],
    ['~', '='],
]);

export const encrypt = (plaintext: string) => {
    const encrypted = AES.encrypt(plaintext, passphrase).toString();
    return encrypted.replace(
        /[+/=]/g,
        (match: string) => substitutionsAfterEncryption.get(match) ?? match
    );
};

export const decrypt = (cipher: string) => {
    const toDecrypt = cipher.replace(
        /[-_~]/g,
        (match: string) => substitutionsBeforeDecryption.get(match) ?? match
    );
    return AES.decrypt(toDecrypt, passphrase).toString(Utf8);
};
```

Here's the updated code:

```typescript
import { AES } from 'crypto-js';
import Utf8 from 'crypto-js/enc-utf8';

const passphrase = 'blah';
const encodeMap = new Map([
    ['+', '-'],
    ['/', '_'],
    ['=', '~'],
]);
// Inverting a map in TypeScript is more problematic than in JavaScript.
// The extra .map call is to tell TypeScript that it is dealing with an
// iterable of 2-tuples instead of string[][].
// See https://github.com/microsoft/TypeScript/issues/8936.
const decodeMap = new Map(
    Array.from(encodeMap, (tuple) => tuple.reverse()).map<[string, string]>((array) => [
        array[0],
        array[1],
    ])
);

const replaceSymbols = (cipher: string, substitutionMap: Map<string, string>) => {
    const symbols = Array.from(substitutionMap.keys()).join('');
    return cipher.replace(
        new RegExp(`[${symbols}]`, 'g'),
        (match: string) => substitutionMap.get(match) ?? match
    );
};

export const encrypt = (plaintext: string) => {
    return replaceSymbols(AES.encrypt(plaintext, passphrase).toString(), encodeMap);
};

export const decrypt = (cipher: string) => {
    return AES.decrypt(replaceSymbols(cipher, decodeMap), passphrase).toString(Utf8);
};
```

While I failed to shorten the code, I reduced the number of literals. I'm left with `encodeMap` and the regex now. From this experience, I figured out why I could not invert a map like [how it's done in JavaScript](https://stackoverflow.com/questions/56550463/invert-a-map-object). It's a [typing ambiguity](https://github.com/microsoft/TypeScript/issues/8936) (refer to the comments above).

So, to invert a map in TypeScript, do:

```typescript
// TYPESCRIPT_SHORTCUT_1: Inverting a map
// Remember to replace THE_MAP_YOU_WANT_TO_INVERT, KEY_TYPE and VALUE_TYPE.
new Map(
    Array.from(THE_MAP_YOU_WANT_TO_INVERT, (tuple) => tuple.reverse()).map<[VALUE_TYPE, KEY_TYPE]>((array) => [
        array[0],
        array[1],
    ])
)
```

Later in the day, I was firefighting a bug. I realised that I was the one who introduced the regression that went unnoticed for a while. At least I got to clean up my own mess... The bug occurred because I was iterating through a TypeScript map keys [the JavaScript (wrong) way](https://stackoverflow.com/questions/36467369/looping-through-an-object-and-changing-all-values).

The wrong way:

```typescript
// Remember to replace THE_MAP_YOU_WANT_TO_COPY and 'BLAH'.
// You shouldn't be copying this anyway.
Object.keys(
    THE_MAP_YOU_WANT_TO_COPY
).reduce((accumulator, key) => {
    accumulator.set(key, 'BLAH'));
    return accumulator;
}, new Map<string, string>());
```

Correct way:

```typescript
// TYPESCRIPT_SHORTCUT_2: Copying a map and overriding the values of the copy
// Remember to replace THE_MAP_YOU_WANT_TO_COPY and 'BLAH'.
Array.from(
    THE_MAP_YOU_WANT_TO_COPY.keys()
).reduce((accumulator, key) => {
    accumulator.set(key, 'BLAH'));
    return accumulator;
}, new Map<string, string>());
```

So much for copying. I hope I can more careful with these in the future.
