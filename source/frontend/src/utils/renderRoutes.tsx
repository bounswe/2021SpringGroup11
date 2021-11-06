import React from "react";
import { Switch, Route, Redirect } from "react-router-dom";
import auth from "./auth";
import _routes from "../routes";
const renderRoutes = (routes) => {
  return (
    <Switch>
      {_routes.map((route, index) => {
        <Route
          key={index}
          path={route.path}
          render={(props) => {
            console.log("RENDER");
            if (auth.isAuthenticated()) {
              return <route.component {...props} />;
            } else {
              return (
                <Redirect
                  to={{
                    pathname: "/login",
                    state: {
                      from: props.location,
                    },
                  }}
                ></Redirect>
              );
            }
          }}
        >
          <route.component />
        </Route>;
      })}
    </Switch>
  );
};

export default renderRoutes;
