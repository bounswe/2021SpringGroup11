import * as React from 'react';
import { makeStyles } from '@mui/styles';
import { connect } from 'react-redux';
import { compose } from 'redux';
import NavBar from '../NavBar';
import ProfileBar from './components/ProfileBar';
import Main from './components/Main';

const useStyles = makeStyles(() => ({
  root: {
    height: '100vh',
  },
  middle: {
    margin: 0,
    padding: 0,
  },
  main: {
    display: 'flex',
    height: 'calc(100% - 64px)',
    position: 'relative',
  },
}));

const Home = (props: { dispatch: any; history: any }) => {
  const { dispatch, history } = props;
  const classes = useStyles();
  return (
    <div className={classes.root}>
      <NavBar title="Home" dispatch={dispatch} history={history} />
      <div className={classes.main}>
        <Main />
        <ProfileBar />
      </div>
    </div>
  );
};

function mapDispatchToProps(dispatch: any) {
  return {
    dispatch,
  };
}

const withConnect = connect(mapDispatchToProps);
export default compose(withConnect)(Home);
