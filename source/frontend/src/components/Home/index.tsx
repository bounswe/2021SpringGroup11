import { makeStyles } from '@mui/styles';
import { createStructuredSelector } from 'reselect';
import { connect } from 'react-redux';
import { compose } from 'redux';
import NavBar from '../NavBar';
import ProfileBar from './components/ProfileBar';
import Main from './components/Main';
import makeSelectLogin from '../Login/selectors';

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
    height: '100%',
  },
}));

const Home = (props) => {
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

function mapDispatchToProps(dispatch) {
  return {
    dispatch,
  };
}

const withConnect = connect(mapDispatchToProps);
export default compose(withConnect)(Home);
