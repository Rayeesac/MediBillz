from distutils.debug import DEBUG
import environ

import os

env = environ.Env(
    DEBUG=(bool, False)
)
