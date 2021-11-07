import { createSelector } from 'reselect';
import { initialState } from './reducer';

const selectLoginDomain = (state) => state.login || initialState;

const makeSelectLogin = () => createSelector(selectLoginDomain, (substate) => substate);

export default makeSelectLogin;
export { selectLoginDomain };
