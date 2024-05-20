#!/usr/bin/python3

import toml

class FilterModule(object):
    def filters(self):
        return {
            'from_toml': from_toml
        }

def from_toml(data):
    return toml.loads(data)