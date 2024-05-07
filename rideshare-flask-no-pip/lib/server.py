import os
import time
from flask import Flask
from bike.bike import order_bike
from car.car import order_car
from scooter.scooter import order_scooter


app = Flask(__name__)

@app.route("/bike")
def bike():
    order_bike(0.2)
    return "<p>Bike ordered</p>"


@app.route("/scooter")
def scooter():
    order_scooter(0.3)
    return "<p>Scooter ordered</p>"


@app.route("/car")
def car():
    order_car(0.4)
    return "<p>Car ordered</p>"

class CellClsIssueTypeType(type):
    def __init__(cls, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def __call__(cls, *args, **kwargs):
        n = 239
        for i in range(200000):
            n = n + n

class CellClsIssueType(metaclass=CellClsIssueTypeType):
    pass

@app.route("/cell_cls_issue")
def cell_cls_issue():
    a = CellClsIssueType()
    return "<p>cell_cls_issue response</p>"


@app.route("/")
def environment():
    result = "<h1>environment vars:</h1>"
    for key, value in os.environ.items():
        result +=f"<p>{key}={value}</p>"
    return result

if __name__ == '__main__':
    app.run(threaded=False, processes=1, host='0.0.0.0', debug=False)

