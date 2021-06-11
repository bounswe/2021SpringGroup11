# Generated by Django 2.2.5 on 2021-06-10 16:37

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('symbol', models.CharField(max_length=50)),
                ('user', models.CharField(max_length=100)),
                ('comment', models.CharField(max_length=1000)),
            ],
            options={
                'ordering': ['created'],
            },
        ),
        migrations.CreateModel(
            name='StockCandle',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('symbol', models.CharField(blank=True, default='', max_length=50)),
                ('resolution', models.CharField(default=1, max_length=10)),
                ('close', models.FloatField(default=0.0)),
                ('high', models.FloatField(default=0.0)),
                ('low', models.FloatField(default=0.0)),
                ('open', models.FloatField(default=0.0)),
                ('time', models.IntegerField(default=0)),
                ('volume', models.IntegerField(default=0.0)),
            ],
            options={
                'ordering': ['time'],
            },
        ),
        migrations.CreateModel(
            name='StockQuote',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('symbol', models.CharField(blank=True, default='', max_length=50, unique=True)),
                ('current', models.FloatField(default=0.0)),
                ('high', models.FloatField(default=0.0)),
                ('low', models.FloatField(default=0.0)),
            ],
            options={
                'ordering': ['created'],
            },
        ),
    ]
