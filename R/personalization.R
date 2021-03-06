#' Get a User’s Top Artists and Tracks
#' Get the current user’s top artists or tracks based on calculated affinity.
#'
#' @references \href{https://developer.spotify.com/web-api/get-users-top-artists-and-tracks/}{API documentation}
#'
#' @param type
#'
#' @export
#'
#' @examples
#' set_tokens()
#' user_auth()
#' get_user_top(type='artists')
#' get_user_top(type='tracks')
get_user_top <- function(type=c('artists', 'tracks'), ...){
  type <- match.arg(type)
  response <- httr::GET(url = glue('{TOP_URL}/{type}'),
                        config(token = user_token),
                        query = list(...))

  get_response_content(response)
}

#' Get Current User’s Recently Played Tracks
#' Get tracks from the current user’s recently played tracks.
#'
#' @references \href{https://developer.spotify.com/web-api/web-api-personalization-endpoints/get-recently-played/}{API documentation}
#'
#' @export
#'
#' @examples
#' set_tokens()
#' user_auth()
#' get_user_recently_played()
get_user_recently_played <- function(){
  response <- httr::GET(url = glue('{PLAYER_ENDPOINT}/recently-played'),
                        config(token = user_token))
  get_response_content(response)
}

