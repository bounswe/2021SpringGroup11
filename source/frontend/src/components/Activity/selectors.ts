import { createSelector } from 'reselect';
import { initialState } from './reducer';

const selectActivityDomain = (state: any) => state.activity || initialState;

const makeSelectActivity = () => createSelector(selectActivityDomain, (substate) => substate);

export default makeSelectActivity;
export { selectActivityDomain };
