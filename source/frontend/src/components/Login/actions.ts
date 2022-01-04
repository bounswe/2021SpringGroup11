import {
  CHECKAUTH,
  CHECKAUTH_FAILURE,
  CHECKAUTH_SUCCESS,
  DEFAULT_ACTION,
  LOGIN,
  LOGIN_FAILURE,
  LOGIN_SUCCESS,
  LOGOUT,
  LOGOUT_FAILURE,
  LOGOUT_SUCCESS,
  FORGOT_PASSWORD,
  FORGOT_PASSWORD_SUCCESS,
  FORGOT_PASSWORD_FAILURE,
} from './constants';

export function defaultAction() {
  return {
    type: DEFAULT_ACTION,
  };
}

export function doLogin(userInfo: any) {
  return {
    type: LOGIN,
    userInfo,
  };
}

export function loginSuccess(authInfo: any) {
  return {
    type: LOGIN_SUCCESS,
    authInfo,
  };
}

export function loginFailure(res: any) {
  return {
    type: LOGIN_FAILURE,
    res,
  };
}

export function logout() {
  return {
    type: LOGOUT,
  };
}

export function logoutSuccess() {
  return {
    type: LOGOUT_SUCCESS,
  };
}

export function logoutFailure() {
  return {
    type: LOGOUT_FAILURE,
  };
}

export function checkAuth(redirectFrom: any) {
  return {
    type: CHECKAUTH,
    redirectFrom,
  };
}

export function checkAuthSuccess(authInfo: any) {
  return {
    type: CHECKAUTH_SUCCESS,
    authInfo,
  };
}

export function checkAuthFailure() {
  return {
    type: CHECKAUTH_FAILURE,
  };
}

export function forgotPassword(userInfo: any) {
  return {
    type: FORGOT_PASSWORD,
    userInfo,
  };
}

export function forgotPasswordSuccess(response: any) {
  return {
    type: FORGOT_PASSWORD_SUCCESS,
    response,
  };
}

export function forgotPasswordFailure(response: any) {
  return {
    type: FORGOT_PASSWORD_FAILURE,
    response,
  };
}
