import { get } from '../../utils/axios';
import { GET_USER_URL } from '../../utils/endpoints';

export const getProfileData = async (username: string) => {
  const profileData = (await get(GET_USER_URL + username + '/')).data;
  const user = {
    username: profileData.username,
    name: `${profileData.firstname} ${profileData.lastname}`,
    experience: 'GRANDMASTER',
    photo: `https://ui-avatars.com/api/?name=${profileData.firstname} ${profileData.lastname}background=0D8ABC&color=000`,
    bio: profileData.bio,
  };

  const resources = [
    {
      title: 'Tennis - Beginner',
      effort: 30,
      rating: 6.1,
      isEnrolled: true,
      isFollowed: false,
    },
    {
      title: 'Discovering the World',
      effort: 12,
      rating: 3.1,
      isEnrolled: false,
      isFollowed: true,
    },
    {
      title: 'Cooking the Best Pasta',
      effort: 3,
      rating: 6.4,
      isEnrolled: true,
      isFollowed: true,
    },
    {
      title: 'The essentials of',
      effort: 55,
      rating: 6.5,
      isEnrolled: false,
      isFollowed: true,
    },
    {
      title: 'The Best Version of Me',
      effort: 34,
      rating: 6.1,
      isEnrolled: true,
      isFollowed: true,
    },
    {
      title: 'Quantum Mechanics',
      effort: 33,
      rating: 3.5,
      isEnrolled: false,
      isFollowed: true,
    },
  ];
  const favorites = [
    { text: 'Tags', value: '5' },
    { text: 'Resources', value: '15' },
  ];
  const stats = [
    { text: 'Enrolled', value: '28' },
    { text: 'Done', value: '28' },
    { text: 'Followings', value: '145' },
    { text: 'Followers', value: '540' },
  ];

  return {
    resources,
    user,
    stats,
    favorites,
  };
};
