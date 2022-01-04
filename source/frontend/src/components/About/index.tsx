/* eslint-disable */

import ExploreIcon from '@mui/icons-material/Explore';
import NotificationsIcon from '@mui/icons-material/Notifications';
import SearchIcon from '@mui/icons-material/Search';
import SettingsIcon from '@mui/icons-material/Settings';
import {
  Box,
  Button,
  Card,
  CardActions,
  CardContent,
  CircularProgress,
  IconButton,
  Modal,
  TextField,
  Typography,
} from '@mui/material';
import { useDispatch } from 'react-redux';
import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import MDEditor from '@uiw/react-md-editor';
import PhotoCamera from '@mui/icons-material/PhotoCamera';
import { toast } from 'react-toastify';

import faker from 'faker';
import NavBar from '../NavBar';
import auth from '../../utils/auth';
import history from '../../utils/history';
import { base64ImgDataGenerator } from '../NavBar/SearchBox';
interface Props {}

const index = (props: Props) => {
  const dispatch = useDispatch();
  const [state, setstate] = useState<string | undefined>();

  useEffect(() => {
    const about = require('./about.md');

    fetch(about)
      .then((response) => {
        return response.text();
      })
      .then((text) => {
        setstate(text);
      });
  }, []);
  if (!state) {
    return (
      <div>
        <NavBar history={history} title="About" dispatch={dispatch} />

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
      <NavBar history={history} title="About" dispatch={dispatch} />
      <div>
        <MDEditor.Markdown
          style={{ background: 'white', borderRadius: '5px', maxWidth: '800px', margin: 'auto' }}
          source={state}
        />
      </div>
    </div>
  );
};

export default index;
