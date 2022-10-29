import http
from locust import FastHttpUser, task

class WebsiteUser(FastHttpUser):
    http = "http://127.0.0.1:8089"

    @task
    def index(self):
        self.client.get("/")