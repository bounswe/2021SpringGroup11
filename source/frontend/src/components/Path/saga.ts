import { put, call, select, takeLatest } from 'redux-saga/effects';
import { ENROLL_PATH, FOLLOW_PATH, GET_PATH } from './constants';
import makeSelectPath from './selectors';
import {
  GET_PATH_URL,
  ENROLL_PATH_URL,
  UNENROLL_PATH_URL,
  UNFOLLOW_PATH_URL,
  FOLLOW_PATH_URL,
} from '../../utils/endpoints';
import { get, post } from '../../utils/axios';
import {
  getPathSuccess,
  getPathFailure,
  // enrollPathSuccess,
  enrollPathFailure,
  getPath,
  followPathFailure,
} from './actions';

export interface sessionStorageUserData {
  username: string;
  token: string;
}

export function* getPathSaga() {
  // @ts-ignore
  const pathData = yield select(makeSelectPath());
  try {
    // @ts-ignore
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
  // @ts-ignore
  const pathData = yield select(makeSelectPath());
  const URL = pathData.isEnrolled ? UNENROLL_PATH_URL : ENROLL_PATH_URL;
  try {
    // @ts-ignore
    const response = yield call(post, URL, {
      path_id: pathData.pathId,
    });
    if (response.data) {
      yield put(getPath(pathData.pathId));
    } else {
      yield put(enrollPathFailure(response));
    }
  } catch (error) {
    yield put(enrollPathFailure(error));
  }
}

export function* followPathSaga() {
  // @ts-ignore
  const pathData = yield select(makeSelectPath());
  const URL = pathData.isFollowed ? UNFOLLOW_PATH_URL : FOLLOW_PATH_URL;
  try {
    // @ts-ignore
    const response = yield call(post, URL, {
      path_id: pathData.pathId,
    });
    if (response.data) {
      yield put(getPath(pathData.pathId));
    } else {
      yield put(followPathFailure(response));
    }
  } catch (error) {
    yield put(followPathFailure(error));
  }
}

export default function* pathSaga() {
  yield takeLatest(GET_PATH, getPathSaga);
  yield takeLatest(ENROLL_PATH, enrollPathSaga);
  yield takeLatest(FOLLOW_PATH, followPathSaga);
}
