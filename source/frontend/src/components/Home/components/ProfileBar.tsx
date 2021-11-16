import * as React from 'react';
import { Grid, Typography } from '@mui/material/';
import { makeStyles } from '@mui/styles';
import FavoriteIcon from '@mui/icons-material/Favorite';
// @ts-ignore
import avatarPlaceholder from '../../../images/avatarPlaceholder.png';
// @ts-ignore
import avatar from '../../../images/avatar1.png';
import auth from '../../../utils/auth';

interface Props {
  user: {
    username: string;
    title: string;
    stats: {
      enrolled: number;
      done: number;
      followings: number;
      followers: number;
      tags: number;
      resources: number;
    };
  };
}

const useStyles = makeStyles(() => ({
  root: {
    height: '100%',
    width: '20%',
    background: '#70A9FF',
  },
  imageContainer: {
    margin: '20px',
  },
  profilePic: {
    background: 'white',
    width: '100%',
    height: 'auto',
    padding: '20px',
    borderRadius: '80px',
  },
  username: {
    color: 'white',
    alignItems: 'center',
    justifyContent: 'center',
    alignText: 'center',
  },
  title: {
    background: 'rgba(255,255,255,0.6)',
    borderRadius: '40px',
    color: '#F25115',
    margin: '0 30px',
    padding: '0 10px',
  },
  info: {
    background: 'rgba(255,255,255,0.6)',
    borderRadius: '40px',
    color: '#219653',
    margin: '0px 10px',
    padding: '30px 2px',
  },
  favorites: {
    background: 'rgba(255,255,255,0.6)',
    borderRadius: '40px',
    margin: '20px',
  },
  fav: {
    borderRadius: '40px',
    color: '#219653',
    justifyContent: 'center',
    alignItems: 'center',
    margin: '10px 10px',
  },
}));

const ProfileBar = (props: Props) => {
  const { user } = props;
  const classes = useStyles();
  return (
    <Grid container className={classes.root}>
      <Grid container className={classes.username}>
        <div className={classes.imageContainer}>
          <img className={classes.profilePic} src={avatar} alt="profile-pic" />
        </div>
        <Typography variant="h5" align="center">
          {user.username}
        </Typography>
        <Grid item xs={12} className={classes.title}>
          <Typography variant="h5" align="center">
            {user.title}
          </Typography>
        </Grid>
      </Grid>

      <Grid container justifyContent="center" alignItems="center">
        <Grid item xs={5} className={classes.info}>
          <Typography variant="h5" align="center">
            Enrolled
          </Typography>
          <Typography variant="h5" align="center">
            {user.stats.enrolled}
          </Typography>
        </Grid>
        <Grid item xs={5} className={classes.info}>
          <Typography variant="h5" align="center">
            Done
          </Typography>
          <Typography variant="h5" align="center">
            {user.stats.done}
          </Typography>
        </Grid>
        <Grid item xs={5} className={classes.info}>
          <Typography variant="h5" align="center">
            Followings
          </Typography>
          <Typography variant="h5" align="center">
            {user.stats.followings}
          </Typography>
        </Grid>
        <Grid item xs={5} className={classes.info}>
          <Typography variant="h5" align="center">
            Followers
          </Typography>
          <Typography variant="h5" align="center">
            {user.stats.followers}
          </Typography>
        </Grid>
      </Grid>
      <Grid container justifyContent="center" className={classes.favorites}>
        <Grid
          container
          style={{
            color: '#F25115',
            alignItems: 'center',
            justifyContent: 'center',
            margin: '40px 0px',
          }}
        >
          <FavoriteIcon />
          <Typography variant="h5" align="center">
            Favorites
          </Typography>
        </Grid>
        <Grid item xs={5} className={classes.fav}>
          <Typography variant="h5" align="center">
            Tags
          </Typography>
          <Typography variant="h5" align="center">
            {user.stats.tags}
          </Typography>
        </Grid>
        <Grid item xs={5} className={classes.fav}>
          <Typography variant="h5" align="center">
            Paths
          </Typography>
          <Typography variant="h5" align="center">
            {user.stats.resources}
          </Typography>
        </Grid>
      </Grid>
    </Grid>
  );
};

ProfileBar.defaultProps = {
  // eslint-disable-next-line react/default-props-match-prop-types
  user: {
    username: auth.getAuthInfoFromSession().username,
    title: auth.getAuthInfoFromSession().username === 'robertdown' ? 'GRANDMASTER' : 'BEGINNER',
    stats: {
      enrolled: auth.getAuthInfoFromSession().username === 'robertdown' ? 145 : 0,
      done: auth.getAuthInfoFromSession().username === 'robertdown' ? 103 : 0,
      followings: auth.getAuthInfoFromSession().username === 'robertdown' ? 254 : 0,
      followers: auth.getAuthInfoFromSession().username === 'robertdown' ? 645 : 0,
      tags: auth.getAuthInfoFromSession().username === 'robertdown' ? 126 : 0,
      resources: auth.getAuthInfoFromSession().username === 'robertdown' ? 54 : 0,
    },
  },
};

export default ProfileBar;
