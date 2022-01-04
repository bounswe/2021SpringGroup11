import { get, post } from '../../../utils/axios';
import { HOME_DATA_URL } from '../../../utils/endpoints';

export const getHomeData = async (type: 'popular' | 'foryou' | 'new') => {
  const result = (await get(`${HOME_DATA_URL}${type}/`)).data;
  console.log('🚀 ~ file: utils.ts ~ line 14 ~ getHomePOSTData ~ result', type, result);
  return {
    tags: result.topics.map((t) => ({ name: t.name, id: t.ID })),
    paths: result.paths.map((p) => ({
      name: p.title,
      pic: p.photo,
      id: p._id,
      effort: p.effort,
      rating: p.rating,
    })),
  };
};
