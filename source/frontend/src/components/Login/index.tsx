import { Button, TextField } from '@mui/material';

interface Props {}

const Login = (props: Props) => {
  return (
    <div>
      <h1>Login</h1>

      {/* https://mui.com/components/text-fields/ */}
      <h2>Enter your credentials</h2>
      <TextField id="outlined-basic" label="Your Email" variant="outlined" />
      <TextField id="outlined-basic" label="Password" variant="outlined" />
      <Button variant="contained">Contained</Button>
    </div>
  );
};

export default Login;
