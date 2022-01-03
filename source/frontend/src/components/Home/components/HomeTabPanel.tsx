import { Button, Typography } from '@material-ui/core';
import { makeStyles } from '@mui/styles';
import React from 'react';
import { Grid } from '@mui/material';
import history from '../../../utils/history';
import { WordCloudImg } from '../../NavBar/SearchBox';

interface Props {
  items: {
    tags: any;
    paths: any;
  };
}
interface tagProps {
  item: {
    name: string;
    id: string;
  };
}

interface pathProps {
  item: {
    name: string;
    pic: string;
    effort: string;
    rating: string;
    id: string;
  };
}
const useStyles = makeStyles(() => ({
  root: {
    height: '100%',
    display: 'flex',
    flexDirection: 'row',
  },
  panel: {
    width: '50%',
    height: '100%',
    border: '1px solid rgba(0, 0, 0, 0.1)',
  },
  tagHeader: {
    border: '3px solid rgba(0, 0, 0, 0.3)',
    background: '#FFA620',
    padding: '10px',
  },
  tags: {
    display: 'flex',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    maxHeight: '90%',
    overflow: 'scroll',
  },

  paths: {
    display: 'flex',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    maxHeight: '90%',
    overflow: 'scroll',
  },
  tagRoot: {
    background: '#A5A6F6',
    borderRadius: '10px',
    margin: '30px 60px',
    padding: '10px 5px',
  },
  pathRoot: {
    background: '#219653',
    borderRadius: '10px',
    margin: '30px 60px',
    padding: '20px 10px',
  },
  pathHeader: {},
  pathPic: {
    borderRadius: '10px',
    width: '100%',
    height: 'auto',
  },
}));

const TagItem = (props: tagProps) => {
  const { item } = props;
  const classes = useStyles();
  return (
    <Grid item xs={8} className={classes.tagRoot}>
      <div
        onClick={() => history.push(`/topic/${item.id}`)}
        style={{
          display: 'flex',
          flexDirection: 'row',
          alignItems: 'center',
          paddingLeft: '10px',
        }}
      >
        <Typography variant="h4" align="center">
          {item.name}
        </Typography>
        <Button
          style={{
            textAlign: 'center',
            backgroundColor: 'rgba(255,255,255,0.6)',
            marginLeft: 'auto',
            marginRight: '10px',
          }}
        >
          <Typography align="center">GO</Typography>
        </Button>
      </div>
    </Grid>
  );
};

const PathItem = (props: pathProps) => {
  const { item } = props;
  const classes = useStyles();

  return (
    <div className={classes.pathRoot} onClick={() => history.push(`/path/${item.id}`)}>
      {/* <img className={classes.pathPic} src={item.pic} alt="path-item" /> */}
      <WordCloudImg className={classes.pathPic} photo={item.pic} id={item.id} full />

      <div style={{ display: 'flex', flexDirection: 'row' }}>
        <div style={{ display: 'flex', flexDirection: 'column', width: '75%' }}>
          <Button>
            <Typography variant="h5" align="center">
              {item.name}
            </Typography>
          </Button>

          <div
            style={{
              display: 'flex',
              flexDirection: 'row',
              justifyContent: 'space-evenly',
              alignItems: 'center',
            }}
          >
            <Typography style={{ color: '#fff500' }} variant="h6" align="center">
              Effort
              <Typography style={{ color: '#ffffff' }} variant="h6" align="center">
                {item.effort}
              </Typography>
            </Typography>
            <Typography style={{ color: '#fff500' }} variant="h6" align="center">
              Rating
              <Typography style={{ color: '#ffffff' }} variant="h6" align="center">
                {item.rating}
              </Typography>
            </Typography>
          </div>
        </div>
        <Button
          style={{
            textAlign: 'center',
            backgroundColor: 'rgba(255,255,255,0.6)',
            marginLeft: '10px',
            marginRight: '10px',
            padding: '0 40px',
          }}
        >
          <Typography style={{ color: '#F25115' }} variant="h6" align="center">
            GO
          </Typography>
        </Button>
      </div>
    </div>
  );
};

const HomeTabPanel = (props: Props) => {
  const { items } = props;
  const classes = useStyles();
  return (
    <div className={classes.root}>
      <div className={classes.panel}>
        <div className={classes.tagHeader}>
          <Typography variant="h3" align="center">
            Tags
          </Typography>
        </div>
        <Grid container className={classes.tags}>
          {items.tags.map((item) => (
            <TagItem item={item} />
          ))}
        </Grid>
      </div>
      <div className={classes.panel}>
        <div className={classes.tagHeader}>
          <Typography variant="h3" align="center">
            Paths
          </Typography>
        </div>
        <Grid container className={classes.paths}>
          {items.paths.map((item) => (
            <PathItem item={item} />
          ))}
        </Grid>
      </div>
    </div>
  );
};

export default HomeTabPanel;
