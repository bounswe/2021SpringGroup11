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
    firstname: signupData.name,
    lastname: signupData.surname,
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
    const singupError = 'This username or e-mail is already exists. Please choose another one.'
    yield put(signupFailure({ signupErrorMessage: singupError }));
  }
}
export default function* signupSaga() {
  yield takeLatest(SIGNUP, doSignUp);
}
