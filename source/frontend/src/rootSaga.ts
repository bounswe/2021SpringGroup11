import { all, fork } from 'redux-saga/effects';
import loginSaga from './components/Login/saga';
import signupSaga from './components/SignUp/saga';

export function* rootSaga() {
  yield all([fork(loginSaga),fork(signupSaga) ]);
}
