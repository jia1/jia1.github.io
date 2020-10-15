#!/bin/bash

rm -rf docs/!("CNAME") && hugo && git add . && git commit

