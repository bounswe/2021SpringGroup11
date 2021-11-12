import { combineReducers } from 'redux';

import loginReducer from './components/Login/reducer';
import signupReducer from './components/SignUp/reducer';

const rootReducer = combineReducers({
  login: loginReducer,
  signup: signupReducer
});

export type RootState = ReturnType<typeof rootReducer>;
export default rootReducer;
