import std/asyncdispatch
from std/httpclient import newHttpClient, getContent, close, newHttpHeaders
from std/strformat import fmt

import pkg/brightcove
from pkg/util/forStr import between

proc main(urls: seq[string]) =
  ## Get all raw URLs of the video of provided pages
  if urls.len == 0:
    quit "Provide the pages"
  for url in urls:
    let
      client = newHttpClient()
      html = client.getContent url
    close client
    let
      accountId = html.between("//players.brightcove.net/", "/")
      videoId = html.between("data-video-id=\"", "\" data-format=\"")
      videoSrc = waitFor getVideoSrc(accountId, videoId)
    echo fmt"{url} - {videoSrc}"
  
when isMainModule:
  import pkg/cligen
  dispatch main
