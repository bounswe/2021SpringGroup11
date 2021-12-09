import { get } from '../../utils/axios';
import { SEARCH_TOPIC_URL, SEARCH_USER_URL } from '../../utils/endpoints';
import faker from 'faker';
interface ISearchResult {
  type: 'user' | 'topic';
}

interface IUserSearchResult extends ISearchResult {
  username: string;
  userImageURL: string;
}
interface ITopicSearchResult extends ISearchResult {
  ID: number;
  name: string;
  isFav: boolean;
}

const searchUser = async ({ searchText }: { searchText: string }) => {
  const { data } = await get(`${SEARCH_USER_URL + searchText.trim()}/`);
  console.log('🚀 ~ file: search.util.ts ~ line 10 ~ searchUser ~ data', data);

  return data.map((u) => ({
    ...u,
    userImageURL: faker.image.imageUrl(64, 64, undefined, true),
    type: 'user',
  })) as IUserSearchResult[];
};

const mocktopicdata = [];
for (let index = 0; index < 10000; index += 1) {
  mocktopicdata.push({
    ID: faker.datatype.number(),
    name: Math.random() < 0.5 ? faker.random.words(1) : faker.random.words(2),
    isFav: faker.datatype.boolean(),
  });
}

const searchTopic = async ({ searchText }: { searchText: string }) => {
  // TODO backend connection
  //   const { data } = await get(`${SEARCH_TOPIC_URL + searchText.trim()}/`);
  //   console.log('🚀 ~ file: search.util.ts ~ line 13 ~ searchTopic ~ data', data);

  const data = mocktopicdata.filter((d) => d.name.includes(searchText));
  return data.map((t) => ({ ...t, type: 'topic' })) as ITopicSearchResult[];
};

const search = async ({ searchText }: { searchText: string }): Promise<ISearchResult[]> => {
  const users = await searchUser({ searchText: searchText.trim() });
  const topics = await searchTopic({ searchText: searchText.trim() });

  return [].concat(users).concat(topics);
};

export { searchUser, searchTopic, search, ITopicSearchResult, ISearchResult, IUserSearchResult };
