import { Redirect } from 'react-router-dom';
import React, { lazy, LazyExoticComponent } from 'react';
const routes: {
  path: string;
  // eslint-disable-next-line no-unused-vars,no-undef
  component: (() => JSX.Element) | LazyExoticComponent<(props: any) => JSX.Element>;
  exact: boolean;
  requestAuth: boolean;
}[] = [
  {
    path: '/',
    exact: true,
    // @ts-ignore
    component: () => <Redirect to="/home" />,
    requestAuth: false,
  },
  {
    path: '/login',
    exact: true,
    // @ts-ignore
    component: lazy(() => import('./components/Login')),
    requestAuth: false,
  },
  {
    path: '/signup',
    exact: true,
    // @ts-ignore
    component: lazy(() => import('./components/SignUp')),
    requestAuth: false,
  },
  {
    path: '/home',
    exact: true,
    // @ts-ignore
    component: lazy(() => import('./components/Home')),
    requestAuth: true, // TODO: remove after dev
  },
  {
    path: '/profile',
    exact: true,
    component: lazy(() => import('./components/Profile')),
    requestAuth: true,
  },
  {
    path: '/profile/:username',
    exact: true,
    component: lazy(() => import('./components/Profile')),
    requestAuth: true,
  },
  {
    path: '/topic/:topicID',
    exact: true,
    component: lazy(() => import('./components/Topic')),
    requestAuth: true,
  },
  {
    path: '/path/:pathId',
    exact: true,
    // @ts-ignore
    component: lazy(() => import('./components/Path')),
    requestAuth: true,
  },
];

export default routes;
