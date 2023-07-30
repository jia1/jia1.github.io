---
title: "The SSH command"
date: 2023-07-30T15:26:28+08:00
draft: false
tags: ["cli"]
---
This is what `man ssh` gives:

> ssh (SSH client) is a program for logging into a remote machine and for executing commands on
> a remote machine.  It is intended to provide secure encrypted communications between two
> untrusted hosts over an insecure network.  X11 connections, arbitrary TCP ports and
> UNIX-domain sockets can also be forwarded over the secure channel.

A simple usage would be:

```bash
ssh $USERNAME@$TARGET_HOST
```

And you will be prompted for your password.

But if `$TARGET_HOST` is in a separate security zone, one way to access it would be through a jump host. And in GPT-3.5's words:

> A jump host is a specialized computer on a network that serves as an intermediary or gateway between two other systems. Its primary purpose is to provide a secure access point for administrators or users to connect to other devices or systems within a private network. Jump hosts are commonly used in situations where direct access to the internal systems is restricted for security reasons.

Then, to set up an SSH tunnel where connections to my computer's port `1234` are forwarded to a target host's port `5678` through a jump host, this is one way to do it:

```bash
ssh -i $PRIVATE_KEY_FILE -L 1234:$TARGET_HOST:5678 $USERNAME@$JUMP_HOST
```

The `-i` option tells the command to read `$PRIVATE_KEY_FILE` for authentication. The `-L` option tells the command to forward connections, where the source and target are specified by `port:host:hostport`.
