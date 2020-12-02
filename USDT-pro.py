# -*- coding: utf-8 -*-
import requests
requests.packages.urllib3.disable_warnings()
import time
import threading
import sys
url=sys.argv[1]
header={
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36'
}


def http_200(url):
    http_res = requests.get(url=url, timeout=10).status_code
    while http_res != '200':
        print('waiting for process')
        time.sleep(1)






if __name__ == '__main__':