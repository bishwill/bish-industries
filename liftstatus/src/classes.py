from dataclasses import dataclass
from src.enums import Status


@dataclass
class Lift:
    lift_id: int
    name: str
    status: Status
