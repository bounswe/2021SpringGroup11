import { put, select, call, takeLatest } from 'redux-saga/effects';
import { GET_ACTIVITIES } from './constants';
// @ts-ignore
import { post } from '../../utils/axios';
import { GET_ACTIVITIES_URL } from '../../utils/endpoints';
import makeSelectActivity from './selectors';
import { getActivitiesSuccess } from './actions';

export function* getActivitiesSaga() {
  // @ts-ignore
  const activityData = yield select(makeSelectActivity());

  try {
    // @ts-ignore
    const response = yield call(post, GET_ACTIVITIES_URL, { username: activityData.username });
    if (response.data) {
      yield put(getActivitiesSuccess(response.data));
    }
  } catch (error: any) {
    console.log(error.request);
  }
}

export default function* loginSaga() {
  yield takeLatest(GET_ACTIVITIES, getActivitiesSaga);
}
