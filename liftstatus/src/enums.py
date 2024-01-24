from enum import Enum


class Status(Enum):
    OPEN = "OPEN"
    CLOSED = "CLOSED"
    FORECAST = "FORECAST"
    DELAYED = "DELAYED"
    OUT_OF_PERIOD = "OUT_OF_PERIOD"


if __name__ == "__main__":
    status = Status("SCHEDULED")

    print(status == Status.SCHEDULED)
