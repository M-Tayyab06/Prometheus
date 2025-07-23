from prometheus_client import start_http_server, Summary, Counter, Gauge
import random
import time

REQUEST_TIME = Summary("request_processing_second","Time spend processing a request")
MY_COUNTER= Counter("my_counter","")
MY_GAUGE= Gauge("my_gauge","")


@REQUEST_TIME.time()
@MY_COUNTER.count_exceptions()
def process_request(t):
    MY_COUNTER.inc()
    MY_GAUGE.set(5)
    MY_GAUGE.inc(5)
    MY_GAUGE.dec(2)
    time.sleep(t)


if __name__ == '__main__':
    start_http_server(8000)
    while True:
        process_request(random.random())
    while True:
        A=1

    print("The end")
