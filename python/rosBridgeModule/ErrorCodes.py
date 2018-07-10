# H2020 ESROCOS Project
# Company: GMV Aerospace & Defence S.A.U.
# Licence: GPLv2

from enum import Enum

class ErrorCodes(Enum):
    ARGS_ERROR = 1
    MODEL_ERROR = 2
    ENV_ERROR = 3
    SYSCMD_ERROR = 4
    EXCEP_ERROR = 5
    OK = 0
