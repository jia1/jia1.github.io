---
title: "Data Wrangling"
date: 2020-09-22T21:14:00+08:00
draft: false
tags: ["nushackers","cli"]
---
I managed to catch one of the NUS Hackers' workshops, "Hacker Tools: Data Wrangling" by Julius. I got to learn many new things since I don't use CLI for text processing. Julius' slides are in [his GitHub repo](https://github.com/indocomsoft/hackertools-slides/blob/master/3-data-wrangling/data-wrangling.pdf).

Below is a very brief and dry summary of what is more important to me. If I "miss" something out, it's likely because I remembered it before. This summary does no justice to the workshop, but I want to write them down here before I forget.

##### `cat TEXT | grep -vE REGEX`

Get all lines from `TEXT` which don't match `REGEX`. `-v` means invert match and `-E` means extended regex.

##### `cat TEXT | grep -E '.*' | sed s/REGEX/SUBSTITUTION/FLAGS`

Substitute `REGEX` match(es) in `TEXT` with `SUBSTITUTION`. `SUBSTITUTION` can be a capture group i.e. `\1`, `\2`, `\3` and so on.

##### `| sort -nk1,2`

Sort lines numerically (not lexicographically i.e. `1, 2, 10` instead of `1, 10, 2`) (`-n`). Sort only by the 1st to 2nd whitespace-separated column (`-k1,2`). `-k` stands for sort key. Search for `KEYDEF` in `man sort` to find out more.

##### `| uniq -c`

Collapse **adjacent** lines which are duplicates of each other. Prefix each unique line with the total number of lines which collapsed into one (the count).

##### `| awk '$1 == 1 && $2 ~ /^r[^ ]*t$/ { print $3 }'`

`awk` is a programming language with the basic syntax: `awk PATTERN { DO THIS IF PATTERN MATCHES }`. In the (partial) command above, the pattern is `$1 == 1 && $2 ~ /^r[^ ]*t$/`.

`$1` and `$2` are the first and second elements, with whitespace as the default delimiter. For the lines which match the pattern, print the 3rd element (`$3`). For the lines which don't match the pattern, do nothing. These lines don't get printed and we can count the number of matches with `| wc -l`.

##### `| paste -sd, -`

Combine lines from the standard output with the specified delimiter (`,` in this case). `-s` means serial input e.g. a single file or a bunch of text lines. `-d` means delimiter and `,` is the delimiter.

##### `| bc`

A calculator which reads and interprets text i.e. something which can return "3" when you pass in "1 + 2".

##### `| xargs COMMAND`

Split standard output before the pipe into whitespace-delimited arguments and fed into `COMMAND`.

##### `cat TEXT | tr "a" "z"`

Replace (or "translate") "a" with "z" in `TEXT`.
