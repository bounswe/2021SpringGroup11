import {
  DEFAULT_ACTION,
  ENROLL_PATH,
  ENROLL_PATH_FAILURE,
  ENROLL_PATH_SUCCESS,
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

export function enrollPath(pathId: any) {
  return {
    type: ENROLL_PATH,
    pathId,
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
