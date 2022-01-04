import produce from 'immer';

import {
  DEFAULT_ACTION,
  GET_PATH,
  GET_PATH_FAILURE,
  GET_PATH_SUCCESS,
  ENROLL_PATH,
  ENROLL_PATH_SUCCESS,
  ENROLL_PATH_FAILURE,
  FOLLOW_PATH,
  FOLLOW_PATH_SUCCESS,
  FOLLOW_PATH_FAILURE,
} from './constants';

export const initialState = {
  loading: true,
  pathId: '',
  path: undefined,
  error: undefined,
  enrollRes: undefined,
  enrollError: undefined,
  isEnrolled: undefined,
  followRes: undefined,
  followError: undefined,
  isFollowed: undefined,
};

const pathReducer = (state = initialState, action: any) =>
  produce(state, (draft) => {
    switch (action.type) {
      case DEFAULT_ACTION:
        break;
      case GET_PATH:
        draft.loading = true;
        draft.pathId = action.pathId;
        draft.path = undefined;
        draft.error = undefined;
        break;
      case GET_PATH_SUCCESS:
        draft.loading = false;
        draft.path = action.path;
        draft.error = undefined;
        break;
      case GET_PATH_FAILURE:
        draft.loading = false;
        draft.error = action.error;
        break;
      case ENROLL_PATH:
        draft.loading = true;
        draft.pathId = action.pathId;
        draft.isEnrolled = action.isEnrolled;
        draft.enrollError = undefined;
        break;
      case ENROLL_PATH_SUCCESS:
        draft.loading = false;
        draft.enrollRes = action.response;
        draft.enrollError = undefined;
        break;
      case ENROLL_PATH_FAILURE:
        draft.loading = false;
        draft.enrollError = action.error;
        break;
      case FOLLOW_PATH:
        draft.loading = true;
        draft.pathId = action.pathId;
        draft.isFollowed = action.isFollowed;
        draft.followError = undefined;
        break;
      case FOLLOW_PATH_SUCCESS:
        draft.loading = false;
        draft.followRes = action.response;
        draft.followError = undefined;
        break;
      case FOLLOW_PATH_FAILURE:
        draft.loading = false;
        draft.followError = action.error;
        break;
      default:
        break;
    }
  });

export default pathReducer;
