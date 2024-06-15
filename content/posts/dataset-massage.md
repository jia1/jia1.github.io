---
title: "Dataset Massage (head, tail, split)"
date: 2024-06-15T10:16:48+08:00
draft: false
tags: ["cli"]
---
Recently at work, I found an opportunity to revise / level-up my bash-fu. It probably sounds mundane and trivial to some, but I had fun solving my little problem with the command line instead of retreating into Python or JavaScript.

I received a CSV file containing millions of rows. My job is to split this file into a couple of smaller files, with each file containing an increasing number of rows.

Assuming there are no CSV headers (minor details like this can be postponed, but not forgotten!), and suppose I want to split my files in this manner:

1. 1,000 lines
2. 2,000 lines
3. 5,000 lines
4. 10,000 lines
5. 20,000 lines
6. 50,000 lines
7. 100,000 lines
8. And so on

The first command I stumbled upon was [`split`](https://stackoverflow.com/questions/2016894/how-can-i-split-a-large-text-file-into-smaller-files-with-an-equal-number-of-lin).

I tried solving my problem with just `split`, like:

1. Split into files containing 1,000 lines each
2. Keep the first file from (1)
3. Shave off 1,000 lines from the original file
4. Split the file from (3) into 2,000 lines each
5. Keep the first file from (4)
6. Repeat steps 3-5 but remember to increase the number of lines to split/shave

I used `tail` to shave the file. Usage:

```bash
# Write to output.csv, starting from the 1001st line of file.csv
tail -n +1001 file.csv > output.csv
```

Why `-n` and why `+`?

```bash
man tail

# tail – display the last part of a file

# -n number, --lines=number
#         The location is number lines.

# Numbers having a leading plus ('+') sign are relative to the beginning of the input
# Numbers having a leading minus ('-') sign or no explicit sign are relative to the end of the input
```

Well, `split` and `tail` worked. But that was a lot of unnecessary I/O. If I were to use a programming language, I would iterate through the lines of the file instead of copying parts of the file multiple times.

I consulted [Pair](https://pair.gov.sg/) and it suggested the use of `head`. Putting `tail` and `head` together, I get:

```bash
head -n 1000 file.csv > output_1.csv
tail -n +1001 file.csv | head -n 2000 > output_2.csv
```

It's also possible to use `head` first, before piping the output into `tail`. To me, starting with `tail` helped me better visualise the front part of the file getting isolated and then taking the first X lines from this isolated part.

Using `head` first would mean you're taking a larger chunk of the file from the front and then reading from the back of this chunk to shave off the very first part. According to the manual (`man head`), `head` traverses in only one direction - from the start.

Finally, I had a couple of `tail ... | head ...` commands. While this meant the file was opened and read from the start again and again, at least I didn't have to produce so many intermediate output files. For my use case, it was still a quick operation, and I didn't optimise the script any further.
