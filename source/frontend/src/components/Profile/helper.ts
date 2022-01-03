import { get, post } from '../../utils/axios';
import {
  EDIT_USER_URL,
  FOLLOW_USER_URL,
  GETFOLLOW_USER_URL,
  GET_ENROLLED_PATHS_URL,
  GET_FOLLOWED_PATHS_URL,
  GET_USER_URL,
  UNFOLLOW_USER_URL,
  WORDCLOUD_PATHS_URL,
} from '../../utils/endpoints';

export const getUserData = async (username: string) => {
  const userData = (await get(`${GET_USER_URL + username}/`)).data;
  return userData;
};
export const getUserFollowData = async () => {
  const userData = (await get(`${GETFOLLOW_USER_URL}`)).data;
  return userData as { followed: string[]; followers: string[] };
};

export const followUser = async (username: string) => {
  const { data } = await post(`${FOLLOW_USER_URL}`, { target: username });
  return data;
};
export const unfollowUser = async (username: string) => {
  const { data } = await post(`${UNFOLLOW_USER_URL}`, { target: username });
  return data;
};

export const getUserEnrolledData = async (username: string) => {
  const { data } = await post(`${GET_ENROLLED_PATHS_URL}`, { username });
  return data;
};
export const getUserFavPathsData = async (username: string) => {
  const { data } = await post(`${GET_FOLLOWED_PATHS_URL}`, { username });
  return data;
};
export const getPathPhotoData = async (pathId: string) => {
  const { data } = await post(`${WORDCLOUD_PATHS_URL}`, { pathId });
  // console.log('🚀 ~ file: helper.ts ~ line 25 ~ getPathPhotoData ~ data', data);

  return data;
};

export const updateUserData = async (data: any) => {
  const result = (await post(`${EDIT_USER_URL}`, data)).data;
  console.log('🚀 ~ file: helper.ts ~ line 10 ~ updateUserData ~ result', result);
  return result;
};

export const getProfileData = async (username: string) => {
  const profileDataPromise = getUserData(username);

  const enrolledpathsIDsPromise: Promise<
    {
      effort: number;
      isFollowed: boolean;
      photo: string;
      rating: number;
      title: string;
      _id: string;
    }[]
  > = getUserEnrolledData(username);
  const favpathsIDsPromise: Promise<
    {
      effort: number;
      isEnrolled: boolean;
      photo: string;
      rating: number;
      title: string;
      _id: string;
    }[]
  > = getUserFavPathsData(username);

  const [profileData, enrolledpathsIDs, favpathsIDs, UserFollowData] = await Promise.all([
    profileDataPromise,
    enrolledpathsIDsPromise,
    favpathsIDsPromise,
    getUserFollowData(),
  ]);
  console.log('🚀 ~ file: helper.ts ~ line 6 ~ getProfileData ~ profileData', profileData);

  console.log('getUserEnrolledData:', enrolledpathsIDs);
  const followings = UserFollowData.followed;
  const { followers } = UserFollowData;

  const user = {
    username: profileData.username,
    name: `${profileData.firstname} ${profileData.lastname}`,
    experience: 'GRANDMASTER',
    photo:
      profileData.photo ??
      `https://ui-avatars.com/api/?name=${profileData.firstname} ${profileData.lastname}background=0D8ABC&color=000`,
    bio: profileData.bio,
  };

  // @ts-ignore
  const resources = []
    // @ts-ignore
    .concat(enrolledpathsIDs.map((s) => ({ ...s, isEnrolled: true })))
    // @ts-ignore
    .concat(favpathsIDs.map((s) => ({ ...s, isFollowed: true })));
  const favorites = [
    { text: 'Topics', value: '126' },
    { text: 'Paths', value: favpathsIDs.length },
  ];
  const stats = [
    { text: 'Enrolled', value: enrolledpathsIDs.length },
    { text: 'Done', value: '103' },
    { text: 'Followings', value: followings.length },
    { text: 'Followers', value: followers.length },
  ];

  return {
    resources,
    user,
    stats,
    favorites,
    followers,
    followings,
  };
};
