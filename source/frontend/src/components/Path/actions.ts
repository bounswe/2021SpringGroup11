import {
  DEFAULT_ACTION,
  ENROLL_PATH,
  ENROLL_PATH_FAILURE,
  ENROLL_PATH_SUCCESS,
  FOLLOW_PATH,
  FOLLOW_PATH_FAILURE,
  FOLLOW_PATH_SUCCESS,
  GET_PATH,
  GET_PATH_FAILURE,
  GET_PATH_SUCCESS,
} from './constants';

export function defaultAction() {
  return {
    type: DEFAULT_ACTION,
  };
}

export function getPath(pathId: any) {
  return {
    type: GET_PATH,
    pathId,
  };
}

export function getPathSuccess(path: any) {
  return {
    type: GET_PATH_SUCCESS,
    path,
  };
}

export function getPathFailure(error: any) {
  return {
    type: GET_PATH_FAILURE,
    error,
  };
}

export function enrollPath(pathId: any, isEnrolled: any) {
  return {
    type: ENROLL_PATH,
    pathId,
    isEnrolled,
  };
}

export function enrollPathSuccess(response: any) {
  return {
    type: ENROLL_PATH_SUCCESS,
    response,
  };
}

export function enrollPathFailure(error: any) {
  return {
    type: ENROLL_PATH_FAILURE,
    error,
  };
}

export function followPath(pathId: any, isFollowed: any) {
  return {
    type: FOLLOW_PATH,
    pathId,
    isFollowed,
  };
}

export function followPathSuccess(response: any) {
  return {
    type: FOLLOW_PATH_SUCCESS,
    response,
  };
}

export function followPathFailure(error: any) {
  return {
    type: FOLLOW_PATH_FAILURE,
    error,
  };
}
