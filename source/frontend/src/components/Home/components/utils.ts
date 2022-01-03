import { get, post } from '../../../utils/axios';
import { HOME_DATA_URL } from '../../../utils/endpoints';

// TODO!!
export const getHomeGETData = async () => {
  const userData = (await get(`${HOME_DATA_URL}`)).data;
  console.log('🚀 ~ file: utils.ts ~ line 9 ~ getHomeGETData ~ userData', userData);
  return userData as { efforts: unknown[]; rates: unknown[] };
};
// TODO!!
export const getHomePOSTData = async (data: any) => {
  const result = (await post(`${HOME_DATA_URL}`, data)).data;
  console.log('🚀 ~ file: utils.ts ~ line 14 ~ getHomePOSTData ~ result', result);
  return result;
};
