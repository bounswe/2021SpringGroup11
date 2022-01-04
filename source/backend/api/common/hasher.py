"""
    http://www.matrix.umcs.lublin.pl/DOC/python-django-doc/html/topics/auth/passwords.html
"""
from django.contrib.auth.hashers import (
    PBKDF2PasswordHasher, SHA1PasswordHasher,
)


class PBKDF2WrappedSHA1PasswordHasher(PBKDF2PasswordHasher):
    algorithm = 'pbkdf2_wrapped_sha1'

    def encode_sha1_hash(self, sha1_hash, salt, iterations=None):
        return super(PBKDF2WrappedSHA1PasswordHasher, self).encode(sha1_hash, salt, iterations)

    def encode(self, password, salt, iterations=10):
        _, _, sha1_hash = SHA1PasswordHasher().encode(password, str(salt)).split('$', 2)
        return self.encode_sha1_hash(sha1_hash, str(salt), iterations)