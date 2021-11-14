import { put, call, select, takeLatest } from 'redux-saga/effects';
import { SIGNUP } from './constants';
import history from '../../utils/history';
import makeSelectSignUp from './selectors';
import { SIGNUP_URL } from '../../utils/endpoints';
import { post } from '../../utils/axios';
import { signupFailure, signupSuccess } from './actions';

export function* doSignUp() {
  const signupData = yield select(makeSelectSignUp());
  const userData = {
    name: signupData.name,
    surname: signupData.surname,
    username: signupData.username,
    email: signupData.email,
    password: signupData.password,
  };
  try {
    // @ts-ignore
    const response = yield call(post, SIGNUP_URL, userData);
    if (response.isSuccess) {
      yield put(signupSuccess());
      put(history.push('/login'));
    } else {
      yield put(signupFailure('SIGN UP ERROR MESSAGE WILL BE WRITTEN HERE'));
    }
  } catch (error) {
    yield put(signupFailure({ signupErrorMessage: 'SIGN UP ERROR MESSAGE WILL BE WRITTEN HERE' }));
  }
}
export default function* signupSaga() {
  yield takeLatest(SIGNUP, doSignUp);
}
