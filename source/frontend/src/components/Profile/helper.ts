export const getProfileData = () => {
  // TODO: fetch data from API
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
  const user = {
    username: '@meltemarslan',
    name: 'MELTEM ARSLAN',
    experience: 'GRANDMASTER',
    photo: 'https://picsum.photos/200/200?random=1',
    bio: 'Hi there! I am Meltem, a computer engineering student at Boğaziçi University. I love doing sports, cooking, traveling. If you would like to, we may enjoy these things together.',
  };

  return {
    resources,
    user,
    stats,
    favorites,
  };
};
