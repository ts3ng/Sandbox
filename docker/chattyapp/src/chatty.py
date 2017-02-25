import logging
import time
import SimpleHTTPServer
import SocketServer

def healthcheck():
 Handler = SimpleHTTPServer.SimpleHTTPRequestHandler
 httpd = SocketServer.TCPServer(("", 8000), Handler)
 httpd.serve_forever()


def logger():
  while True:
    logging.basicConfig(level=logging.INFO)
    logging.info("{\"app:\":\"applicationdef1.imagedef\",\"index\":\"test-index\",\"message\":\"TEST MESSAGE\",\"sourceytype\":\"json\",\"volume\":\"high\"}")
    time.sleep(3)

"""
Main
"""
if __name__ == "__main__":
    import sys, getopt, os, thread
    self = sys.modules['__main__']
    thread.start_new_thread( healthcheck(), ("HealthCheck_Thread-1", 3) )
    thread.start_new_thread( logger(), ("Logger_Thread-1", 3) )
