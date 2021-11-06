import Button from "@mui/material/Button";
import renderRoutes from "./utils/renderRoutes";
import { ConnectedRouter } from "connected-react-router";
import { createBrowserHistory } from "history";
import routes from "./routes";
import { BrowserRouter as Router, Switch, Route, Link } from "react-router-dom";
import Login from "./components/Login";
import Signup from "./components/Signup";
import Home from "./components/Home";
import { useState } from "react";
export function App() {
  const [state, setstate] = useState("login");
  return (
    <>
      <Button
        onClick={() => {
          setstate("login");
        }}
      >
        Login
      </Button>
      <Button
        onClick={() => {
          setstate("signup");
        }}
      >
        signup
      </Button>
      <Button
        onClick={() => {
          setstate("home");
        }}
      >
        Home{" "}
      </Button>
      <hr />
      {state === "login" && <Login />}
      {state === "signup" && <Signup />}
      {state === "home" && <Home />}
    </>
  );
}
