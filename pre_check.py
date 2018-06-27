# -*- coding: utf-8 -*-
import os
import glob


def parse_dockerfile(filepath):
    try:
        file = open(filepath, 'rb')
        for line in file:
            if line.startswith('FROM ci.basin.ali:5006'):
                print '[%s] check ok' % filepath
                return True
        return False
    finally:
        file.close()


def parse_requirements(filepath):
    try:
        file = open(filepath, 'rb')
        for line in file:
            if line.find("==") < 0:
                print '[%s] [%s] check fail' % (filepath, line.strip('\r\n'))
                return False
        return True
    finally:
        file.close()


parse_dic = {
    'Dockerfile': parse_dockerfile,
    'requirements.txt': parse_requirements,
}


def enumfile(rootDir):
    for fileitem in os.listdir(rootDir):
        path = os.path.join(rootDir, fileitem)
        # if fileitem == 'Dockerfile'
        if parse_dic.has_key(fileitem):
            if parse_dic[fileitem](path) == False:
                raise Exception("check docker depends fail")
        if os.path.isdir(path):
            enumfile(path)


if __name__ == '__main__':
    enumfile('./')
