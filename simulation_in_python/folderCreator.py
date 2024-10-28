import os
import logging as log
from datetime import datetime
import pytz


def create_folder(path):
    # check whether directory already exists
    if not os.path.exists(path):
        os.mkdir(path)
        log.info(
            ' ' + str(datetime.now(pytz.timezone('Europe/Moscow')).strftime("%H:%M:%S")) +
            ' Folder %s created!' % path)
