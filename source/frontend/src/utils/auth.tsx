import store from '../store';
import { loginSuccess } from '../components/Login/actions';

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

  setAuthInfoToSession(authInfo) {
    sessionStorage.setItem('authInfo', JSON.stringify(authInfo));
  }

  getAuthInfoFromSession() {
    const authInfo = sessionStorage.getItem('authInfo');
    return JSON.parse(authInfo);
  }

  setAuthInfoToLocalStorage(authInfo) {
    localStorage.setItem('authInfo', JSON.stringify(authInfo));
  }

  getAuthInfoFromLocalStorage() {
    const authInfo = localStorage.getItem('authInfo');
    return JSON.parse(authInfo);
  }
}

export default new Auth();
