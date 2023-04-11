---
title: "CryptoJS and URL"
date: 2020-09-30T19:17:00+08:00
draft: false
tags: ["javascript"]
---
Like this [Stack Overflow thread](https://stackoverflow.com/questions/43399093/encrypt-cryptojs-without-special-characters), I needed to encrypt some string which will become part of a URL. However, there was a slash in one of the encrypted strings, like `c3ViamVjdHM/X2Q9MQ==`. Feel free to decode this. It's something I copied from the internet.

I thought there would be a lot of symbols in the Base64 alphabet at first (I was wrong). I didn't want to deal with them and set up a giant substitution map, like a `Map<string, string>`. As such, I converted the encrypted string to hex and did the necessary reversal at decryption. It seemed inappropriate because it's another dependency (see the `enc` import) and a possible performance bottleneck. (Afterwards, I went to validate my concerns. I found this [Stack Overflow thread](https://stackoverflow.com/questions/26943420/which-is-faster-hex-encoding-or-base64-encoding).)

Original code:

```typescript
import { AES } from 'crypto-js';
import Utf8 from 'crypto-js/enc-utf8';

const passphrase = 'blah';

export const encrypt = (plaintext: string) => {
    return AES.encrypt(plaintext, passphrase).toString();
};

export const decrypt = (cipher: string) => {
    return AES.decrypt(cipher, passphrase).toString(Utf8);
};
```

My initial solution:

```typescript
import { AES, enc } from 'crypto-js';
import Utf8 from 'crypto-js/enc-utf8';

const passphrase = 'blah';

export const encrypt = (plaintext: string) => {
    const encrypted = AES.encrypt(plaintext, passphrase).toString();
    const wordArray = enc.Base64.parse(encrypted);
    return enc.Hex.stringify(wordArray);
};

export const decrypt = (cipher: string) => {
    const wordArray = enc.Hex.parse(cipher);
    const toDecrypt = enc.Base64.stringify(wordArray);
    return AES.decrypt(toDecrypt, passphrase).toString(Utf8);
};
```

Feeling uncertain about my initial solution, I looked up the Base64 alphabet. `+`, `/` and `=` are the only non-alphanumeric symbols in the Base64 alphabet. That's very manageable. I then transformed my solution into:

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
    ['=', '~'],
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

I didn't need to use `replaceAll` because the regex already has a `g` flag. But I also couldn't use `replaceAll`. The TypeScript static analyser complained, "TS2339: Property 'replaceAll' does not exist on type 'string'." I really should take a look at and understand my product's webpack configurations...

TypeScript also made other things a little difficult for me. I could use neither `Array.from` nor the spread operator (i.e. `[...substitutionsAfterEncryption]`) on `Map<string, string>`. [This Stack Overflow thread](https://stackoverflow.com/questions/44451901/spread-syntax-with-map-doesnt-work) provides a possible explanation. So there were no shortcuts for me to invert a map like how these [ninjas in Stack Overflow](https://stackoverflow.com/questions/56550463/invert-a-map-object) do. Since there are only two keys in `substitutionsAfterEncryption`, I hardcoded `substitutionsBeforeDecryption`. I did not want to spend too much time on less critical optimisations.
