/* eslint-disable jsx-a11y/alt-text */
/* eslint-disable jsx-a11y/no-static-element-interactions */
/* eslint-disable jsx-a11y/click-events-have-key-events */

import React, { useEffect, useRef, useState } from 'react';
// import ExploreIcon from '@mui/icons-material/Explore';
// import NotificationsIcon from '@mui/icons-material/Notifications';
import SearchIcon from '@mui/icons-material/Search';
// import SettingsIcon from '@mui/icons-material/Settings';
import { alpha, Box, CircularProgress, InputBase, styled } from '@mui/material';
import faker from 'faker';
import history from '../../utils/history';

// import { get } from '../../utils/axios';
// import { SEARCH_USER_URL } from '../../utils/endpoints';
import {
  IPathSearchResult,
  ISearchResult,
  ITopicSearchResult,
  IUserSearchResult,
  search,
} from './search.util';
import { getPathPhotoData } from '../Profile/helper';

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

const SearchBox = () => {
  const [searchText, setSearchText] = useState('');
  const timeref = useRef(new Date().valueOf());
  const [searchResults, setSearchResults] = useState<null | ISearchResult[]>(null);
  useEffect(() => {
    (async () => {
      setSearchResults(null);
      if (searchText.trim()) {
        timeref.current = new Date().valueOf();
        const ydk = timeref.current;
        const results = await search({ searchText: searchText.trim() });
        if (ydk === timeref.current) {
          setSearchResults(results);
        }
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
        <div style={{ position: 'relative', overflowWrap: 'anywhere' }}>
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
                        style={{
                          display: 'flex',
                          flexDirection: 'row',
                          background: 'blue',
                          margin: '1rem',
                          borderStyle: 'double',
                          borderRadius: '5px',
                        }}
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
                          history.push(`/topic/${topicSearchItem.id}`);
                          setSearchText('');
                        }}
                        style={{
                          display: 'flex',
                          flexDirection: 'column',
                          background: 'purple',
                          margin: '1rem',
                          borderStyle: 'double',
                          borderRadius: '5px',
                        }}
                      >
                        <h2>#{topicSearchItem.name}</h2>
                        <h5>{topicSearchItem.description}</h5>
                      </div>
                    );
                  }
                  if (searchItem.type === 'path') {
                    const pathSearchItem = searchItem as IPathSearchResult;

                    return (
                      <div
                        onClick={() => {
                          history.push(`/path/${pathSearchItem._id}`);
                          setSearchText('');
                        }}
                        style={{
                          display: 'flex',
                          flexDirection: 'row',
                          background: 'green',
                          margin: '1rem',
                          borderStyle: 'double',
                          borderRadius: '5px',
                        }}
                      >
                        {' '}
                        <WordCloudImg id={pathSearchItem._id} photo={`${pathSearchItem.photo}`} />
                        <div style={{ height: '100%', display: 'flex', flexDirection: 'column' }}>
                          <h3>{pathSearchItem.title}</h3>
                          <br />
                          <h5>{pathSearchItem.description}</h5>
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

interface Props {
  id: any;
  photo: any;
}

const WordCloudImg = ({ id, photo }: Props) => {
  const [img, setimg] = useState('https://c.tenor.com/I6kN-6X7nhAAAAAj/loading-buffering.gif');
  useEffect(() => {
    (async () => {
      if (photo) {
        setimg((photo.startsWith('data') ? '' : 'data:image/png;base64,') + photo);

        setimg(`data:image/png;base64,${photo}`);
      } else {
        try {
          const wc = await getPathPhotoData(id);
          setimg((wc.startsWith('data') ? '' : 'data:image/png;base64,') + wc);
        } catch (error) {
          setimg(faker.image.imageUrl(64, 64, undefined, true));
        }
      }
    })();
  }, []);
  return (
    <img
      style={{
        height: '64px',
        width: '64px',
      }}
      src={`${img}`}
    />
  );
};

export default SearchBox;
