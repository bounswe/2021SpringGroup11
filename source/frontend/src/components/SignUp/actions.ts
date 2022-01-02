import { DEFAULT_ACTION, SIGNUP, SIGNUP_FAILURE, SIGNUP_SUCCESS } from './constants';

export function defaultAction() {
  return {
    type: DEFAULT_ACTION,
  };
}

export function doSignup(userInfo: any) {
  return {
    type: SIGNUP,
    userInfo,
  };
}

export function signupSuccess() {
  return {
    type: SIGNUP_SUCCESS,
  };
}

export function signupFailure(res: any) {
  return {
    type: SIGNUP_FAILURE,
    res,
  };
}
