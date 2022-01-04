import * as React from 'react';
import {
  Typography,
  TextField,
  Button,
  Divider,
  Fade,
  Modal,
  CircularProgress,
  Box,
  SnackbarContent,
  Snackbar,
} from '@mui/material/';
import { makeStyles } from '@mui/styles';
import CloseIcon from '@mui/icons-material/Close';
import { useState } from 'react';

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
  barContent: {
    padding: '40px',
    background: '#70A9FF',
  },
  error: {
    backgroundColor: '#990000',
  },
  message: {
    display: 'flex',
    alignItems: 'center',
  },
}));

const ForgotPassModal = (props: Props) => {
  const { open, loading, handleModalClose, handleResetButton, error } = props;
  const classes = useStyles();
  const [openSnackBar, setOpenSnackBar] = useState(false);

  const handleReset = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);

    handleResetButton(data.get('username'));
    setOpenSnackBar(true);
  };

  // @ts-ignore
  // @ts-ignore
  return (
    <>
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
          <Box component="form" onSubmit={handleReset} noValidate>
            <div className={classes.paper}>
              <div className={classes.titleContainer}>
                <Typography variant="h3" align="center" className={classes.title}>
                  Forgot Password
                </Typography>
                <CloseIcon onClick={handleModalClose} className={classes.closeIcon} />
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
                <Button className={classes.resetButton} type="submit" variant="contained">
                  {loading ? (
                    <CircularProgress size={20} color="inherit" />
                  ) : (
                    <Typography>RESET PASSWORD</Typography>
                  )}
                </Button>
              </div>
            </div>
          </Box>
        </Fade>
      </Modal>
      <Snackbar
        anchorOrigin={{
          vertical: 'top',
          horizontal: 'center',
        }}
        autoHideDuration={6000}
        onClose={() => setOpenSnackBar(!openSnackBar)}
        open={openSnackBar && !loading}
      >
        {!loading ? (
          <SnackbarContent
            className={classes.barContent}
            message={<span className={classes.message}>A new password is sent to your e-mail</span>}
            action={
              <Button variant="contained" color="success" size="large">
                SIGN IN
              </Button>
            }
          />
        ) : (
          <div />
        )}
      </Snackbar>
    </>
  );
};

export default ForgotPassModal;
