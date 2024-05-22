#!/usr/bin/python3

import toml

class FilterModule(object):
    def filters(self):
        return {
            'from_toml': self.from_toml
        }

    def from_toml(self, data):
        return toml.loads(data)