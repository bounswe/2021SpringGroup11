const baseUrl = 'http://35.209.23.51/';

export const LOGIN_URL = `${baseUrl}authentication/login/`;
export const SIGNUP_URL = `${baseUrl}authentication/signup/`;
export const FORGOT_PASSWORD_URL = `${baseUrl}authentication/forgot-password/`;
export const REFRESH_TOKEN_URL = `${baseUrl}authentication/refresh-token/`;

export const GET_USER_URL = `${baseUrl}user/get-profile/`; /// /get-profile/<username>
export const SEARCH_USER_URL = `${baseUrl}user/search-user/`; // /search-user/<search_text>
export const EDIT_USER_URL = `${baseUrl}user/edit-user/`;
export const BAN_USER_URL = `${baseUrl}user/ban-user/`;

export const SEARCH_TOPIC_URL = `${baseUrl}topic/search-topic/`; // /search-topic/<search_text>
export const SEARCH_PATH_URL = `${baseUrl}topic/search-path/`; // /search-path/<search_text>
export const GET_RELATED_TOPICS_BY_TOPIC_ID_URL = `${baseUrl}topic/related-topic/`; // /related-topic/<topic:int>

export const GET_PATHS_BY_TOPIC_ID_URL = `${baseUrl}path/related-path/`; /// /path/related-path/<topic:int> Wikidata tag number
