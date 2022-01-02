import { makeStyles } from '@mui/styles';
import { Button, Typography } from '@mui/material';
import * as React from 'react';
import history from '../../../utils/history';

interface Props {
  id: string;
  name: string;
}

const useStyles = makeStyles(() => ({
  root: {
    height: 25,
    borderRadius: '10px',
    backgroundColor: '#F25115',
    padding: '1px 10px',
    textTransform: 'none',
    margin: '10px 5px',
  },
}));

const Tag = (props: Props) => {
  const { id, name } = props;

  const classes = useStyles();
  return (
    <Button onClick={() => history.push(`/topic/${id}`)}>
      <Typography className={classes.root} align="center" variant="body2">
        {name}
      </Typography>
    </Button>
  );
};

export default Tag;
