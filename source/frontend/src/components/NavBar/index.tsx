import ExploreIcon from '@mui/icons-material/Explore';
import NotificationsIcon from '@mui/icons-material/Notifications';
import SearchIcon from '@mui/icons-material/Search';
import SettingsIcon from '@mui/icons-material/Settings';
import history from '../../utils/history';

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
// @ts-ignore
import React from 'react';
import logo from '../../images/logo.png';
import SearchBox from './SearchBox';

interface Props {
  title?: string;
}
const NavBar = (props: Props) => {
  const [auth, setAuth] = React.useState(true);
  const [anchorEl, setAnchorEl] = React.useState<null | HTMLElement>(null);

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setAuth(event.target.checked);
  };

  const handleMenu = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = () => {
    setAnchorEl(null);
  };

  return (
    <div>
      <AppBar position="static">
        <Toolbar>
          <IconButton
            onClick={() => {
              history.push('/home');
            }}
            size="large"
            color="inherit"
          >
            <img
              style={{
                height: '1em',
                backgroundColor: 'white',
              }}
              src={
                logo ??
                `https://ui-avatars.com/api/?name=${String.fromCharCode(
                  Math.random() * 25 + 65,
                  Math.random() * 25 + 65,
                )}&background=0D8ABC&color=fff`
              }
            />
          </IconButton>
          <Typography variant="h6" component="div" sx={{}}>
            {props.title ?? 'Page_Title'}
          </Typography>
          <Box sx={{ margin: 'auto' }}>
            <SearchBox />
          </Box>

          {auth && (
            <div>
              <IconButton size="large" color="inherit">
                <Badge badgeContent={1} color="error">
                  <ExploreIcon />
                </Badge>
              </IconButton>
              <IconButton size="large" color="inherit">
                <Badge badgeContent={2} color="error">
                  <NotificationsIcon />
                </Badge>
              </IconButton>
              <IconButton
                onClick={() => {
                  history.push('/profile');
                }}
                size="large"
                color="inherit"
              >
                <img
                  style={{
                    height: '1em',
                  }}
                  src={`https://ui-avatars.com/api/?name=${'R'}&background=0D8ABC&color=fff`}
                />
              </IconButton>

              <IconButton size="large" onClick={handleMenu} color="inherit">
                <SettingsIcon />
              </IconButton>
              <Menu
                id="menu-appbar"
                anchorEl={anchorEl}
                keepMounted
                open={Boolean(anchorEl)}
                onClose={handleClose}
              >
                <MenuItem onClick={handleClose}>View Profile</MenuItem>
                <MenuItem onClick={handleClose}>Settings</MenuItem>
                <MenuItem onClick={handleClose}>Help</MenuItem>
                <MenuItem onClick={handleClose}>Logout</MenuItem>
              </Menu>
            </div>
          )}
        </Toolbar>
      </AppBar>
    </div>
  );
};

export default NavBar;
