from celery import shared_task


@shared_task(name='sum two numbers')
def add(x, y):
    return x + y
