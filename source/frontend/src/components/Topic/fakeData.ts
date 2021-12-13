import faker from 'faker';
import { ITopic, IPath } from './helper';

export const getFakeTopics = (count = 1000, fixedValues: Partial<ITopic> = {}) => {
  const mocktopicdata: ITopic[] = [];
  for (let index = 0; index < count; index += 1) {
    mocktopicdata.push({
      id: faker.datatype.number(),
      name: Math.random() < 0.5 ? faker.random.words(1) : faker.random.words(2),
      isFav: faker.datatype.boolean(),
      description: faker.lorem.paragraph(),
      ...fixedValues,
    });
  }
  return mocktopicdata;
};

export const getFakePaths = (count = 1000, fixedValues: Partial<ITopic> = {}) => {
  const mockpathdata: IPath[] = [];
  for (let index = 0; index < count; index += 1) {
    mockpathdata.push({
      _id: faker.datatype.number(),
      title: Math.random() < 0.5 ? faker.random.words(3) : faker.random.words(5),
      photo: faker.image.imageUrl(64, 64, undefined, true),
      effort: faker.datatype.number(10),
      rating: faker.datatype.number(10),
      isEnrolled: faker.datatype.boolean(),
      isFav: faker.datatype.boolean(),
      description: faker.lorem.paragraph(),
      created_at: faker.datatype.number(10),
      creator_username: faker.datatype.string(10),
      isFollowed: faker.datatype.boolean(),
      is_banned: false,
      is_deleted: false,
      milestones: [],
      topics: [],
      ...fixedValues,
    });
  }
  return mockpathdata;
};
