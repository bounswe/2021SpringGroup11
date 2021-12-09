import faker from 'faker';
import { get } from '../../utils/axios';
import { SEARCH_TOPIC_URL, SEARCH_USER_URL, SEARCH_PATH_URL } from '../../utils/endpoints';
import { getFakePaths, getFakeTopics } from '../Topic/fakeData';
import { IPath, ITopic } from '../Topic/helper';
interface ISearchResult {
  type: 'user' | 'topic' | 'path';
}

interface IUserSearchResult extends ISearchResult {
  type: 'user';
  username: string;
  userImageURL: string;
}
interface ITopicSearchResult extends ISearchResult, ITopic {
  type: 'topic';
}

interface IPathSearchResult extends ISearchResult, IPath {
  type: 'path';
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

const searchTopic = async ({ searchText }: { searchText: string }) => {
  // TODO backend connection
  //   const { data } = await get(`${SEARCH_TOPIC_URL + searchText.trim()}/`);
  //   console.log('🚀 ~ file: search.util.ts ~ line 13 ~ searchTopic ~ data', data);

  const data = getFakeTopics().filter((d) => d.name.includes(searchText));
  return data.map((t) => ({ ...t, type: 'topic' })) as ITopicSearchResult[];
};

const searchPath = async ({ searchText }: { searchText: string }) => {
  // TODO backend connection
  //   const { data } = await get(`${SEARCH_PATH_URL + searchText.trim()}/`);
  //   console.log('🚀 ~ file: search.util.ts ~ line 13 ~ searchPath ~ data', data);

  const data = getFakePaths().filter((d) => d.title.includes(searchText));
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
