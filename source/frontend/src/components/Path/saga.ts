import { put, call, select, takeLatest } from 'redux-saga/effects';
import { ENROLL_PATH, GET_PATH } from './constants';
import makeSelectPath from './selectors';
import { GET_PATH_URL, ENROLL_PATH_URL } from '../../utils/endpoints';
import { get, post } from '../../utils/axios';
import { getPathSuccess, getPathFailure, enrollPathSuccess, enrollPathFailure } from './actions';

export interface sessionStorageUserData {
  username: string;
  token: string;
}
export function* getPathSaga() {
  const pathData = yield select(makeSelectPath());
  try {
    const response = yield call(get, `${GET_PATH_URL}${pathData.pathId}/`);
    if (response.data) {
      yield put(getPathSuccess(response.data));
    } else {
      yield put(getPathFailure(response));
    }
  } catch (error) {
    yield put(getPathFailure(error));
  }
}

export function* enrollPathSaga() {
  const pathData = yield select(makeSelectPath());

  try {
    const response = yield call(post, ENROLL_PATH_URL, {
      path_id: pathData.pathId,
    });
    if (response.data) {
      yield put(enrollPathSuccess(response.data));
    } else {
      yield put(enrollPathFailure(response));
    }
  } catch (error) {
    yield put(enrollPathFailure(error));
  }
}

export default function* pathSaga() {
  yield takeLatest(GET_PATH, getPathSaga);
  yield takeLatest(ENROLL_PATH, enrollPathSaga);
}
