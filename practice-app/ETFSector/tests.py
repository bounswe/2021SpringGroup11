from http import client

from django.http import HttpResponse
from django.test import TestCase
from django.urls import reverse


class ETFSectorTest(TestCase):

    def setUp(self):
        pass

    def test_default_connection(self):
        response: HttpResponse = client.get(reverse('ETFSector'))
        content = response.content.decode()
        self.assertGreaterEqual(len(content), 5)