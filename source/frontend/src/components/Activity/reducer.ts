import produce from 'immer';

import {
  DEFAULT_ACTION,
  GET_ACTIVITIES,
  GET_ACTIVITIES_FAILURE,
  GET_ACTIVITIES_SUCCESS,
} from './constants';

export const initialState = {
  loading: true,
  activities: [],
  activityError: undefined,
  username: '',
};

const activityReducer = (state = initialState, action: any) =>
  produce(state, (draft) => {
    switch (action.type) {
      case DEFAULT_ACTION:
        break;
      case GET_ACTIVITIES:
        draft.loading = true;
        draft.username = action.username;
        break;
      case GET_ACTIVITIES_SUCCESS:
        draft.activities = action.activities;
        draft.loading = false;
        draft.activityError = undefined;
        break;
      case GET_ACTIVITIES_FAILURE:
        draft.loading = false;
        draft.activityError = action.res;
        draft.activities = [];
        break;
      default:
        break;
    }
  });

export default activityReducer;
