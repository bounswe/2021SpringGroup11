import { Router } from 'react-router-dom';
import React, { Suspense } from 'react';
import { createTheme, LinearProgress, ThemeProvider } from '@mui/material';
import { Provider } from 'react-redux';
import 'react-toastify/dist/ReactToastify.css';
import { ToastContainer } from 'react-toastify';
import store from './store';
import renderRoutes from './utils/renderRoutes';
import history from './utils/history';

const theme = createTheme();

export function App() {
  return (
    <Provider store={store}>
      <ThemeProvider theme={theme}>
        <Router history={history}>
          <Suspense fallback={<LinearProgress />}>{renderRoutes()}</Suspense>
        </Router>
        <ToastContainer limit={5} />
      </ThemeProvider>
    </Provider>
  );
}
