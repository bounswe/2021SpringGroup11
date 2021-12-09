import ExploreIcon from '@mui/icons-material/Explore';
import NotificationsIcon from '@mui/icons-material/Notifications';
import SearchIcon from '@mui/icons-material/Search';
import SettingsIcon from '@mui/icons-material/Settings';
import {
  alpha,
  AppBar,
  Badge,
  Box,
  Button,
  Card,
  CardActions,
  CardContent,
  CircularProgress,
  IconButton,
  InputBase,
  Menu,
  MenuItem,
  styled,
  Toolbar,
  Typography,
} from '@mui/material';
import React, { useEffect, useState } from 'react';
import { BrowserRouter as Router, Switch, Route, Link, useParams } from 'react-router-dom';
import avatar from '../../images/avatar1.png';

import NavBar from '../NavBar';
import { getProfileData } from './helper';
import auth from '../../utils/auth';

interface Props {
  history: any;
}
const Profile = (props: Props) => {
  const { history } = props;
  const { username } = useParams();

  const [resources, setResources] = useState(null);
  const [user, setUser] = useState(null);
  const [stats, setStats] = useState(null);
  const [favorites, setFavorites] = useState(null);

  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    (async () => {
      // simulate api request waiting
      setTimeout(async () => {
        const {
          resources: _resources,
          user: _user,
          stats: _stats,
          favorites: _favorites,
        } = await getProfileData(username || auth.getAuthInfoFromSession()?.username || 'e');
        console.log(_resources);

        setResources(_resources);
        setUser({ ..._user });
        setStats(_stats);
        setFavorites(_favorites);
        setLoading(false);
      }, 1000);
    })();
  }, [username]);

  if (loading) {
    return (
      <div>
        <NavBar history={history} title="Profile"></NavBar>
        <Box
          sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '90vh' }}
        >
          <CircularProgress />
        </Box>
      </div>
    );
  }
  return (
    <div>
      <NavBar title="Profile" history={history}></NavBar>

      <div
        style={{
          height: '15rem',
          background: `url('https://i.snipboard.io/sTKFNH.jpg') 0px 0px/100% auto, #6DB3F2`,
          alignItems: 'center',
          display: 'flex',
          justifyContent: 'center',
        }}
      >
        <img style={{ height: '80%' }} src={avatar} alt="" />
      </div>
      <div
        style={{
          height: '5rem',
          background: '#70A9FF',
          alignItems: 'center',
          display: 'flex',
          justifyContent: 'space-around',
        }}
      >
        <div
          style={{
            alignItems: 'center',
            display: 'flex',
            flex: 1,

            justifyContent: 'space-evenly',
            borderRadius: '10px',
            background: 'white',
            padding: '5px',
          }}
        >
          {stats.map((item) => (
            <div
              style={{
                alignItems: 'center',
                display: 'flex',
                flexDirection: 'column',
                justifyContent: 'space-around',
              }}
            >
              <div style={{ color: 'green' }}>{item.text}</div>
              <div>{item.value}</div>
            </div>
          ))}
        </div>
        <div
          style={{
            flex: 1,
          }}
        >
          <div
            style={{
              alignItems: 'center',
              display: 'flex',
              flexDirection: 'column',
              justifyContent: 'space-around',
            }}
          >
            <div style={{ color: 'red' }}>{user.experience}</div>
            <div style={{ color: 'white' }}>{user.username}</div>
          </div>
        </div>
        <Button
          style={{
            color: 'white',
            marginLeft: 'auto',
            // padding: '0 20px',
            flex: 1,
          }}
        >
          Edit Your Profile
        </Button>
      </div>
      <ProfileContent user={user} resources={resources} favorites={favorites} />
    </div>
  );
};

interface ProfileContentProps {
  resources: Resource[];
  favorites: { text: string; value: string }[];
  user: any;
}
const ProfileContent = (props: ProfileContentProps) => (
  <div
    style={{
      background: '#E5E5EE',
      // alignItems: 'center',
      display: 'flex',
      justifyContent: 'space-around',
    }}
  >
    <div
      style={{
        flex: 2,
      }}
    >
      <div
        style={{
          alignItems: 'center',
          display: 'flex',
          flexDirection: 'column',
          justifyContent: 'space-around',
        }}
      >
        <div style={{ color: 'red' }}>{props.user.name}</div>
        <div style={{ background: 'white', borderRadius: '5px' }}>{props.user.bio}</div>
      </div>
    </div>

    <div
      style={{
        flex: 3,

        padding: '5px',
      }}
    >
      <h2>Enrolled Paths</h2>
      <div
        style={{
          alignItems: 'center',
          display: 'flex',

          justifyContent: 'space-evenly',
          padding: '5px',
          flexWrap: 'wrap',
        }}
      >
        {props.resources
          .filter((r) => r.isEnrolled)
          .map((resource) => (
            <ResourceCard
              resource={resource}
              onClick={() => {}}
              buttonText={resource.isEnrolled ? 'Unenroll' : 'Enroll'}
              onButtonClick={() => {
                alert('TODO');
              }}
              color="#9EE97A"
            />
          ))}
      </div>
    </div>

    <div
      style={{
        flex: 3,

        padding: '5px',
      }}
    >
      <h2>Favorite Paths</h2>
      <div
        style={{
          alignItems: 'center',
          display: 'flex',

          justifyContent: 'space-evenly',
          padding: '5px',
          flexWrap: 'wrap',
        }}
      >
        {props.resources
          .filter((r) => r.isFollowed)
          .map((resource) => (
            <ResourceCard
              resource={resource}
              onClick={() => {}}
              buttonText={resource.isFollowed ? 'Unfav.' : 'Fav.'}
              onButtonClick={() => {
                alert('TODO');
              }}
              color="#70A9FF"
            />
          ))}
      </div>
    </div>

    <div>
      <h2>Favorites</h2>
      <div
        style={{
          alignItems: 'center',
          display: 'flex',
          flex: 1,

          justifyContent: 'space-around',
          padding: '5px',
          flexDirection: 'column',
        }}
      >
        {props.favorites.map((item) => (
          <div
            style={{
              alignItems: 'center',
              display: 'flex',
              flexDirection: 'column',
              justifyContent: 'space-around',
              borderRadius: '10px',
              background: 'white',
              margin: '10px',
            }}
          >
            <div style={{ color: 'green' }}>{item.text}</div>
            <div>{item.value}</div>
          </div>
        ))}
      </div>
    </div>
  </div>
);

interface Resource {
  title: string;
  effort: number; // percent
  rating: number;
  isEnrolled: boolean;
  isFollowed: boolean;
  photo: string;
}
interface ResourceCardProps {
  resource: Resource;
  onClick: () => void;
  buttonText: string;
  onButtonClick: () => void;
  color: string;
}

export const ResourceCard = (props: ResourceCardProps) => (
  <>
    <Card onClick={props.onClick} sx={{ width: '200px', background: props.color, margin: '5px' }}>
      <CardContent>
        <img src={props.resource.photo} style={{ width: '100%', height: '150px' }} alt="" />
        <Typography sx={{ fontSize: 14, whiteSpace: 'nowrap' }} color="text.secondary" gutterBottom>
          {props.resource.title}
        </Typography>
        <div
          style={{
            alignItems: 'center',
            display: 'flex',
            flex: 1,

            justifyContent: 'space-evenly',
            borderRadius: '10px',
            background: 'white',
            padding: '5px',
          }}
        >
          {[
            { text: 'Effort', value: props.resource.effort },
            { text: 'Rating', value: props.resource.rating },
          ].map((item) => (
            <div
              style={{
                alignItems: 'center',
                display: 'flex',
                flexDirection: 'column',
                justifyContent: 'space-around',
              }}
            >
              <div style={{ color: 'green' }}>{item.text}</div>
              <div>{item.value}</div>
            </div>
          ))}
        </div>
      </CardContent>
      <CardActions>
        <Button
          sx={{ backgroundColor: 'rgba(255,255,255,0.7)', color: 'black' }}
          fullWidth
          size="medium"
          onClick={props.onButtonClick}
        >
          {props.buttonText}
        </Button>
      </CardActions>
    </Card>
  </>
);
export default Profile;
