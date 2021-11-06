import { Button, TextField } from "@mui/material";
import React from "react";

interface Props {}

const Login = (props: Props) => {
  return (
    <div>
      <h1>Login</h1>

      {/* https://mui.com/components/text-fields/ */}
      <center>
        <img
          src="https://user-images.githubusercontent.com/44238703/139859920-d82ef60d-d4cd-44c0-a917-25e3b7a2d9ba.png"
          alt=""
        />
      </center>
      <h2>Enter your credentials</h2>
      <TextField id="outlined-basic" label="Your Email" variant="outlined" />
      <TextField id="outlined-basic" label="Password" variant="outlined" />
      <Button variant="contained">Contained</Button>
    </div>
  );
};

export default Login;
