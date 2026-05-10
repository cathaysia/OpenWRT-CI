#!/bin/bash
import requests

url = "http://192.168.68.1/jdcapi"
sessionid = "b30916p449a1dd82d97477b512791e99" # 浏览器登陆后，从cookie里拿sessionsid的值

# 查看dhcp配置
def get_dhcp_config():
    r = requests.post(url, json={
        "jsonrpc": "2.0",
        "id": 1,
        "method": "call",
        "params": [
            sessionid,
            "uci",
            "get",
            {
                "config":"dhcp",
                "section":"odhcpd"
            }
        ]
    })
    print(r.json())

def set_dhcp_config():
    r = requests.post(url, json={
        "jsonrpc": "2.0",
        "id": 1,
        "method": "call",
        "params": [
            sessionid,
            "uci",
            "set",
            {
                "config": "dhcp",
                "type":"odhcpd",
                "section": "odhcpd",
                "values":{
                    "leasetrigger":"/usr/sbin/dropbear"
                }
            }
        ]
    })
    print(r.json())

    r = requests.post(url, json={
        "jsonrpc": "2.0",
        "id": 1,
        "method": "call",
        "params": [
            sessionid,
            "uci",
            "commit",
            {
                "config": "dhcp"
             }
        ]
    })
    print(r.json())

if __name__ == "__main__":
    set_dhcp_config()
