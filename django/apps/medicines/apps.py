from django.apps import AppConfig


class MedicinesConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.medicines'
    
    def ready(self):
        import apps.medicines.signals 