import produce from 'immer';

import {
  DEFAULT_ACTION,
  SIGNUP,
  SIGNUP_FAILURE,
  SIGNUP_SUCCESS
} from './constants';

export const initialState = {
  loading: true,
  name: '',
  surname: '',
  username: '',
  email: '',
  password: '',
  signupErrorMessage: ''
};

const signupReducer = (state = initialState, action) =>
  produce(state, (draft) => {
    switch (action.type) {
      case DEFAULT_ACTION:
        break;
      case SIGNUP:
        draft.loading = true;
        draft.name = action.userInfo.name;
        draft.surname = action.userInfo.surname;
        draft.username = action.userInfo.username;
        draft.email = action.userInfo.email;
        draft.password = action.userInfo.password;
        break;
      case SIGNUP_SUCCESS:
        draft.loading = false;
        break;
      case SIGNUP_FAILURE:
        draft.loading = false;
        draft.signupErrorMessage = action.res.signupErrorMessage;
        break;
    }
  });

export default signupReducer;
