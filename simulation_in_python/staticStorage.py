import staticStorage


current_task_num = None
available_days = None


def set_current_task(new_current_task_num):
    staticStorage.current_task_num = new_current_task_num


def get_current_task_num():
    return int(staticStorage.current_task_num)

