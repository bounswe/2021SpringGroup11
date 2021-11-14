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

export function doLogin(userInfo) {
  return {
    type: LOGIN,
    userInfo,
  };
}

export function loginSuccess(authInfo) {
  return {
    type: LOGIN_SUCCESS,
    authInfo,
  };
}

export function loginFailure(res) {
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

export function checkAuth(redirectFrom) {
  return {
    type: CHECKAUTH,
    redirectFrom,
  };
}

export function checkAuthSuccess(authInfo) {
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

export function forgotPassword(userInfo) {
  return {
    type: FORGOT_PASSWORD,
    userInfo,
  };
}

export function forgotPasswordSuccess(response) {
  return {
    type: FORGOT_PASSWORD_SUCCESS,
    response,
  };
}

export function forgotPasswordFailure(response) {
  return {
    type: FORGOT_PASSWORD_FAILURE,
    response,
  };
}
