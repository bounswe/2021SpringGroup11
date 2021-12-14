import renderRoutes from './utils/renderRoutes';
import history from './utils/history';
import { Router } from 'react-router-dom';

import { Suspense } from 'react';
import { createTheme, LinearProgress, ThemeProvider } from '@mui/material';
import { Provider } from 'react-redux';
import store from './store';

const theme = createTheme();

export function App() {
  return (
    <Provider store={store}>
      <ThemeProvider theme={theme}>
        <Router history={history}>
          <Suspense fallback={<LinearProgress />}>{renderRoutes()}</Suspense>
        </Router>
      </ThemeProvider>
    </Provider>
  );
}
