
#' Set credentials to be accessed by all functions
#'
#' @export
#'
#' @param client_id the client ID given from Spotify
#' @param client_secret the client secret ID given from Spotify
set_credentials <- function(client_id, client_secret, client_redirect_uri){
  # TODO: change to environment variables
  assign('client_id', client_id, envir = .GlobalEnv)
  assign('client_secret', client_secret, envir=.GlobalEnv)
  assign('client_redirect_uri', client_redirect_uri, envir=.GlobalEnv)
}


#' Get tokens for Client Credential
#' This function looks for client_id and client_secret in the global environment
#'
#' @export
#' @examples
#' get_tokens()
get_tokens <- function(){
  response <- POST(url = TOKENS_URL,
                   accept_json(),
                   authenticate(Sys.getenv('SPOTIFY_CLIENT'), Sys.getenv('SPOTIFY_SECRET')),
                   body = list(grant_type='client_credentials'),
                   encode = 'form')

  get_response_content(response)
}

#' Set tokens in global environment
#'
#' @export
#'
#' @examples
#' set_tokens()
set_tokens <- function() {
  tokens <- get_tokens()
  assign('access_token', tokens$access_token, envir = .GlobalEnv)
}

#' Authorize a user
#'
#' @param cache whether to cache the results
#'
#' @export
#'
#' @examples
#' set_tokens()
#' user_auth()
user_auth <- function(cache = TRUE) {

  set_tokens()

  # set dropbox oauth2 endpoints
  spotify <- httr::oauth_endpoint(
    authorize = AUTHORIZE_URL,
    access = TOKENS_URL
  )

  # registered dropbox app's key & secret
  spotify_app <- httr::oauth_app("spotifyr",
                                 Sys.getenv('SPOTIFY_CLIENT'),
                                 Sys.getenv('SPOTIFY_SECRET'))

  # get the token
  spotify_token <- httr::oauth2.0_token(
    endpoint = spotify,
    app = spotify_app,
    scope = ALL_SCOPES,
    cache = cache)
  spotify_token
  assign('user_token', spotify_token, envir = .GlobalEnv)
}


#' Get user code for Authorization Code user code
#' Lauches Selenium Webbrowser to handle process
#' This function looks for client_id and client_secret in the global environment
# get_user_code <- function(){
#
#   response <- GET(url=authorize_url,
#                   query=list(client_id=client_id,
#                              response_type='code',
#                              scope=all_scopes,
#                              redirect_uri='http://www.bertplot.com/visualization/'))
#
#   unlink(system.file("bin", package = "RSelenium"), recursive = T)
#   checkForServer()
#   startServer(log = FALSE, invisible = FALSE)
#
#   webd <- remoteDriver()
#   Sys.sleep(3)
#   # webd <- remoteDriver(remoteServerAddr = "localhost",browserName='chrome',port=4455)
#   x <- webd$open()
#   x <- webd$navigate(response$url)
#
#   ## Need to wait for next page
#   ## Probably a better way to do this.
#   while(str_detect(webd$getCurrentUrl()[[1]],'accounts.spotify.com')) Sys.sleep(2)
#
#   user_code <- str_split(webd$getCurrentUrl()[[1]],pattern='code=')[[1]][2]
#
#   # Close everything down
#   webd$closeWindow()
#   webd$closeServer()
#
#   user_code
# }

#' Using the user_code, generates tokens for user code
#'
#' @param user_code user_code from get_user_code() function
# get_user_token <- function(user_code){
#
#   response <- POST('https://accounts.spotify.com/api/token',
#                    accept_json(),
#                    authenticate(client_id,client_secret),
#                    body=list(grant_type='authorization_code',
#                              code=user_code,
#                              redirect_uri=client_redirect_uri),
#                    encode='form')
#
#   content <- get_response_content(response)
#
#   # Make accessible globally
#   assign('access_token', content$access_token,envir = .GlobalEnv)
#   assign('refresh_token', content$refresh_token,envir = .GlobalEnv)
#
#   content
# }

#' Refresh your tokens
#'
#' @param token default = NULL.  If no token is given, it will look for refresh_token in global environment
# refresh_user_token <- function(token=NULL){
#
#   if(is.null(token) && !exists('refresh_token')) stop("Need to provide refresh token")
#   if(is.null(token) && exists('refresh_token')) token <- refresh_token
#
#   response <- POST('https://accounts.spotify.com/api/token',
#                    accept_json(),
#                    authenticate(client_id,client_secret),
#                    body=list(grant_type='refresh_token',
#                              refresh_token=token,
#                              redirect_uri='http://www.bertplot.com/visualization/'),
#                    encode='form')
#
#   content <- get_response_content(response)
#
#   # Make accessible globally
#   assign('access_token',content$access_token,envir = .GlobalEnv)
#
#   content
# }
