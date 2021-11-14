import { Redirect } from 'react-router-dom';
import { lazy, LazyExoticComponent } from 'react';

const routes: {
  path: string;
  component: (() => JSX.Element) | LazyExoticComponent<(props: any) => JSX.Element>;
  exact: boolean;
  requestAuth: boolean;
}[] = [
  {
    path: '/',
    exact: true,
    component: () => <Redirect to="/home" />,
    requestAuth: false,
  },
  {
    path: '/login',
    exact: true,
    component: lazy(() => import('./components/Login')),
    requestAuth: false,
  },
  {
    path: '/signup',
    exact: true,
    component: lazy(() => import('./components/Signup')),
    requestAuth: false,
  },
  {
    path: '/home',
    exact: true,
    component: lazy(() => import('./components/Home')),
    requestAuth: false,
  },
  {
    path: '/profile',
    exact: true,
    component: lazy(() => import('./components/Profile')),
    requestAuth: false, // to develop navbar and home page // TODO: remove after dev
  },
];

export default routes;
