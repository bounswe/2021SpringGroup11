import { put, call, select, takeLatest } from 'redux-saga/effects';
import { SIGNUP } from './constants';
import makeSelectSignUp from './selectors';
import { SIGNUP_URL } from '../../utils/endpoints';
import { post } from '../../utils/axios';
import { signupFailure, signupSuccess } from './actions';

export function* doSignUp() {
  // @ts-ignore
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
    if (response) {
      yield put(signupSuccess());
    } else {
      yield put(signupFailure({ error: true }));
    }
  } catch (error) {
    const signupError = 'This username or e-mail is already exists. Please choose another one.';
    yield put(signupFailure({ error: true, signupErrorMessage: signupError }));
  }
}
export default function* signupSaga() {
  yield takeLatest(SIGNUP, doSignUp);
}
