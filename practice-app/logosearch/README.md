
# Logo API Description
This is a Logo Search Page, where you can customize with adding new logos for specific keys or urls. In the main page ("/logosearch") you can search for any logo, if you cannot find or if you want to change, then you can suggest a new logo for any URL you want. In suggestion page ("/logosearch/suggest") you should provide link for both site and image. Don't forget that site only accepts jpg,png and jpeg format.
## My API functionality

### GET functionality
It is used while fetching the logo from public api or db. It may return 404 (can't find logo), 400 (missing parameter or too long parameter), 200(OK).
### POST functionality
It is used while adding the logo to db. It may return 400 (missing parameter, too long parameter or not valid image url), 200 (OK). POST functionality use URL encoded so, you should pay attention while using postman.

## UI 
There are two pages one for search logo and other one for add logo. In UI I've tried to minimize the user error such as no empty input or restricting max length of site url to 100 etc.

## My Functions
There are 4 functions in my views file 2 for api responses, 2 for ui responses. 

### index(request)
This function get's the Site URL  from user, then search the database first, if cannot find any related information in db, it will search public api. If none of them return a successful response. This function returns 404. 
![image](https://user-images.githubusercontent.com/56564666/121531138-d2316880-ca06-11eb-986f-192dc6ee6fd9.png)

![image](https://user-images.githubusercontent.com/56564666/121531241-e83f2900-ca06-11eb-87d4-8b23614f2bc5.png)
### apindex(request)
As you can tell from its name, this function is the api for search function. It will return a json response based on status code, if status code is 400 or 404 it will return an explanation, otherwise it returns a json with the related site url and link to the logo. 
![image](https://user-images.githubusercontent.com/56564666/121531455-158bd700-ca07-11eb-9556-3394c1955ed6.png)
![image](https://user-images.githubusercontent.com/56564666/121531517-24728980-ca07-11eb-91d6-52227ffeca03.png)
### routeNew(request)
This is the part for adding a new logo to our site. As stated in description, the image url should be in jpg,jpeg and png format.
![image](https://user-images.githubusercontent.com/56564666/121531788-6c91ac00-ca07-11eb-9dfc-26b97d5305fe.png)

![image](https://user-images.githubusercontent.com/56564666/121531872-7c10f500-ca07-11eb-9144-6043a814dba1.png)
### apiRouteNew(request)
This is the api for suggestion page. Examples below.
![image](https://user-images.githubusercontent.com/56564666/121531987-9a76f080-ca07-11eb-9b0d-3b6eb7e38b70.png)

![image](https://user-images.githubusercontent.com/56564666/121532053-aa8ed000-ca07-11eb-8df2-41a6686cbe4f.png)

![image](https://user-images.githubusercontent.com/56564666/121532213-ceeaac80-ca07-11eb-9cce-2ec0931c656b.png)
