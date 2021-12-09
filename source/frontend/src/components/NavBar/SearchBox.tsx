/* eslint-disable jsx-a11y/alt-text */
/* eslint-disable jsx-a11y/no-static-element-interactions */
/* eslint-disable jsx-a11y/click-events-have-key-events */
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
import {
  IPathSearchResult,
  ISearchResult,
  ITopicSearchResult,
  IUserSearchResult,
  search,
  searchTopic,
  searchUser,
} from './search.util';

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

  const [searchResults, setSearchResults] = useState<null | ISearchResult[]>(null);
  useEffect(() => {
    (async () => {
      setSearchResults(null);
      if (searchText.trim()) {
        const results = await search({ searchText: searchText.trim() });
        setSearchResults(results);
      }
    })();
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
                  if (searchItem.type === 'user') {
                    const userSearchItem = searchItem as IUserSearchResult;
                    return (
                      <div
                        onClick={() => {
                          history.push(`/profile/${userSearchItem.username}`);
                          setSearchText('');
                        }}
                        style={{ display: 'flex', flexDirection: 'row' }}
                      >
                        <img
                          style={{
                            height: '100%',
                          }}
                          src={`${userSearchItem.userImageURL}`}
                        />

                        <h2>{userSearchItem.username}</h2>
                      </div>
                    );
                  }
                  if (searchItem.type === 'topic') {
                    const topicSearchItem = searchItem as ITopicSearchResult;

                    return (
                      <div
                        onClick={() => {
                          history.push(`/topic/${topicSearchItem.ID}`);
                          setSearchText('');
                        }}
                        style={{ display: 'flex', flexDirection: 'row' }}
                      >
                        <h2>#{topicSearchItem.name}</h2>
                      </div>
                    );
                  }
                  if (searchItem.type === 'path') {
                    const pathSearchItem = searchItem as IPathSearchResult;

                    return (
                      <div
                        onClick={() => {
                          history.push(`/topic/${pathSearchItem.ID}`);
                          setSearchText('');
                        }}
                        style={{ display: 'flex', flexDirection: 'row' }}
                      >
                        {' '}
                        <img
                          style={{
                            height: '100%',
                          }}
                          src={`${pathSearchItem.photo}`}
                        />
                        <div style={{ height: '100%', display: 'flex', flexDirection: 'column' }}>
                          <h2>{pathSearchItem.title}</h2>
                          <h5>
                            Rating:{pathSearchItem.rating}
                            Effort:{pathSearchItem.effort}
                          </h5>
                        </div>
                      </div>
                    );
                  }
                  return <></>;
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
