import { makeStyles } from '@mui/styles';
import { Button, Checkbox, CircularProgress, Slide, Typography } from '@mui/material';
import * as React from 'react';
interface Props {
  title: any;
  body: string;
  isEnrolled: boolean;
  isChecked: boolean;
  loading: boolean;
  // eslint-disable-next-line no-unused-vars
  onClick(value: boolean): any;
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
  item: {
    display: 'flex',
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  body: {
    padding: 10,
  },
}));
const Milestone = (props: Props) => {
  const { title, body, isEnrolled, isChecked = false, loading, onClick } = props;
  const [showBody, setShowBody] = React.useState(false);
  const [checked, setChecked] = React.useState(isChecked);
  const handleShowBody = () => {
    setShowBody(!showBody);
  };
  const handleClick = (event: any) => {
    event.persist();
    onClick(!checked);
    setChecked(!checked);
  };
  const classes = useStyles();
  return (
    <div className={classes.root}>
      <div className={classes.item}>
        <Button onClick={handleShowBody}>
          <Typography>{title}</Typography>
        </Button>
        {isEnrolled &&
          (loading ? <CircularProgress /> : <Checkbox checked={checked} onChange={handleClick} />)}
      </div>
      {showBody && (
        <Slide direction="up" in={showBody} mountOnEnter unmountOnExit>
          <Typography className={classes.body}>{body}</Typography>
        </Slide>
      )}
    </div>
  );
};

export default Milestone;
