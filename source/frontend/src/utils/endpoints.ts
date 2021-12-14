const baseUrl = 'http://35.209.23.51/';

export const LOGIN_URL = `${baseUrl}authentication/login/`;
export const SIGNUP_URL = `${baseUrl}authentication/signup/`;
export const FORGOT_PASSWORD_URL = `${baseUrl}authentication/forgot-password/`;
export const REFRESH_TOKEN_URL = `${baseUrl}authentication/refresh-token/`;

export const GET_USER_URL = `${baseUrl}user/get-profile/`; /// /get-profile/<username>
export const SEARCH_USER_URL = `${baseUrl}user/search-user/`; // /search-user/<search_text>
export const FOLLOW_USER_URL = `${baseUrl}user/follow-user/`; //
export const UNFOLLOW_USER_URL = `${baseUrl}user/unfollow-user/`; //
export const FOLLOWINGS_USER_URL = `${baseUrl}user/get-follow/`; //
export const RATINGS_USER_URL = `${baseUrl}user/get-ratings/`; //
export const ENROLLS_USER_URL = `${baseUrl}user/get-enrolls/`; //
export const FAV_PATH_USER_URL = `${baseUrl}user/get-favourite-paths/`; //
export const WORDCLOUD_USER_URL = `${baseUrl}user/wordcloud/`; //
export const EDIT_USER_URL = `${baseUrl}user/edit-user/`;
export const BAN_USER_URL = `${baseUrl}user/ban-user/`;

export const SEARCH_TOPIC_URL = `${baseUrl}topic/search-topic/`; // /search-topic/<search_text>
export const GET_RELATED_TOPICS_BY_TOPIC_ID_URL = `${baseUrl}topic/related-topic/`; // /related-topic/<topic:int>
export const GET_TOPIC_BY_TOPIC_ID_URL = `${baseUrl}topic/get-topic/`; //
export const FAV_TOPIC_URL = `${baseUrl}topic/favorite-topic/`; //
export const UNFAV_TOPIC_URL = `${baseUrl}topic/unfavorite-topic/`; //

export const GET_PATH_URL = `${baseUrl}path/get-path/`;
export const ENROLL_PATH_URL = `${baseUrl}path/enroll-path/`;
export const SEARCH_PATH_URL = `${baseUrl}path/search-path/`; // /search-path/<search_text>
export const GET_PATHS_BY_TOPIC_ID_URL = `${baseUrl}path/related-path/`; /// /path/related-path/<topic:int> Wikidata tag number
export const GET_ENROLLED_PATHS_URL = `${baseUrl}path/get-enrolled-paths/`; ///
export const GET_FOLLOWED_PATHS_URL = `${baseUrl}path/get-followed-paths/`; ///
export const SEARCHPATH_URL = `${baseUrl}path/search-path/`; ///
export const GET_PATH_URL = `${baseUrl}path/get-path/`; /// path/ get-path/<slug:path_id>/ [name='get_path']
export const WORDCLOUD_PATHS_URL = `${baseUrl}path/wordcloud/`; /// POST
export const GET_PATH_DETAIL_URL = `${baseUrl}path/get-path-detail/`; ///
