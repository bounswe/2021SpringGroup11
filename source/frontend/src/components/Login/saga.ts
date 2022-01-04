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
export interface sessionStorageUserData {
  username: string;
  token: string;
}

export function* doLoginSaga() {
  // @ts-ignore
  const loginData = yield select(makeSelectLogin());
  const userData = {
    username: loginData.username,
    password: loginData.password,
  };
  try {
    // @ts-ignore
    const response = yield call(post, LOGIN_URL, userData);
    if (response.data) {
      const user = {
        username: userData.username,
        token: response.data,
      };
      yield put(loginSuccess(user));

      auth.setAuthInfoToSession(user);
      if (loginData.remember) {
        auth.setAuthInfoToLocalStorage(user);
      }
      loginData?.redirectFrom
        ? // @ts-ignore
          yield put(history.push(loginData.redirectFrom))
        : // @ts-ignore
          yield put(history.push('/home'));
    } else {
      yield put(loginFailure(response));
    }
  } catch (error: any) {
    console.log(error.request);
    const usernameError = 'Username is invalid';
    const passwordError = 'Password is invalid';
    switch (error.request.status) {
      case 400:
        yield put(loginFailure({ usernameError }));
        break;
      case 401:
        yield put(loginFailure({ passwordError }));
        break;
      case 500:
        yield put(loginFailure({ usernameError: 'Try again later.' }));
        break;
      default:
    }
  }
}

export function* checkAuth() {
  // @ts-ignore
  const loginData = yield select(makeSelectLogin());

  try {
    const user = auth.getAuthInfoFromSession() || auth.getAuthInfoFromLocalStorage();
    if (user) {
      yield put(checkAuthSuccess(user));
      if (loginData.redirectFrom) {
        // @ts-ignore
        yield put(history.push(loginData.redirectFrom));
      } else {
        // @ts-ignore
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
  // @ts-ignore
  const selectedData = yield select(makeSelectLogin());
  const userData = {
    username: selectedData.username,
  };
  console.log(userData);
  try {
    // @ts-ignore
    const response = yield call(post, FORGOT_PASSWORD_URL, userData);
    console.log(response);
    if (response) {
      yield put(forgotPasswordSuccess(response));
    } else {
      yield put(loginFailure(response));
    }
  } catch (error) {
    console.log(error);
    yield put(loginFailure({ loginErrorMessage: error }));
  }
}

export default function* loginSaga() {
  yield takeLatest(LOGIN, doLoginSaga);
  yield takeLatest(CHECKAUTH, checkAuth);
  yield takeLatest(LOGOUT, doLogout);
  yield takeLatest(FORGOT_PASSWORD, forgotPasswordSaga);
}
