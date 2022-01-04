// import { getFakePaths, getFakeTopics } from './fakeData';
import { get, post } from '../../utils/axios';
import {
  FAV_TOPIC_URL,
  GET_PATHS_BY_TOPIC_ID_URL,
  GET_RELATED_TOPICS_BY_TOPIC_ID_URL,
  GET_TOPIC_BY_TOPIC_ID_URL,
  UNFAV_TOPIC_URL,
} from '../../utils/endpoints';

export interface IPath {
  _id: number;
  title: string;
  photo: string;
  effort: number;
  rating: number;
  isEnrolled: boolean;
  isFav: boolean;
  created_at: number;
  creator_username: string;
  description: string;
  isFollowed: boolean;
  is_banned: boolean;
  is_deleted: boolean;
  milestones: unknown[];
  topics: unknown[];
}
export interface ITopic {
  id: number;
  name: string;
  isFav: boolean;
  description: string;
}
export const getTopicDataByTopicID = async (topicID: number) => {
  // TODO ? backend endpoint ?
  const topic = (await get(`${GET_TOPIC_BY_TOPIC_ID_URL + topicID}/`)).data;
  console.log('🚀 ~ file: helper.ts ~ line 37 ~ getTopicDataByTopicID ~ topic', topic);
  // const topic = getFakeTopics(1, { id: topicID })[0];
  return { ...topic, id: topic.ID } as ITopic;
};

export const getPathsByTopicID = async (topicID: number) => {
  // TODO :
  const paths: IPath[] = (await get(`${GET_PATHS_BY_TOPIC_ID_URL + topicID}/`)).data;
  console.log('🚀 ~ file: helper.ts ~ line 41 ~ getPathsByTopicID ~ paths', paths);

  // const paths = getFakePaths(40);
  return paths;
};

export const getRelatedTopicsByTopicID = async (topicID: number) => {
  // TODO :
  const topics = (await get(`${GET_RELATED_TOPICS_BY_TOPIC_ID_URL + topicID}/`)).data;

  // const topics = getFakeTopics(12);
  console.log('🚀 ~ file: helper.ts ~ line 49 ~ getRelatedTopicsByTopicID ~ topics', topics);

  return topics.map((t) => ({ ...t, id: t.ID })) as ITopic[];
};

export const updateFavTopic = async (topicID: number, newState: boolean) => {
  const result = (await post(`${newState ? FAV_TOPIC_URL : UNFAV_TOPIC_URL}`, { ID: topicID }))
    .data;
  console.log('🚀 ~ file: helper.ts ~ line 63 ~ updateFavTopic ~ result', result);

  return result;
};
