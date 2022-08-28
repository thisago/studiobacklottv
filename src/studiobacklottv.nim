import std/asyncdispatch
from std/httpclient import newHttpClient, getContent, close, newHttpHeaders
from std/strformat import fmt
from std/os import parentDir, execShellCmd, createDir, `/`
from std/uri import parseUri

import pkg/brightcove
from pkg/util/forStr import between

proc main(urls: seq[string]; download = false; curl = "curl"; output = "") =
  ## Get all raw URLs of the video of provided pages
  if urls.len == 0:
    quit "Provide the pages"
  if download and output.len == 0:
    quit "Provide the output"
  for url in urls:
    let
      client = newHttpClient()
      html = client.getContent url
    close client
    let
      accountId = html.between("//players.brightcove.net/", "/")
      videoId = html.between("data-video-id=\"", "\" data-format=\"")
      videoSrc = waitFor getVideoSrc(accountId, videoId)
  
      filename = output / parseUri(url).path & ".mp4"
    echo fmt"{url} - {videoSrc}"
    if download:
      createDir filename.parentDir
      if execShellCmd(fmt"""{curl} -o "{filename}" "{videoSrc}" """) != 0:
        quit "Error downloading, try again"

  
when isMainModule:
  import pkg/cligen
  dispatch main
