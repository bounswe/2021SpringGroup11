import { Grid } from '@mui/material/';
import { makeStyles } from '@mui/styles';
import ProfileBar from './ProfileBar';

interface Props {}

const useStyles = makeStyles(() => ({
  root: {
    height: '100vh',
  },
  left: {
    background: '#70A9FF',
  },
  middle: {},
  right: {
    background: '#70A9FF',
  },
}));
const Home = (props: Props) => {
  const classes = useStyles();
  return (
    <Grid className={classes.root} container>
      <Grid className={classes.left} item xs={12} md={2}>
        LEFT
      </Grid>
      <Grid className={classes.middle} item xs={12} md={8}>
        HOME
      </Grid>
      <Grid className={classes.right} item xs={12} md={2}>
        <ProfileBar />
      </Grid>
    </Grid>
  );
};

export default Home;
