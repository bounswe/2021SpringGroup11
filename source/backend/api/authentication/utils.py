from os import link
import jwt
import time
import requests
import base64
from rest_framework.permissions import BasePermission
from rest_framework.exceptions import NotAuthenticated, PermissionDenied, APIException
from django.conf import settings
from googleapiclient.discovery import build
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from email.mime.text import MIMEText

SCOPES = ['https://www.googleapis.com/auth/gmail.send',
          'https://www.googleapis.com/auth/gmail.readonly']
TOKEN_URI = 'https://oauth2.googleapis.com/token'


class IsAuthenticated(BasePermission):
    """
        Allows access only to authenticated users.
        Adds params&jwt data into request.data 
    """

    def has_permission(self, request, view):
        if request.GET:
            for key in request.query_params.keys():
                value = request.query_params.getlist(key)
                
                if len(value) == 1:
                    request.data.update({key.replace('[]', ''): value[0]})
                elif len(value)== 0:
                    request.data.update({key.replace('[]', ''): []})
                else:
                    request.data.update({key.replace('[]', ''): value})
        
        token_info = verify_jwt_token(request.META.get('HTTP_AUTHORIZATION'))
        if token_info:
            request.data.update({'email': token_info['email']})
            request.data.update({'username': token_info['username']})
            # request.data.update({'isAdmin': token_info['isAdmin']})
            return True
        else:
            raise NotAuthenticated('No credentials provided for request')

class IsAdmin(BasePermission):
    """
        Allows access only to admin users.
        Adds params&jwt data into request.data 
    """

    def has_permission(self, request, view):
        token_info = verify_jwt_token(request.META.get('HTTP_AUTHORIZATION'))
        if token_info:
            request.data.update({'isAdmin': token_info['isAdmin']})
            
            return token_info['isAdmin']
        else:
            raise PermissionDenied('This user is not admin')


def verify_jwt_token(token):
    """
        verifies token and returns decoded jwt
        :token: jwt token
        return decoded token
    """
    try:
        token = token.replace('Bearer ', '')
        data = decode_jwt(token)

        if data['exp'] < time.time():
            raise PermissionDenied('Token is not valid')
        
        return data
    except:
        raise PermissionDenied('Token is not valid')

def create_jwt(data: dict):
    """
        Returns encoded jwt
        :data: dict
    """
    return jwt.encode(data, settings.SECRET_KEY, algorithm='HS256')

def decode_jwt(encoded_jwt):
    """
        Returns decoded jwt
        :encoded_jwt: jwt
    """
    if isinstance(encoded_jwt, str):
        encoded_jwt = encoded_jwt.encode()
    
    return jwt.decode(encoded_jwt, settings.SECRET_KEY, algorithms=['HS256'])

def send_email_via_sendinblue(subject='Hey', from_email='erenaltunoglu@gmail.com', from_name='Renaissance', to_email='', to_name=''):
    requests.post('https://api.sendinblue.com/v3/smtp/email',
        headers={'api-key': settings.SENDINBLUE_API_KEY},
        json={
            'sender': {
                'name': from_name,
                'email': from_email
            },
            'to': [
                {
                    'email': to_email,
                    'name': to_name
                }
            ],
            'subject': subject,
            'htmlContent':'<html><head></head><body><p>Hello,</p>This is my first transactional email sent from Sendinblue. Welcome.......</p></body></html>'
        }
    )


EMAIL_TEMPLATE = """
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head></head>
<body>
<br> Welcome to Renaissance, "{username}"  <a href="http://renaissance.com/" target="_blank">renaissance.com</a>
</body>
""" 

EMAIL_TEMPLATE_FORGOT_PASSWORD = """
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head></head>
<body>
<br> "{username}" Change your password from this link, {link}
</body>
""" 

def get_service():
    """
        Returns service
    """
    creds = Credentials(token=settings.GMAIL_TOKEN, token_uri=TOKEN_URI, refresh_token=settings.GMAIL_REFRESH_TOKEN, client_id=settings.GMAIL_CLIENT_ID,
                        client_secret=settings.GMAIL_CLIENT_SECRET, scopes=SCOPES)
    if not creds.valid:
        if creds.expired:
            try:
                creds.refresh(Request())
            except:
                raise APIException('GMAIL APP CRASHED (CANNOT REFRESH)')
        # # Save the credentials for the next run
        # os.environ['GMAIL_TOKEN'] = creds.token
        # os.environ['GMAIL_REFRESH_TOKEN'] = creds.refresh_token

    try:
        return build('gmail', 'v1', credentials=creds)
    except:
        raise APIException('GMAIL APP CRASHED (SERVICE BUILD)')


def create_message(sender, to, subject, message_text):
    """
    Create a message for an email.
        :sender: Email address of the sender.
        :to: Email address of the receiver.
        :subject: The subject of the email message.
        :message_text: The text of the email message.

        returns an object containing a base64url encoded email object.
    """
    message = MIMEText(message_text, 'html')
    message['to'] = to
    message['from'] = sender
    message['subject'] = subject
    raw_message = base64.urlsafe_b64encode(message.as_bytes())
    
    return {'raw': raw_message.decode("utf-8")}


def send_email(receiver, username, forgot_password_link: str=''):
    """
        Sends email
        :receiver: email address of receiver
        :username: username of 
    """
    if forgot_password_link:
        try:
            service = get_service()
            user_id = 'me'
            subject = 'Renew your Password'
            message_text = EMAIL_TEMPLATE_FORGOT_PASSWORD.format(username=username, link=forgot_password_link)
            print(receiver)
            print(username)
            print(forgot_password_link)
            message = create_message(settings.SENDER_EMAIL, receiver, subject, message_text)
            service.users().messages().send(userId=user_id, body=message).execute()
        
        except:
            print('Could not send email')
    else:
        try:
            service = get_service()
            user_id = 'me'
            subject = 'Hello from Renaissance'
            message_text = EMAIL_TEMPLATE.format(username=username)
            message = create_message(settings.SENDER_EMAIL, receiver, subject, message_text)
            service.users().messages().send(userId=user_id, body=message).execute()
        except:
            print('Could not send email')


def create_forgot_password_link(jwt) -> str:
    """
        Util function for creating forgot password link
        :username: username of user
    """
    # TODO change url
    redirect_url = 'frontend'
    
    return redirect_url + f'?jwt={jwt}'
