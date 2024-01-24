import requests
from pprint import pprint
import json
from src.classes import Lift
from src.enums import Status
from typing import List

BASE_URL = "https://lumiplay.link/interactive-map-services/public/map/bd632c91-6957-494d-95a8-6a72eb87e341/{}?lang=en"
STATIC_URL = BASE_URL.format("staticPoiData")
DYNAMIC_URL = BASE_URL.format("dynamicPoiData")


def transform_dynamic_data(data: dict):
    d = {}
    if data.get("items") is None:
        raise KeyError(
            "Could not find the 'items' attribute in the dynamic data response"
        )

    for item in data.get("items"):
        _id, status = (item["id"], item["openingStatus"])
        d[_id] = Status(status)

    return d


def get_data() -> List[Lift]:
    static_data = requests.get(STATIC_URL).json()["items"]

    dynamic_data = requests.get(DYNAMIC_URL).json()
    dynamic_data = transform_dynamic_data(dynamic_data)

    lift_data = []
    for item in static_data:
        data = item["data"]
        if data["type"] == "LIFT":
            lift_id, name = (data["id"], data["name"])
            status = dynamic_data[lift_id]

            lift = Lift(lift_id=lift_id, name=name, status=status)
            lift_data.append(lift)

    return lift_data


def lambda_handler(event, context):
    lifts = get_data()

    print(lifts)


if __name__ == "__main__":
    lambda_handler(None, None)
