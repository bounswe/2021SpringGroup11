import { getFakePaths, getFakeTopics } from './fakeData';
import { get } from '../../utils/axios';
import {
  GET_PATHS_BY_TOPIC_ID_URL,
  GET_RELATED_TOPICS_BY_TOPIC_ID_URL,
} from '../../utils/endpoints';

export interface IPath {
  ID: number;
  title: string;
  photo: string;
  effort: number;
  rating: number;
  isEnrolled: boolean;
  isFav: boolean;
}
export interface ITopic {
  ID: number;
  name: string;
  isFav: boolean;
}
export const getTopicDataByTopicID = async (topicID: number) => {
  // TODO ? backend endpoint ?
  //   const topic: ITopic[] = (await get(`${??? + topicID}/`)).data;
  const topic = getFakeTopics(1, { ID: topicID })[0];
  return topic;
};

export const getPathsByTopicID = async (topicID: number) => {
  // TODO :
  //   const paths: IPath[] = (await get(`${GET_PATHS_BY_TOPIC_ID_URL + topicID}/`)).data;

  const paths = getFakePaths(40);
  return paths;
};

export const getRelatedTopicsByTopicID = async (topicID: number) => {
  // TODO :
  //   const topics: ITopic[] = (await get(`${GET_RELATED_TOPICS_BY_TOPIC_ID_URL + topicID}/`)).data;

  const topics = getFakeTopics(12);
  return topics;
};
