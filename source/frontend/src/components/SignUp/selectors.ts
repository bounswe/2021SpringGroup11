import { createSelector } from 'reselect';
import { initialState } from './reducer';

const selectSignUpDomain = (state) => state.signup || initialState;

const makeSelectSignUp = () => createSelector(selectSignUpDomain, (substate) => substate);

export default makeSelectSignUp;
export { selectSignUpDomain };
