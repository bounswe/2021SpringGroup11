import NavBar from '../NavBar';
import { makeStyles } from '@mui/styles';
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
    height: '100%',
  },
}));

const Home = () => {
  const classes = useStyles();
  return (
    <div className={classes.root}>
      <NavBar title="Home" />
      <div className={classes.main}>
        <Main />
        <ProfileBar />
      </div>
    </div>
  );
};

export default Home;
