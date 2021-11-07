import { Switch, Route, Redirect } from 'react-router-dom';
import auth from './auth';
import _routes from '../routes';
const renderRoutes = () => {
  return (
    <Switch>
      {_routes.map((route, index) => {
        if (route.requestAuth) {
          return (
            <Route
              key={index}
              path={route.path}
              exact={route.exact}
              render={(props) => {
                if (auth.isAuthenticated()) {
                  return <route.component {...props} />;
                }
                return (
                  <Redirect
                    to={{
                      pathname: '/login',
                      state: {
                        from: props.location,
                      },
                    }}
                  />
                );
              }}
            />
          );
        }
        return (
          <Route
            key={index}
            path={route.path}
            exact={route.exact}
            render={(props) => {
              return <route.component {...props} />;
            }}
          />
        );
      })}
    </Switch>
  );
};

export default renderRoutes;
