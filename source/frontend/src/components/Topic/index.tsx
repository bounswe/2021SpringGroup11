import { Box, Chip, CircularProgress, IconButton, ListItem, Paper } from '@mui/material';
import React, { useEffect, useState } from 'react';
import { useDispatch } from 'react-redux';
import { useParams } from 'react-router-dom';
import FavoriteIcon from '@mui/icons-material/Favorite';
import { toast } from 'react-toastify';
// import avatar from '../../images/avatar1.png';
import NavBar from '../NavBar';
// import auth from '../../utils/auth';
import {
  getPathsByTopicID,
  getRelatedTopicsByTopicID,
  getTopicDataByTopicID,
  IPath,
  ITopic,
  updateFavTopic,
} from './helper';
// import { getFakeTopics } from './fakeData';
import { ResourceCard } from '../Profile';

interface Props {
  history: any;
}

const Profile = (props: Props) => {
  const { history } = props;
  // @ts-ignore
  const { topicID } = useParams();

  const [loading, setLoading] = useState(true);

  // @ts-ignore
  const [topic, settopic] = useState<ITopic>(null);
  // @ts-ignore
  const [relatedTopics, setrelatedTopics] = useState<ITopic[]>(null);
  // @ts-ignore
  const [paths, setpaths] = useState<IPath[]>(null);
  const dispatch = useDispatch();

  useEffect(() => {
    setLoading(true);
    (async () => {
      // simulate api request waiting
      setTimeout(async () => {
        // @ts-ignore
        settopic(await getTopicDataByTopicID(topicID));
        try {
          setrelatedTopics(await getRelatedTopicsByTopicID(topicID));
        } catch (error) {
          setrelatedTopics([]);
        }
        setpaths(await getPathsByTopicID(topicID));
        setLoading(false);
      }, 10);
    })();
  }, [topicID]);

  if (loading) {
    return (
      <div>
        <NavBar history={history} title="Topic" dispatch={dispatch} />
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
      <NavBar title={`Topic:${topic.name}`} history={history} dispatch={dispatch} />

      <div
        style={{
          display: 'flex',
          flexDirection: 'row',
          width: '100%',
          alignItems: 'center',
          justifyContent: 'center',
        }}
      >
        <h1>{topic.name}</h1>
        <IconButton aria-label="favorite">
          <FavoriteIcon
            color={topic.isFav ? 'success' : 'error'}
            onClick={async () => {
              const newState = !topic.isFav;
              // TODO:
              try {
                await updateFavTopic(topic.id, newState);
              } catch (error) {
                console.error(error);
              }
              toast.success(
                `${newState ? 'Favorited' : 'Unfavorited'} successfully, Topic:${topic.name}`,
                {
                  position: 'top-left',
                  autoClose: 5000,
                  hideProgressBar: false,
                  closeOnClick: true,
                  pauseOnHover: true,
                  draggable: true,
                  progress: undefined,
                },
              );
              settopic({ ...topic, isFav: newState });
            }}
          />
        </IconButton>
      </div>

      <>
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
          {relatedTopics?.length === 0 && <h3>-empty-</h3>}
          {relatedTopics.slice(0, 16).map((relTop) => (
            <ListItem sx={{ margin: '10px', width: 'unset' }}>
              <Chip onClick={() => history.push(`/topic/${relTop.id}`)} label={relTop.name} />
            </ListItem>
          ))}
        </Paper>
      </>

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
              // @ts-ignore
              id: path._id,
            }}
            onClick={() => {
              history.push(`/path/${path._id}`);
            }}
            buttonText={path.isEnrolled ? 'Unenroll' : 'Enroll'}
            onButtonClick={() => {
              // alert('TODO');
              history.push(`/path/${path._id}`);
            }}
            color="#9EE97A"
          />
        ))}
      </div>
    </div>
  );
};
export default Profile;
