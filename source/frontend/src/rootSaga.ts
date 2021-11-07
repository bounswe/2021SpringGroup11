import { all, fork } from 'redux-saga/effects';
import loginSaga from './components/Login/saga';

export function* rootSaga() {
  yield all([fork(loginSaga)]);
}
