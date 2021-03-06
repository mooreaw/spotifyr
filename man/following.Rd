% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/follow.R
\name{following}
\alias{following}
\title{Check if Current User Follows Artists or Users
Check to see if the current user is following one or more artists or other Spotify users}
\usage{
following(ids, type = c("artist", "user"), ...)
}
\arguments{
\item{ids}{Optional. A comma-separated list of the artist or the user Spotify IDs.}

\item{type}{Required. The ID type: either artist or user.}
}
\description{
Check if Current User Follows Artists or Users
Check to see if the current user is following one or more artists or other Spotify users
}
\examples{
set_tokens()
user_auth()
following(ids=c('08td7MxkoHQkXnWAYD8d6Q', '74ASZWbe4lXaubB36ztrGX'), type='artist')
}
\references{
\href{https://developer.spotify.com/web-api/check-current-user-follows/}{API documentation}
}
