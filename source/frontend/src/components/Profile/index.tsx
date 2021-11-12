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

interface Props {}
const Profile = (props: Props) => {
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
        <img src="https://picsum.photos/200/200?random=1" alt="" />
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
          {[
            { text: 'Enrolled', value: '28' },
            { text: 'Done', value: '28' },
            { text: 'Followings', value: '145' },
            { text: 'Followers', value: '540' },
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
            <div style={{ color: 'red' }}>{'GRANDMASTER'}</div>
            <div style={{ color: 'white' }}>{'username'}</div>
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
      <ProfileContent />
    </div>
  );
};

const ProfileContent = () => {
  const resourcesEnrolled: Resource[] = [
    {
      title: 'Tennis - Beginner',
      effort: 30,
      rating: 6.1,
      isEnrolled: true,
      isFollewed: false,
    },
    {
      title: 'Tennis - Beginner',
      effort: 30,
      rating: 6.1,
      isEnrolled: true,
      isFollewed: false,
    },
    {
      title: 'Tennis - Beginner',
      effort: 30,
      rating: 6.1,
      isEnrolled: true,
      isFollewed: false,
    },
  ];
  return (
    <div
      style={{
        background: '#E5E5EE',
        alignItems: 'center',
        display: 'flex',
        justifyContent: 'space-around',
      }}
    >
      <div
        style={{
          flex: 3,
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
          <div style={{ color: 'red' }}>{'NAME SURNAME'}</div>
          <div style={{ background: 'white', borderRadius: '5px' }}>
            {
              ' Cupidatat exercitation anim id elit qui culpa. Pariatur quis esse mollit non commodo qui magna. Consectetur qui nisi culpa eu dolor labore exercitation occaecat ad cupidatat reprehenderit. Consectetur dolore culpa sunt occaecat laborum laborum ex nisi fugiat ex. '
            }
          </div>
        </div>
      </div>

      <div
        style={{
          flex: 3,

          padding: '5px',
        }}
      >
        {' '}
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
          {resourcesEnrolled.map((resource) => {
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
        {' '}
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
          {resourcesEnrolled.map((resource) => {
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
        <h2>Favorites</h2>

        {[
          { text: 'Tags', value: '5' },
          { text: 'Resources', value: '5' },
        ].map((item) => {
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
      <Card onClick={props.onClick} sx={{ width: '150px', background: props.color }}>
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
