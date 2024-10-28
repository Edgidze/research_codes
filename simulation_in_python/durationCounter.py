import time
import logging as log


# time duration counter
class DurationCounter:
    def __init__(self):
        self.start = time.time()

    # returns duration in minutes
    def get_duration(self):
        return (time.time() - self.start) / 60

    def get_printed_process_duration(self):
        print('The process performed in ', self.get_duration(), ' minutes.')

    def get_printed_duration_for_smth(self,
                                      smth):
        log.info(' ' + smth + ' performed in ' + str(self.get_duration()) + ' minutes.')
