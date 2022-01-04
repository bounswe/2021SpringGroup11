import { makeStyles } from '@mui/styles';
import { connect } from 'react-redux';
import { compose } from 'redux';
import { createStructuredSelector } from 'reselect';
import React, { useEffect, useState } from 'react';
import { Button, Typography } from '@material-ui/core';
import { LinearProgress } from '@mui/material';
import makeSelectPath from './selectors';
import { enrollPath, followPath, getPath } from './actions';
import NavBar from '../NavBar';
// @ts-ignore
import pathPlaceholder from '../../images/pathPlaceholder.png';
import Milestone from './components/Milestone';
import Resource from './components/Resource';

import Tag from './components/Tag';

interface Props {
  history: any;
  dispatch: any;
  path: { path: any; loading: boolean };
  match: { params: { pathId: string } };
}

const useStyles = makeStyles(() => ({
  root: {
    width: '100%',
    display: 'flex',
    margin: '20',
    flexDirection: 'column',
    boxSizing: 'border-box',
  },

  header: {
    boxSizing: 'border-box',
    width: '100%',
    display: 'flex',
    flexDirection: 'row',
    justifyContent: 'space-between',
    padding: 30,
  },

  imgContainer: {
    border: '5px solid #219653',
    borderRadius: 4,
    padding: 20,
    width: 300,
    height: 300,
  },
  image: {
    height: '100%',
    width: '100%',
  },
  titleContainer: {
    display: 'flex',
    flexDirection: 'column',
    // justifyContent: 'space-between',
    width: 1000,
  },
  title: {},
  creator: {},
  descContainer: {
    display: 'flex',
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
    justifyContent: 'space-between',
  },
  desc: {
    margin: 20,
    height: 200,
    width: 500,
    backgroundColor: 'rgb(162,134,134)',
    borderRadius: 4,
    padding: 10,
  },
  tagContainer: {
    display: 'flex',
    alignContent: 'centerq',
  },
  tags: {
    margin: '20px 10px',
    height: 200,
    width: 500,
    backgroundColor: 'rgb(162,134,134)',
    borderRadius: 4,
    padding: 10,
  },
  right: {
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'space-around',
    alignItem: 'center',
    width: 300,
  },
  buttons: {
    display: 'flex',
    flexDirection: 'row',
    justifyContent: 'center',
    width: 300,
    gap: 30,
  },

  enrollFav: {},
  body: {
    display: 'flex',
    flexDirection: 'row',
    justifyContent: 'center',
    gap: 30,
    width: '100%',
    height: 600,
    backgroundColor: 'rgb(159,155,155)',
  },
  milestones: {
    backgroundColor: 'white',
    borderRadius: 10,
    padding: 20,
    margin: 20,
    width: 600,
  },
  comments: {
    backgroundColor: 'white',
    borderRadius: 10,
    padding: 20,
    margin: 20,
    width: 600,
  },
}));

const Path = (props: Props) => {
  const {
    match: {
      params: { pathId },
    },
    history,
    dispatch,
    path: { path, loading },
  } = props;
  const classes = useStyles();

  const [order, setOrder] = useState(-1);
  const handleEnrollButton = () => {
    dispatch(enrollPath(pathId, path.isEnrolled));
  };

  const handleOrderChange = (orderArg: any) => {
    setOrder(orderArg);
  };

  const handleFollowButton = () => {
    dispatch(followPath(pathId, path.isFollowed));
  };
  useEffect(() => {
    dispatch(getPath(pathId));
    console.log(path);
  }, []);

  return (
    <div>
      <NavBar title="Path" dispatch={dispatch} history={history} />
      {loading ? (
        <LinearProgress />
      ) : (
        <div className={classes.root}>
          <div className={classes.header}>
            <div className={classes.imgContainer}>
              <img
                className={classes.image}
                src={path?.photo || pathPlaceholder}
                alt="profile-pic"
              />
            </div>
            <div className={classes.titleContainer}>
              <Typography align="center" variant="h2">
                {path?.title}
              </Typography>
              <Typography align="center" variant="h5">
                Creator: {path?.creator_username}
              </Typography>
              <div className={classes.descContainer}>
                <div className={classes.desc}>
                  <Typography align="center" variant="h4">
                    Path Description
                  </Typography>
                  <Typography variant="body1">{path?.description}</Typography>
                </div>
                <div className={classes.tags}>
                  <Typography align="center" variant="h4">
                    Tags
                  </Typography>
                  <div className={classes.tagContainer}>
                    {path.topics.map((tag: any) => (
                      <Tag id={tag.ID} name={tag.name} />
                    ))}
                  </div>
                </div>
              </div>
            </div>
            <div className={classes.right}>
              <div className={classes.buttons}>
                <Button onClick={handleEnrollButton} color="primary" variant="outlined">
                  {path.isEnrolled ? 'UNENROLL' : 'ENROLL'}
                </Button>
                <Button onClick={handleFollowButton} color="primary" variant="outlined">
                  {path.isFollowed ? 'REMOVE FROM FAVORITE' : 'ADD TO FAVORITE'}
                </Button>
              </div>
              <Typography variant="h5">Rating: {path.rating || 'N/A'}</Typography>
              <Typography variant="h5">Difficulty: {path.effort || 'N/A'}</Typography>
            </div>
          </div>
          <div className={classes.body}>
            <div className={classes.milestones}>
              <Typography align="center" variant="h4">
                MILESTONES AND TASKS
              </Typography>
              {path.milestones.map((milestone: any, index: number) => (
                <Milestone
                  order={index}
                  orderChange={handleOrderChange}
                  key={milestone._id}
                  title={milestone.title}
                  body={milestone.body}
                  type={milestone.type}
                  isEnrolled
                  isChecked={milestone.isFinished}
                  loading={false}
                  onClick={() => {}}
                />
              ))}
            </div>
            <div className={classes.comments}>
              <Typography align="center" variant="h3">
                RESOURCES
              </Typography>
              {path.resources.map((resource: any) =>
                resource.order === order ? (
                  <Resource link={resource.link} description={resource.description} />
                ) : (
                  <div />
                ),
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

const mapStateToProps = createStructuredSelector({
  path: makeSelectPath(),
});
function mapDispatchToProps(dispatch: any) {
  return {
    dispatch,
  };
}

const withConnect = connect(mapStateToProps, mapDispatchToProps);
export default compose(withConnect)(Path);
