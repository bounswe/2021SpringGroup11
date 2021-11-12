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
  IconButton,
  InputBase,
  Menu,
  MenuItem,
  styled,
  Toolbar,
  Typography,
} from '@mui/material';
import React from 'react';
import NavBar from '../NavBar';
import { getProfileData } from './helper';

interface Props {}
const Profile = (props: Props) => {
  const { resources, user, stats, favorites } = getProfileData();
  return (
    <div>
      <NavBar title="Profile"></NavBar>

      <div
        style={{
          height: '15rem',
          background: 'cyan',
          alignItems: 'center',
          display: 'flex',
          justifyContent: 'center',
        }}
      >
        <div></div>
        <img src={user.photo} alt="" />
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
          {stats.map((item) => {
            return (
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
            );
          })}
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
            flex: 1,
            color: 'white',
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
const ProfileContent = (props: ProfileContentProps) => {
  return (
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
        <h2>Resources Enrolled</h2>
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
            .map((resource) => {
              return (
                <ResourceCard
                  resource={resource}
                  onClick={() => {}}
                  buttonText={resource.isEnrolled ? 'Unenroll' : 'Enroll'}
                  onButtonClick={() => {
                    alert('TODO');
                  }}
                  color="#9EE97A"
                />
              );
            })}
        </div>
      </div>

      <div
        style={{
          flex: 3,

          padding: '5px',
        }}
      >
        <h2>Resources Following</h2>
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
            .filter((r) => r.isFollewed)
            .map((resource) => {
              return (
                <ResourceCard
                  resource={resource}
                  onClick={() => {}}
                  buttonText={resource.isEnrolled ? 'Unfollow' : 'Follow'}
                  onButtonClick={() => {
                    alert('TODO');
                  }}
                  color="#70A9FF"
                />
              );
            })}
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
          {props.favorites.map((item) => {
            return (
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
            );
          })}
        </div>
      </div>
    </div>
  );
};

interface Resource {
  title: string;
  effort: number; // percent
  rating: number;
  isEnrolled: boolean;
  isFollewed: boolean;
}
interface ResourceCardProps {
  resource: Resource;
  onClick: () => void;
  buttonText: string;
  onButtonClick: () => void;
  color: string;
}

const ResourceCard = (props: ResourceCardProps) => {
  return (
    <>
      <Card onClick={props.onClick} sx={{ width: '140px', background: props.color, margin: '5px' }}>
        <CardContent>
          <Typography sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>
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
            ].map((item) => {
              return (
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
              );
            })}
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
};
export default Profile;
