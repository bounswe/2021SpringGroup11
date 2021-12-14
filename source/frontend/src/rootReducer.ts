import { combineReducers } from 'redux';

import loginReducer from './components/Login/reducer';
import signupReducer from './components/SignUp/reducer';
import pathReducer from './components/Path/reducer';

const rootReducer = combineReducers({
  login: loginReducer,
  signup: signupReducer,
  path: pathReducer,
});

export type RootState = ReturnType<typeof rootReducer>;
export default rootReducer;
