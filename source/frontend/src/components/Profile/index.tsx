import ExploreIcon from '@mui/icons-material/Explore';
import NotificationsIcon from '@mui/icons-material/Notifications';
import SearchIcon from '@mui/icons-material/Search';
import SettingsIcon from '@mui/icons-material/Settings';
import {
  alpha,
  AppBar,
  Badge,
  Box,
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
    </div>
  );
};

export default Profile;
