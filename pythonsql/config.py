#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov 16 13:50:30 2019

@author: Greg
"""

#!/usr/bin/python
from configparser import ConfigParser
 
 
def config(filename='database.ini', section='postgresql'):
    # create a parser
    parser = ConfigParser(interpolation=None)
    # read config file
    parser.read(filename)
 
    # get section, default to postgresql
    db = {}
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
    else:
        raise Exception('Section {0} not found in the {1} file'.format(section, filename))
 
    return db