import React from "react";
import { Redirect } from "react-router-dom";
import Home from "./components/Home";
import Login from "./components/Login";

const routes: {
  path: string;
  component: () => JSX.Element;
}[] = [
  {
    path: "/",
    component: () => <Redirect to="/home"></Redirect>,
  },
  {
    path: "/login",
    component: () => <Login />,
  },
  {
    path: "/home",
    component: () => <Home />,
  },
];

export default routes;
