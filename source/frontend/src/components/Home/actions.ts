import { DEFAULT_ACTION, GET_USER, GET_USER_SUCCESS, GET_USER_FAILURE } from './constants';

export function defaultAction() {
  return {
    type: DEFAULT_ACTION,
  };
}

export function getUser(userInfo) {
  return {
    type: GET_USER,
    userInfo,
  };
}

export function getUserSuccess() {
  return {
    type: GET_USER_SUCCESS,
  };
}

export function getUserFailure(res) {
  return {
    type: GET_USER_FAILURE,
    res,
  };
}
