import { makeStyles } from '@mui/styles';
import { Typography } from '@mui/material';
import * as React from 'react';
interface Props {
  link: any;
  description: any;
}

const useStyles = makeStyles(() => ({
  root: {
    width: '100%',
    display: 'flex',
    padding: '100',
    flexDirection: 'column',
    boxSizing: 'border-box',
    border: '2px solid #955B9DFF',
    borderRadius: '3px',
    marginTop: 10,
  },
  root2: {
    width: '75%',
    display: 'flex',
    padding: '100',
    flexDirection: 'column',
    boxSizing: 'border-box',
    border: '2px solid #955B9DFF',
    borderRadius: '3px',
    marginTop: 10,
  },
  item: {
    display: 'flex',
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  body: {
    padding: 10,
  },
}));
const Resource = (props: Props) => {
  const { description, link } = props;

  const classes = useStyles();
  return (
    <div className={classes.root}>
      <div className={classes.item}>
        <Typography>{description}</Typography>
      </div>
      <Typography className={classes.body}>{link}</Typography>
    </div>
  );
};

export default Resource;
