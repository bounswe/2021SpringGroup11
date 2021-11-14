import React = require('react');
import {
  Typography,
  TextField,
  Button,
  Divider,
  Fade,
  Modal,
  CircularProgress,
} from '@mui/material/';
import { makeStyles } from '@mui/styles';
import CloseIcon from '@mui/icons-material/Close';
// @ts-ignore
import loginBottomRight from '../../images/login-bottom-right.png';
// @ts-ignore
import loginTopLeft from '../../images/login-top-left.png';
// @ts-ignore
import logo from '../../images/logo.png';

interface Props {
  handleModalClose: any;
  loading: boolean;
  open: boolean;
  error: boolean;
  handleResetButton: any;
}
const useStyles = makeStyles(() => ({
  modal: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  },
  paper: {
    width: 465,
    maxWidth: 465,
    flex: 1,
    borderRadius: 4,
    maxHeight: '80vh',
    padding: '60px 30px',
    paddingBottom: 40,
    gap: 30,
    display: 'flex',
    flexDirection: 'column',
    background: 'white',
  },
  textField: {
    background: 'rgba(0,0,0,0.1)',
    borderRadius: '20px',
  },
  title: {
    fontFamily: 'Roboto',
    fontStyle: 'normal',
    fontWeight: 300,
    fontSize: '26px',
    lineHeight: '30px',
    textAlign: 'center',
    letterSpacing: '0.01em',
    color: '#555555',
  },
  titleContainer: {
    display: 'flex',
    width: '100%',
    justifyContent: 'space-between',
  },
  closeIcon: {
    width: 30,
    height: 30,
    marginTop: -50,
    marginRight: -25,
    cursor: 'pointer',
  },
  divider: {
    margin: '0px -30px',
  },
  buttonContainer: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  },
  resetButton: {},
}));

const ForgotPassModal = (props: Props) => {
  const { open, loading, handleModalClose, handleResetButton, error } = props;
  const classes = useStyles();

  return (
    <Modal
      aria-labelledby="modal-title"
      aria-describedby="modal-description"
      className={classes.modal}
      closeAfterTransition
      BackdropProps={{
        timeout: 500,
      }}
      open={open}
    >
      <Fade in={open}>
        <div className={classes.paper}>
          <div className={classes.titleContainer}>
            <Typography variant="h3" align="center" className={classes.title}>
              Forgot Password
            </Typography>
            {<CloseIcon onClick={handleModalClose} className={classes.closeIcon} />}
          </div>
          <Divider className={classes.divider} />
          <TextField
            InputProps={{ className: classes.textField }}
            margin="normal"
            required
            fullWidth
            id="username"
            label="Username"
            name="username"
            autoComplete="username"
            autoFocus
            error={error}
          />
          <div className={classes.buttonContainer}>
            <Button className={classes.resetButton} variant="contained" onClick={handleResetButton}>
              {loading ? (
                <CircularProgress size={20} color="inherit" />
              ) : (
                <Typography>RESET PASSWORD</Typography>
              )}
            </Button>
          </div>
        </div>
      </Fade>
    </Modal>
  );
};

export default ForgotPassModal;
