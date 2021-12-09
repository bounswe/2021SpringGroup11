import { get } from '../../utils/axios';
import { SEARCH_TOPIC_URL, SEARCH_USER_URL } from '../../utils/endpoints';
import faker from 'faker';
interface ISearchResult {
  type: 'user' | 'topic' | 'path';
}

interface IUserSearchResult extends ISearchResult {
  type: 'user';
  username: string;
  userImageURL: string;
}
interface ITopicSearchResult extends ISearchResult {
  type: 'topic';
  ID: number;
  name: string;
  isFav: boolean;
}

interface IPathSearchResult extends ISearchResult {
  type: 'path';
  ID: number;
  title: string;
  photo: string;
  effort: number;
  rating: number;
  isEnrolled: boolean;
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

const mocktopicdata: Omit<ITopicSearchResult, 'type'>[] = [];
for (let index = 0; index < 1000; index += 1) {
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

const mockpathdata: Omit<IPathSearchResult, 'type'>[] = [];
for (let index = 0; index < 1000; index += 1) {
  mockpathdata.push({
    ID: faker.datatype.number(),
    title: Math.random() < 0.5 ? faker.random.words(1) : faker.random.words(2),
    photo: faker.image.imageUrl(64, 64, undefined, true),
    effort: faker.datatype.number(10),
    rating: faker.datatype.number(10),
    isEnrolled: faker.datatype.boolean(),
    isFav: faker.datatype.boolean(),
  });
}

const searchPath = async ({ searchText }: { searchText: string }) => {
  // TODO backend connection
  //   const { data } = await get(`${SEARCH_PATH_URL + searchText.trim()}/`);
  //   console.log('🚀 ~ file: search.util.ts ~ line 13 ~ searchPath ~ data', data);

  const data = mockpathdata.filter((d) => d.title.includes(searchText));
  return data.map((t) => ({ ...t, type: 'path' })) as IPathSearchResult[];
};

const search = async ({ searchText }: { searchText: string }): Promise<ISearchResult[]> => {
  const users = await searchUser({ searchText: searchText.trim() });
  const topics = await searchTopic({ searchText: searchText.trim() });
  const paths = await searchPath({ searchText: searchText.trim() });

  return [].concat(users).concat(topics).concat(paths);
};

export {
  searchUser,
  searchTopic,
  searchPath,
  search,
  ITopicSearchResult,
  ISearchResult,
  IUserSearchResult,
  IPathSearchResult,
};
