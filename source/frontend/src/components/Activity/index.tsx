import * as React from 'react';

import { makeStyles } from '@mui/styles';
// @ts-ignore
import { createStructuredSelector } from 'reselect';
import { connect } from 'react-redux';
import { compose } from 'redux';

import { LinearProgress, Typography } from '@mui/material';
import { useEffect } from 'react';
import makeSelectActivity from './selectors';
import NavBar from '../NavBar';
import { getActivities } from './actions';
import auth from '../../utils/auth';

const useStyles = makeStyles(() => ({
  root: {
    height: '100%',
    display: 'flex',
    margin: 'auto',
    flexDirection: 'column',
  },
  header: {},
  activities: {},
  activity: {
    display: 'flex',
    flexDirection: 'column',
    padding: '10px 10px',
  },
}));

const Activity = (props: { dispatch: any; history: any; activity: any }) => {
  const { dispatch, history, activity } = props;
  const classes = useStyles();
  const authInfo = auth.getAuthInfoFromSession();
  const options = {
    hour: 'numeric',
    minute: 'numeric',
    second: 'numeric',
    year: 'numeric',
    month: 'numeric',
    day: 'numeric',
  };

  useEffect(() => {
    console.log(activity);
    dispatch(getActivities(authInfo?.username));
  }, []);
  // const { pathActivities, tagActivities } = activity;
  // console.log(pathActivities, tagActivities);
  return (
    <>
      <NavBar title="Home" dispatch={dispatch} history={history} />
      {activity.loading ? (
        <LinearProgress />
      ) : (
        <div className={classes.root}>
          <div className={classes.header}>
            <Typography align="center" variant="h2">
              ACTIVITY FEED
            </Typography>
          </div>
          <div className={classes.activities}>
            {activity?.activities.map((item: any) => (
              <div className={classes.activity}>
                <Typography variant="h5">{item.summary}</Typography>
                <Typography variant="h6">
                  {
                    // @ts-ignore
                    new Date(item.published).toLocaleDateString('tr-TR', options)
                  }
                </Typography>
              </div>
            ))}
          </div>
        </div>
      )}
      ;
    </>
  );
};

const mapStateToProps = createStructuredSelector({
  activity: makeSelectActivity(),
});
function mapDispatchToProps(dispatch: any) {
  return {
    dispatch,
  };
}

const withConnect = connect(mapStateToProps, mapDispatchToProps);
export default compose(withConnect)(Activity);
