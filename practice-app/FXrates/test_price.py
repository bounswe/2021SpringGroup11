from django.test import TestCase

# Create your tests here.


from FXrates.models import Price

class PriceTestCase(TestCase):
    def avoid_duplicates(self):
        for p in Price.objects.all():
            duplicates=Price.objects.filter(pair=p.pair,data_time=p.data_time,frame=p.frame)
            self.assertEqual(len(duplicates),0)
            
    def time_alignment(self):
        for p in Price.objects.all():
            self.assertEqual(p.data_time % (p.frame*60), 0) # assert the timestamp is aligned for timeframe

    def acquire_time_after_data_time(self):
        for p in Price.objects.all():
            self.assertTrue(p.data_time <= p.acq_time)

    def valid_pair_names(self):
        valid_names=["EUR_USD","USD_JPY","GBP_USD","USD_TRY"]
        for p in Price.objects.all():
            self.assertTrue(search(valid_names,p.pair)) 

