import React = require('react');
import { useState } from 'react';
import {
  Container,
  CssBaseline,
  Box,
  Typography,
  TextField,
  Button,
  Grid,
  InputAdornment,
  IconButton,
} from '@mui/material/';
import { makeStyles } from '@mui/styles';
import { Visibility, VisibilityOff } from '@mui/icons-material';
// @ts-ignore
import loginBottomRight from '../../images/login-bottom-right.png';
// @ts-ignore
import loginTopLeft from '../../images/login-top-left.png';
// @ts-ignore
import logo from '../../images/logo.png';
import { login } from './actions';
import { connect } from 'react-redux';
import { compose } from 'redux';
import makeSelectLogin from './selectors';
import { createStructuredSelector } from 'reselect';
interface Props {
  history: any;
  dispatch: any;
  login: any;
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
    borderRadius: '20px',
  },
}));

const Login = (props: Props) => {
  const { history, dispatch } = props;
  const classes = useStyles();

  const [showPassword, setShowPassword] = useState(false);
  const handleClickShowPassword = () => setShowPassword(!showPassword);

  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);

    dispatch(
      login({
        username: data.get('username'),
        password: data.get('password'),
      }),
    );
  };

  return (
    <Container className={classes.root} maxWidth="xs">
      <img className={classes.imgTopLeft} src={loginTopLeft} alt={'ellipses'} />
      <img className={classes.imgBottomRight} src={loginBottomRight} alt={'ellipse'} />
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
          Enter Your Credentials
        </Typography>
        <Box component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1 }}>
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
            error={props.login.loginErrorMessage}
            helperText={props.login.loginErrorMessage}
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
            margin="normal"
            required
            fullWidth
            name="password"
            label="Password"
            type={showPassword ? 'text' : 'password'}
            id="password"
            autoComplete="current-password"
          />
          <Button
            className={classes.button}
            type="submit"
            fullWidth
            variant="contained"
            sx={{ mt: 3, mb: 2 }}
          >
            Sign In
          </Button>
          <Grid container>
            <Grid style={{ marginTop: 'auto' }} item xs>
              <Button size="medium" style={{ color: '#000000', background: '#FFAE48' }}>
                Forgot password?
              </Button>
            </Grid>
            <Grid item>
              <Typography className={classes.textAcc}>Don't have an account?</Typography>
              <Button
                onClick={() => history.push('/signup')}
                size="medium"
                style={{
                  color: '#000000',
                  background: '#9EE97A',
                  marginLeft: '100px',
                  right: 0,
                }}
              >
                Sign Up
              </Button>
            </Grid>
          </Grid>
        </Box>
      </Box>
    </Container>
  );
};

const mapStateToProps = createStructuredSelector({
  login: makeSelectLogin(),
});
function mapDispatchToProps(dispatch) {
  return {
    dispatch,
  };
}

const withConnect = connect(mapStateToProps, mapDispatchToProps);
export default compose(withConnect)(Login);
