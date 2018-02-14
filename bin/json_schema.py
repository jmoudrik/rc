#!/usr/bin/env python3
import sys
import json


def shorten(s):
    if len(s) < 30:
        return s

    return "%s... [length=%d B]"%(s[:25], len(s))

def map_obj(o):
    if isinstance(o, list):
        return [ map_obj(a) for a in o ]

    if isinstance(o, dict):
        return { map_obj(a):map_obj(b) for a,b in o.items() }

    if isinstance(o, str):
        return shorten(o)

    return o


def f(obj):
    print(repr(obj))
    return obj

def one(fin):
    js = json.load(fin)
    return map_obj(js)

def iter_input():
    if len(sys.argv) <= 1:
        yield sys.stdin

    for filename in sys.argv[1:]:
        if filename == '-':
            yield sys.stdin
            continue

        with open(filename, 'r') as fin:
            yield fin

def one2str(fin, indent=4):
    return json.dumps(one(fin), indent=indent)

if __name__ == "__main__":
    for fin in iter_input():
        print(one2str(fin))
