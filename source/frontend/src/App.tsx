import renderRoutes from './utils/renderRoutes';
import history from './utils/history';
import routes from './routes';
import { Router } from 'react-router-dom';
import { Suspense } from 'react';
import { LinearProgress } from '@mui/material';
import { Provider } from 'react-redux';
import store from './store';

export function App() {
  return (
    <Provider store={store}>
      <Router history={history}>
        <Suspense fallback={<LinearProgress />}>{renderRoutes()}</Suspense>
      </Router>
    </Provider>
  );
}
