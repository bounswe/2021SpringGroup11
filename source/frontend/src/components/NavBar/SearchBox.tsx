import React, { useEffect, useState } from 'react';
import ExploreIcon from '@mui/icons-material/Explore';
import NotificationsIcon from '@mui/icons-material/Notifications';
import SearchIcon from '@mui/icons-material/Search';
import SettingsIcon from '@mui/icons-material/Settings';
import history from '../../utils/history';

import {
  alpha,
  AppBar,
  Badge,
  Box,
  CircularProgress,
  IconButton,
  InputBase,
  Menu,
  MenuItem,
  styled,
  Toolbar,
  Typography,
} from '@mui/material';
import { get } from '../../utils/axios';
import { SEARCH_USER_URL } from '../../utils/endpoints';

const Search = styled('div')(({ theme }) => ({
  position: 'relative',
  borderRadius: theme.shape.borderRadius,
  backgroundColor: alpha(theme.palette.common.white, 0.15),
  '&:hover': {
    backgroundColor: alpha(theme.palette.common.white, 0.25),
  },
  width: '100%',
  [theme.breakpoints.up('sm')]: {
    marginLeft: theme.spacing(3),
    width: 'auto',
  },
}));

const SearchIconWrapper = styled('div')(({ theme }) => ({
  padding: theme.spacing(0, 2),
  height: '100%',
  position: 'absolute',
  pointerEvents: 'none',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
}));

const StyledInputBase = styled(InputBase)(({ theme }) => ({
  color: 'inherit',
  '& .MuiInputBase-input': {
    padding: theme.spacing(1, 1, 1, 0),
    // vertical padding + font size from searchIcon
    paddingLeft: `calc(1em + ${theme.spacing(4)})`,
    transition: theme.transitions.create('width'),
    width: '100%',
    [theme.breakpoints.up('md')]: {
      width: '20ch',
    },
  },
}));
interface Props {}

const SearchBox = (props: Props) => {
  const [searchText, setSearchText] = useState('');

  const [searchResults, setSearchResults] = useState<null | { username: string }[]>(null);
  useEffect(() => {
    setSearchResults(null);
    if (searchText.trim()) {
      //TODO: fetch search results
      get(SEARCH_USER_URL + searchText.trim() + '/').then(({ data }) => {
        console.log('🚀 ~ file: SearchBox.tsx ~ line 89 ~ get ~ res', data);
        setSearchResults(data);
      });
    }
  }, [searchText]);

  const [placeholder, setplaceholder] = useState('Search');
  const onSearchBoxFocus = () => {
    setplaceholder('username to search');
  };
  const onSearchBoxBlur = () => {
    setplaceholder('Search');
  };

  return (
    <Search sx={{ maxWidth: '40em' }}>
      <SearchIconWrapper>
        <SearchIcon />
      </SearchIconWrapper>
      <StyledInputBase
        value={searchText}
        onChange={(e) => {
          setSearchText(e.target.value);
        }}
        onFocus={onSearchBoxFocus}
        onBlur={onSearchBoxBlur}
        placeholder={placeholder}
        inputProps={{ 'aria-label': 'search' }}
      />
      {searchText.trim() && (
        <div style={{ position: 'relative' }}>
          <div style={{ position: 'absolute', zIndex: 9, background: 'gray', width: '100%' }}>
            {searchResults ? (
              <>
                {searchResults.map((searchItem) => {
                  return (
                    <div
                      onClick={() => {
                        history.push(`/profile/${searchItem.username}`);
                        setSearchText('');
                      }}
                      style={{ display: 'flex', flexDirection: 'row' }}
                    >
                      <img
                        style={{
                          height: '100%',
                        }}
                        src={`https://ui-avatars.com/api/?name=${searchItem.username}&background=0D8ABC&color=fff`}
                      />

                      <h2>{searchItem.username}</h2>
                    </div>
                  );
                })}
              </>
            ) : (
              <Box
                sx={{
                  display: 'flex',
                  justifyContent: 'center',
                  alignItems: 'center',
                }}
              >
                <CircularProgress />
              </Box>
            )}
          </div>
        </div>
      )}
    </Search>
  );
};

export default SearchBox;
