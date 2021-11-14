import { put, call, select, takeLatest } from 'redux-saga/effects';
import { CHECKAUTH, LOGIN, LOGOUT, FORGOT_PASSWORD } from './constants';
import history from '../../utils/history';
import makeSelectLogin from './selectors';
import { LOGIN_URL, FORGOT_PASSWORD_URL } from '../../utils/endpoints';
import { post } from '../../utils/axios';
import {
  checkAuthFailure,
  checkAuthSuccess,
  forgotPasswordSuccess,
  loginFailure,
  loginSuccess,
  logoutFailure,
  logoutSuccess,
} from './actions';
import auth from '../../utils/auth';

export function* doLoginSaga() {
  const loginData = yield select(makeSelectLogin());
  const userData = {
    username: loginData.username,
    password: loginData.password,
  };
  try {
    // @ts-ignore
    const response = yield call(post, LOGIN_URL, userData);
    console.log(response);
    if (response.token) {
      const user = {
        username: userData.username,
        token: response.token,
      };
      yield put(loginSuccess(user));
      auth.setAuthInfoToSession(user);
      if (loginData.remember) {
        auth.setAuthInfoToLocalStorage(user);
      }
      loginData?.redirectFrom
        ? yield put(history.push(loginData.redirectFrom))
        : yield put(history.push('/home'));
    } else {
      yield put(loginFailure(response));
    }
  } catch (error) {
    yield put(loginFailure({ loginErrorMessage: error.detail }));
  }
}

export function* checkAuth() {
  const loginData = yield select(makeSelectLogin());

  try {
    const user = auth.getAuthInfoFromSession() || auth.getAuthInfoFromLocalStorage();
    if (user) {
      yield put(checkAuthSuccess(user));
      if (loginData.redirectFrom) {
        yield put(history.push(loginData.redirectFrom));
      } else {
        yield put(history.push('/'));
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

export function* forgotPasswordSaga() {
  const selectedData = yield select(makeSelectLogin());
  const userData = {
    username: selectedData.username,
  };
  try {
    // @ts-ignore
    const response = yield call(post, FORGOT_PASSWORD_URL, userData);
    if (response.code == 200) {
      yield put(forgotPasswordSuccess(response));
    } else {
      yield put(loginFailure(response));
    }
  } catch (error) {
    yield put(loginFailure({ loginErrorMessage: error.detail }));
  }
}

export default function* loginSaga() {
  yield takeLatest(LOGIN, doLoginSaga);
  yield takeLatest(CHECKAUTH, checkAuth);
  yield takeLatest(LOGOUT, doLogout);
  yield takeLatest(FORGOT_PASSWORD, forgotPasswordSaga);
}
