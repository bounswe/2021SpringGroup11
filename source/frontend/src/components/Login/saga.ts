import { select, takeLatest } from 'redux-saga/effects';
import { CHECKAUTH, LOGIN, LOGOUT } from './constants';
import makeSelectLogin from './selectors';

export function* doLogin() {
  const loginData = yield select(makeSelectLogin());
  const userData = {
    userName: loginData.userName,
    password: loginData.password,
  };
  // loginPOST
  try {
    // SUCCESS
  } catch (error) {
    // FAIL
  }
}

export function* checkAuth() {
  const loginData = yield select(makeSelectLogin());

  // AUTH CHECK FROM SESSION OR LOCAL STORAGE
  try {
    //SUCCESS
  } catch (err) {
    // FAIL
  }
}

export function* doLogout() {
  //LOGOUT
}

export default function* loginSaga() {
  yield takeLatest(CHECKAUTH, checkAuth);
  yield takeLatest(LOGOUT, doLogout);
  yield takeLatest(LOGIN, doLogin);
}
