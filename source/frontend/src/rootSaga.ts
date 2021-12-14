import { all, fork } from 'redux-saga/effects';
import loginSaga from './components/Login/saga';
import signupSaga from './components/SignUp/saga';
import pathSaga from './components/Path/saga';

export function* rootSaga() {
  yield all([fork(loginSaga), fork(signupSaga), fork(pathSaga)]);
}
