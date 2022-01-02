import store from '../store';
import { loginSuccess } from '../components/Login/actions';
import { sessionStorageUserData } from '../components/Login/saga';

class Auth {
  isAuthenticated() {
    const session = store.getState().login;
    const authInfo = this.getAuthInfoFromLocalStorage();
    if (session && session.authInfo && session.authInfo.token) {
      return true;
    }
    if (authInfo && authInfo?.accessToken) {
      store.dispatch(loginSuccess(authInfo));
      this.setAuthInfoToSession(authInfo);
      return true;
    }
    return false;
  }

  clearSession() {
    sessionStorage.clear();
  }

  clearLocalStorage() {
    localStorage.clear();
  }

  setAuthInfoToSession(authInfo: sessionStorageUserData) {
    sessionStorage.setItem('authInfo', JSON.stringify(authInfo));
  }

  getAuthInfoFromSession(): sessionStorageUserData | null {
    const authInfo = sessionStorage.getItem('authInfo');
    return JSON.parse(<string>authInfo);
  }

  setAuthInfoToLocalStorage(authInfo: any) {
    localStorage.setItem('authInfo', JSON.stringify(authInfo));
  }

  getAuthInfoFromLocalStorage() {
    const authInfo = localStorage.getItem('authInfo');
    return JSON.parse(<string>authInfo);
  }
}

export default new Auth();
