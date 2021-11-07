import produce from 'immer';
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
} from './constants';

export const initialState = {
  redirectFrom: null,
  loading: true,
  userName: '',
  password: '',
  remember: true,
  loginErrorMessage: '',
  authInfo: JSON.parse(sessionStorage.getItem('authInfo')),
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
        draft.userName = action.userInfo.userName;
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
        draft.userName = '';
        draft.password = '';
        draft.authInfo = {};
        break;
      case LOGOUT_SUCCESS:
        draft.redirectFrom = null;
        draft.loading = false;
        draft.userName = '';
        draft.password = '';
        draft.authInfo = {};
        break;
      case LOGOUT_FAILURE:
        draft.redirectFrom = null;
        draft.loading = false;
        break;
    }
  });

export default loginReducer;
