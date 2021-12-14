import { createSelector } from 'reselect';
import { initialState } from './reducer';

const selectPathDomain = (state) => state.path || initialState;

const makeSelectPath = () => createSelector(selectPathDomain, (substate) => substate);

export default makeSelectPath;
export { selectPathDomain };
