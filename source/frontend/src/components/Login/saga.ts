import { put, call, select, takeLatest } from 'redux-saga/effects';
import { CHECKAUTH, LOGIN, LOGOUT, FORGOT_PASSWORD } from './constants';
import push from 'react-router-dom';
import makeSelectLogin from './selectors';
import { LOGIN_URL } from '../../utils/endpoints';
import { post } from '../../utils/axios';
import {
  checkAuthFailure,
  checkAuthSuccess,
  loginFailure,
  loginSuccess,
  logoutFailure,
  logoutSuccess,
} from './actions';
import auth from '../../utils/auth';

export function* doLogin() {
  const loginData = yield select(makeSelectLogin());
  const userData = {
    username: loginData.username,
    password: loginData.password,
  };
  console.log('HERE I AM');
  try {
    // @ts-ignore
    const response = yield call(post, LOGIN_URL, userData);
    if (response.isSuccess) {
      const user = response.data;
      yield put(loginSuccess(user));
      auth.setAuthInfoToSession(user);
      if (loginData.remember) {
        auth.setAuthInfoToLocalStorage(user);
      }
      loginData?.redirectFrom ? yield put(push(loginData.redirectFrom)) : yield put(push('/home'));
    } else {
      yield put(loginFailure('LOGIN ERROR MESSAGE WILL BE WRITTEN HERE'));
    }
  } catch (error) {
    yield put(loginFailure({ loginErrorMessage: 'LOGIN ERROR MESSAGE WILL BE WRITTEN HERE' }));
  }
}

export function* checkAuth() {
  const loginData = yield select(makeSelectLogin());

  try {
    const user = auth.getAuthInfoFromSession() || auth.getAuthInfoFromLocalStorage();
    if (user) {
      yield put(checkAuthSuccess(user));
      if (loginData.redirectFrom) {
        yield put(push(loginData.redirectFrom));
      } else {
        yield put(push('/'));
      }
    } else {
      yield put(checkAuthFailure());
    }
  } catch (err) {
    yield put(checkAuthFailure());
  }
}

export function* doLogout() {
  try {
    yield put(logoutSuccess());
    auth.clearSession();
    auth.clearLocalStorage();
  } catch (error) {
    yield put(logoutFailure());
  }
}

export function* forgotPasswordSaga() {}
export default function* loginSaga() {
  yield takeLatest(CHECKAUTH, checkAuth);
  yield takeLatest(LOGOUT, doLogout);
  yield takeLatest(LOGIN, doLogin);
  yield takeLatest(FORGOT_PASSWORD, doLogin);
}
