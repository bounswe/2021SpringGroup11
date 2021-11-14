import produce from 'immer';

import {
  CHECKAUTH,
  CHECKAUTH_FAILURE,
  CHECKAUTH_SUCCESS,
  DEFAULT_ACTION,
  FORGOT_PASSWORD,
  FORGOT_PASSWORD_SUCCESS,
  FORGOT_PASSWORD_FAILURE,
  LOGIN,
  LOGIN_FAILURE,
  LOGIN_SUCCESS,
  LOGOUT,
  LOGOUT_FAILURE,
  LOGOUT_SUCCESS,
} from './constants';

export const initialState = {
  redirectFrom: null,
  loading: false,
  username: '',
  password: '',
  remember: true,
  loginErrorMessage: '',
  authInfo: JSON.parse(sessionStorage.getItem('authInfo')),
  mail: '',
  mailSentError: '',
};

const loginReducer = (state = initialState, action) =>
  produce(state, (draft) => {
    switch (action.type) {
      case DEFAULT_ACTION:
        break;
      case CHECKAUTH:
        draft.loading = true;
        draft.redirectFrom = action.redirectFrom;
        break;
      case CHECKAUTH_SUCCESS:
        draft.loading = false;
        draft.authInfo = action.authInfo;
        break;
      case CHECKAUTH_FAILURE:
        draft.loading = false;
        draft.authInfo = {};
        break;
      case LOGIN:
        draft.loading = true;
        draft.username = action.userInfo.username;
        draft.password = action.userInfo.password;
        draft.remember = action.userInfo.remember;
        break;
      case LOGIN_SUCCESS:
        draft.loading = false;
        draft.authInfo = action.authInfo;
        break;
      case LOGIN_FAILURE:
        draft.loading = false;
        draft.authInfo = {};
        draft.loginErrorMessage = action.res.loginErrorMessage;
        break;
      case LOGOUT:
        draft.redirectFrom = null;
        draft.loading = true;
        draft.username = '';
        draft.password = '';
        draft.authInfo = {};
        break;
      case LOGOUT_SUCCESS:
        draft.redirectFrom = null;
        draft.loading = false;
        draft.username = '';
        draft.password = '';
        draft.authInfo = {};
        break;
      case LOGOUT_FAILURE:
        draft.redirectFrom = null;
        draft.loading = false;
        break;
      case FORGOT_PASSWORD:
        draft.username = action.userInfo.username;
        draft.loading = true;
        break;
      case FORGOT_PASSWORD_SUCCESS:
        draft.loading = false;
        break;
      case FORGOT_PASSWORD_FAILURE:
        draft.mailSentError = action.error;
        draft.loading = false;
        break;
    }
  });

export default loginReducer;
