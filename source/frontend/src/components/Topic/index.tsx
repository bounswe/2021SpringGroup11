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
  Chip,
  CircularProgress,
  IconButton,
  InputBase,
  ListItem,
  Menu,
  MenuItem,
  Paper,
  styled,
  Toolbar,
  Typography,
} from '@mui/material';
import React, { useEffect, useState } from 'react';
import { BrowserRouter as Router, Switch, Route, Link, useParams } from 'react-router-dom';
import avatar from '../../images/avatar1.png';

import NavBar from '../NavBar';
import auth from '../../utils/auth';
import {
  getPathsByTopicID,
  getRelatedTopicsByTopicID,
  getTopicDataByTopicID,
  IPath,
  ITopic,
} from './helper';
import { getFakeTopics } from './fakeData';
import { ResourceCard } from '../Profile';

interface Props {
  history: any;
}
const Profile = (props: Props) => {
  const { history } = props;
  const { topicID } = useParams();

  const [loading, setLoading] = useState(true);

  const [topic, settopic] = useState<ITopic>(null);
  const [relatedTopics, setrelatedTopics] = useState<ITopic[]>(null);
  const [paths, setpaths] = useState<IPath[]>(null);

  useEffect(() => {
    setLoading(true);
    (async () => {
      // simulate api request waiting
      setTimeout(async () => {
        settopic(await getTopicDataByTopicID(topicID));
        setrelatedTopics(await getRelatedTopicsByTopicID(topicID));
        setpaths(await getPathsByTopicID(topicID));
        setLoading(false);
      }, 1000);
    })();
  }, [topicID]);

  if (loading) {
    return (
      <div>
        <NavBar history={history} title="Topic"></NavBar>
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
      <NavBar title={`Topic:${topicID}`} history={history}></NavBar>
      <div>Topic</div>
      <div>
        <h1>{topic.name}</h1>
        <Button>Fav</Button>
      </div>
      <h1>Related Topics</h1>
      <Paper
        sx={{
          display: 'flex',
          justifyContent: 'center',
          flexWrap: 'wrap',
          listStyle: 'none',
          p: 0.5,
          m: 0,
          flexDirection: 'row',
        }}
      >
        {relatedTopics.map((relTop) => (
          <ListItem sx={{ margin: '10px', width: 'unset' }}>
            <Chip onClick={() => history.push(`/topic/${relTop.ID}`)} label={relTop.name} />
          </ListItem>
        ))}
      </Paper>

      <h1>Paths</h1>
      <div
        style={{
          alignItems: 'center',
          display: 'flex',

          justifyContent: 'space-evenly',
          padding: '5px',
          flexWrap: 'wrap',
        }}
      >
        {paths.map((path) => (
          <ResourceCard
            resource={{
              title: path.title,
              effort: path.effort,
              rating: path.rating,
              isEnrolled: path.isEnrolled,
              isFollowed: path.isFav,
              photo: path.photo,
            }}
            onClick={() => {}}
            buttonText={path.isEnrolled ? 'Unenroll' : 'Enroll'}
            onButtonClick={() => {
              alert('TODO');
            }}
            color="#9EE97A"
          />
        ))}
      </div>
    </div>
  );
};
export default Profile;