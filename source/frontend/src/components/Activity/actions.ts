import {
  DEFAULT_ACTION,
  GET_ACTIVITIES,
  GET_ACTIVITIES_FAILURE,
  GET_ACTIVITIES_SUCCESS,
} from './constants';

export function defaultAction() {
  return {
    type: DEFAULT_ACTION,
  };
}

export function getActivities(username: any) {
  return {
    type: GET_ACTIVITIES,
    username,
  };
}

export function getActivitiesSuccess(activities: any) {
  return {
    type: GET_ACTIVITIES_SUCCESS,
    activities,
  };
}

export function getActivitiesFailure(res: any) {
  return {
    type: GET_ACTIVITIES_FAILURE,
    res,
  };
}
