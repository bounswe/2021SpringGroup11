import React = require('react');
import { useState } from 'react';
import {
  Container,
  CssBaseline,
  Box,
  Typography,
  TextField,
  Button,
  InputAdornment,
  IconButton,
  Snackbar,
  SnackbarContent,
  CircularProgress,
} from '@mui/material/';
import { makeStyles } from '@mui/styles';
import { Visibility, VisibilityOff } from '@mui/icons-material';
// @ts-ignore
import greenEllipse from '../../images/green-ellipse.png';
// @ts-ignore
import redEllipse from '../../images/red-ellipse.png';
// @ts-ignore
import logo from '../../images/logo.png';
import { doSignup } from './actions';
import { connect } from 'react-redux';
import { compose } from 'redux';
import makeSelectSignUp from './selectors';
import { createStructuredSelector } from 'reselect';
interface Props {
  history: any;
  dispatch: any;
  signup: any;
}

const useStyles = makeStyles(() => ({
  root: {
    height: '100%',
    display: 'flex',
    margin: 'auto',
  },
  imgTopLeft: {
    position: 'fixed',
    top: 0,
    left: 0,
    width: '25%',
    height: 'auto',
  },
  logo: {},
  imgBottomRight: {
    position: 'fixed',
    bottom: 0,
    right: 0,
    width: '15%',
    height: 'auto',
  },
  textField: {
    background: 'rgba(0,0,0,0.1)',
    borderRadius: '20px',
    height: '50px',
    margin: 'normal',
  },
  textFieldRoot: {
    margin: '10px',
  },
  textCred: {
    fontFamily: 'Roboto',
    fontStyle: 'normal',
    fontWeight: 300,
    fontSize: '26px',
    lineHeight: '30px',
    textAlign: 'center',
    letterSpacing: '0.01em',
    color: '#555555',
  },
  textAcc: {
    fontFamily: 'Roboto',
    fontStyle: 'normal',
    fontWeight: 300,
    fontSize: '18',
    letterSpacing: '0.01em',
    color: '#555555',
  },
  button: {
    background: '#70A9FF',
    height: '80px',
    margin: '10px',
    borderRadius: '20px',
  },
  barContent: {
    padding: '40px',
  },
  error: {
    backgroundColor: '#990000',
  },
  message: {
    display: 'flex',
    alignItems: 'center',
  },
}));

const SignUp = (props: Props) => {
  const { history, dispatch, signup } = props;
  const classes = useStyles();

  const [emailError, setEmailError] = useState(false);
  const [nameError, setNameError] = useState(false);
  const [surnameError, setSurnameError] = useState(false);
  const [passwordError, setPasswordError] = useState(false);
  const [openSnackBar, setOpenSnackBar] = useState(false);

  const [showPassword, setShowPassword] = useState(false);
  const handleClickShowPassword = () => setShowPassword(!showPassword);

  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    const userInfo = {
      name: data.get('name'),
      surname: data.get('surname'),
      username: data.get('username'),
      email: data.get('email'),
      password: data.get('password'),
    };

    if (!nameValidation(userInfo.name)) {
      return;
    }if (!surnameValidation(userInfo.surname)) {
      return;
    }

    if (!emailValidation(userInfo.email)) {
      return;
    }
    if (!passwordValidation(userInfo.password, data.get('repeatPassword'))) {
      return;
    }

    dispatch(
      doSignup(userInfo),
    );

    setOpenSnackBar(true);
  };

  const emailValidation = (email) => {
    const regex =
      /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
    if (!email || regex.test(email) === false) {
      setEmailError(true);
      return false;
    }
    setEmailError(false);
    return true;
  };
  const passwordValidation = (password1, password2) => {
    if (password1 !== password2) {
      setPasswordError(true);
      return false;
    }
    setPasswordError(false);
    return true;
  };

  const nameValidation = (name) => {
    if (name === '') {
      setNameError(true);
      return false;
    }
    setNameError(false);
    return true;
  };

  const surnameValidation = (surname) => {
    if (surname === '') {
      setSurnameError(true);
      return false;
    }
    setSurnameError(false);
    return true;
  };

  return (
    <Container classN1ame={classes.root} maxWidth="xs">
      <img className={classes.imgTopLeft} src={redEllipse} alt={'ellipses'} />
      <img className={classes.imgBottomRight} src={greenEllipse} alt={'ellipse'} />
      <CssBaseline />
      <Box
        sx={{
          marginTop: '20%',
          marginBottom: 4,
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
        }}
      >
        <img className={classes.logo} src={logo} alt={'logo'} />
        <Typography className={classes.textCred} component="h1" variant="h5">
          Create an Account
        </Typography>
        <Box component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1 }}>
          <TextField
            InputProps={{ className: classes.textField }}
            className={classes.textFieldRoot}
            required
            fullWidth
            id="name"
            label="Name"
            name="name"
            autoComplete="name"
            autoFocus
            error={nameError}
            helperText={nameError ? 'Name can\'t be empty.' : ''}
          />
          <TextField
            InputProps={{ className: classes.textField }}
            className={classes.textFieldRoot}
            required
            fullWidth
            id="surname"
            label="Surname"
            name="surname"
            autoComplete="surname"
            error={surnameError}
            helperText={surnameError ? 'Surname can\'t be empty.' : ''}
          />
          <TextField
            InputProps={{ className: classes.textField }}
            className={classes.textFieldRoot}
            required
            fullWidth
            id="username"
            label="Username"
            name="username"
            autoComplete="username"
            error={props.signup.signupErrorMessage}
            helperText={props.signup.signupErrorMessage}
          />
          <TextField
            InputProps={{ className: classes.textField }}
            className={classes.textFieldRoot}
            fullWidth
            id="email"
            label="Email"
            name="email"
            autoComplete="email"
            error={emailError}
            helperText={emailError ? 'Email is not valid.' : ''}
          />
          <TextField
            InputProps={{
              className: classes.textField,
              endAdornment: (
                <InputAdornment position="end">
                  <IconButton
                    aria-label="toggle password visibility"
                    onClick={handleClickShowPassword}
                    onMouseDown={handleClickShowPassword}
                  >
                    {showPassword ? <Visibility /> : <VisibilityOff />}
                  </IconButton>
                </InputAdornment>
              ),
            }}
            className={classes.textFieldRoot}
            required
            fullWidth
            name="password"
            label="Password"
            type={showPassword ? 'text' : 'password'}
            id="password"
            autoComplete="current-password"
          />
          <TextField
            InputProps={{
              className: classes.textField,
              endAdornment: (
                <InputAdornment position="end">
                  <IconButton
                    aria-label="toggle password visibility"
                    onClick={handleClickShowPassword}
                    onMouseDown={handleClickShowPassword}
                  >
                    {showPassword ? <Visibility /> : <VisibilityOff />}
                  </IconButton>
                </InputAdornment>
              ),
            }}
            className={classes.textFieldRoot}
            required
            fullWidth
            name="repeatPassword"
            label="Repeat password"
            type={showPassword ? 'text' : 'password'}
            id="repeatPassword"
            error={passwordError}
            helperText={passwordError && 'Passwords are not identical.'}
          />
          <Button
            className={classes.button}
            type="submit"
            fullWidth
            variant="contained"
            sx={{ mt: 3, mb: 2 }}
          >
            {signup.loading ? (
              <CircularProgress size={20} color="inherit" />
            ) : (
              <Typography>GET STARTED</Typography>
            )}
          </Button>
        </Box>
      </Box>
      <Snackbar
        anchorOrigin={{
          vertical: 'top',
          horizontal: 'center',
        }}
        autoHideDuration={6000}
        onClose={() => setOpenSnackBar(!openSnackBar)}
        open={openSnackBar && !signup.loading}
      >
        {!signup.error ? (
          <SnackbarContent
            className={classes.barContent}
            message={<span className={classes.message}>Successfully Registered!</span>}
          />
        ) : (
          <SnackbarContent
            className={classes.error}
            message={<span className={classes.message}>{signup.signupError.signupErrorMessage}</span>}
          />
        )}
      </Snackbar>
    </Container>
  );
};

const mapStateToProps = createStructuredSelector({
  signup: makeSelectSignUp(),
});
function mapDispatchToProps(dispatch) {
  return {
    dispatch,
  };
}

const withConnect = connect(mapStateToProps, mapDispatchToProps);
export default compose(withConnect)(SignUp);
