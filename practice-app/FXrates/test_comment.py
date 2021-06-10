from django.test import TestCase

# Create your tests here.


from FXrates.models import Comment

class PriceTestCase(TestCase):
    def avoid_duplicates(self):
        for p in Comment.objects.all():
            duplicates=Comment.objects.filter(pair=p.pair,user=p.user,message=p.message)
            self.assertEqual(len(duplicates),0)
            
    def valid_pair_names(self):
        valid_names=["EUR_USD","USD_JPY","GBP_USD","USD_TRY"]
        for p in Comment.objects.all():
            self.assertTrue(search(valid_names,p.pair)) 

