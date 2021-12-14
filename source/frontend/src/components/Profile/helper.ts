import { get, post } from '../../utils/axios';
import {
  EDIT_USER_URL,
  GET_ENROLLED_PATHS_URL,
  GET_FOLLOWED_PATHS_URL,
  GET_USER_URL,
} from '../../utils/endpoints';

export const getUserData = async (username: string) => {
  const userData = (await get(`${GET_USER_URL + username}/`)).data;
  return userData;
};

export const getUserEnrolledData = async (username: string) => {
  const { data } = await post(`${GET_ENROLLED_PATHS_URL}`, { username });
  return data;
};
export const getUserFavPathsData = async (username: string) => {
  const { data } = await post(`${GET_FOLLOWED_PATHS_URL}`, { username });
  return data;
};

export const updateUserData = async (data: any) => {
  const result = (await post(`${EDIT_USER_URL}`, data)).data;
  console.log('🚀 ~ file: helper.ts ~ line 10 ~ updateUserData ~ result', result);
  return result;
};

export const getProfileData = async (username: string) => {
  const profileData = await getUserData(username);
  console.log('🚀 ~ file: helper.ts ~ line 6 ~ getProfileData ~ profileData', profileData);

  const enrolledpathsIDs: {
    effort: number;
    isFollowed: boolean;
    photo: string;
    rating: number;
    title: string;
    _id: string;
  }[] = await getUserEnrolledData(username);
  const favpathsIDs: {
    effort: number;
    isEnrolled: boolean;
    photo: string;
    rating: number;
    title: string;
    _id: string;
  }[] = await getUserFavPathsData(username);
  console.log('getUserEnrolledData:', enrolledpathsIDs);

  const user = {
    username: profileData.username,
    name: `${profileData.firstname} ${profileData.lastname}`,
    experience: 'GRANDMASTER',
    photo:
      profileData.photo ??
      `https://ui-avatars.com/api/?name=${profileData.firstname} ${profileData.lastname}background=0D8ABC&color=000`,
    bio: profileData.bio,
  };

  const resources = []
    .concat(enrolledpathsIDs.map((s) => ({ ...s, isEnrolled: true })))
    .concat(favpathsIDs.map((s) => ({ ...s, isFollowed: true })));
  const favorites = [
    { text: 'Topics', value: '126' },
    { text: 'Paths', value: favpathsIDs.length },
  ];
  const stats = [
    { text: 'Enrolled', value: '145' },
    { text: 'Done', value: '103' },
    { text: 'Followings', value: '254' },
    { text: 'Followers', value: '645' },
  ];

  return {
    resources,
    user,
    stats,
    favorites,
  };
};
