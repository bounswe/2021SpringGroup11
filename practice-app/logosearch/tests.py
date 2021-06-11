from django.test import TestCase
from rest_framework import status
from rest_framework.test import APITestCase, APIClient
from urllib.parse import urlencode  

class LogosTests(APITestCase):
##FOR POST
    # Tests adding too long site_url to db 
    def test_too_long_site_url(self):
        data={"Site":"hduyashdadhasdsklahdjkadhsajdhasdhaıuodqheıwueqıoeuqwıojhedıuohdjkl<dhajkdshndksanbdsdnbkjsadhsajkdhsajkdhasudjashdjashdjksadhjaskdhajkdhsdhsakjdhkjsalhdjalkshdsjkldhaslkjdhjkaldhjkasldhsaljkdhjdhuahduıahdjkasdhaıuhuıdhaqduıqhdıuqwhduıqdhıuwqdhuıqdhıuqdhqwuıdhqwuıdhqwuıdhqwuıdhqwuıdqhwudıqwhduıqwhdıquwdhquıwdhqwıudhqwuıdhqwuıdhqwuıdhqwuıdhwquıdhqwuıdhqwuıdhqwuıdhqwuıdhqıwudhqwıudhqwuıdhqwuıdqwuh","Image":"https://upload.wikimedia.org/wikipedia/commons/f/f1/Logo_of_Show_TV.png"}
        client=APIClient()
        response = client.post("/logosearch/api/suggest/",urlencode(data),content_type='application/x-www-form-urlencoded')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data['exp'],'Site URL is too long.')
    # Tests if not image url is given
    def test_invalid_image_url(self):
        data={"Site":"showTV.com","Image":"www.bombabomba.com"}
        client=APIClient()
        response = client.post("/logosearch/api/suggest/",urlencode(data),content_type='application/x-www-form-urlencoded')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data['exp'],'Enter Valid Image URL')
    # Tests if any of the parameters not given
    def test_missing_site_url(self):
        data={"Site":"showTV.com"}
        client=APIClient()
        response = client.post("/logosearch/api/suggest/",urlencode(data),content_type='application/x-www-form-urlencoded')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data['exp'],'Missing Parameters')
    # Tests if a valid both valid input given
    def test_valid(self):
        data={"Site":"showTV.com","Image":"https://upload.wikimedia.org/wikipedia/commons/f/f1/Logo_of_Show_TV.png"}
        client=APIClient()
        response = client.post("/logosearch/api/suggest/",urlencode(data),content_type='application/x-www-form-urlencoded')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['exp'],'Logo added.')
        self.assertEqual(response.data['site'],'showTV.com')
        self.assertEqual(response.data['image'],'https://upload.wikimedia.org/wikipedia/commons/f/f1/Logo_of_Show_TV.png')

##FOR GET
    # Tests if the site url is not given
    def test_missing_param(self):
        client=APIClient()
        response=client.get("/logosearch/api/")
        self.assertEqual(response.status_code,status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data['exp'],'Please give a URL as parameter.')

    # Tests a site not in db or clearbit api
    def test_get_method(self):
        client=APIClient()
        data={"Site":"asdasdadl.com",}
        response=client.get("/logosearch/api/",data)
        self.assertEqual(response.status_code,status.HTTP_404_NOT_FOUND)
        self.assertEqual(response.data['exp'],'Cannot found the logo, please check the url or suggest a logo for the site.')

    # Tests if valid site url is given
    def test_valid_input(self):
        client=APIClient()
        data={"Site":"github.com",}
        response=client.get("/logosearch/api/",data)
        self.assertEqual(response.status_code,status.HTTP_200_OK)
        self.assertEqual(response.data['site'],'github.com')
        self.assertEqual(response.data['image'],'http://logo.clearbit.com/github.com')
