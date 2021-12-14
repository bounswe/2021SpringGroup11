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

export function getPath(pathId) {
  return {
    type: GET_PATH,
    pathId,
  };
}

export function getPathSuccess(path) {
  return {
    type: GET_PATH_SUCCESS,
    path,
  };
}

export function getPathFailure(error) {
  return {
    type: GET_PATH_FAILURE,
    error,
  };
}

export function enrollPath(pathId) {
  return {
    type: ENROLL_PATH,
    pathId,
  };
}

export function enrollPathSuccess(response) {
  return {
    type: ENROLL_PATH_SUCCESS,
    response,
  };
}

export function enrollPathFailure(error) {
  return {
    type: ENROLL_PATH_FAILURE,
    error,
  };
}
