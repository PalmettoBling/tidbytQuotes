load("render.star", "render")
load("http.star", "http")

quoteURL = "https://www.xboxplaydates.us/playdatesQuotes/randomquote"

def main():
    rep = http.get(quoteURL)
    if rep.status_code != 200:
        fail("Something happened trying to get the quote. %d", rep.status_code)
    
    quoteId = rep.json()["id"]
    quote = rep.json()["quote"]
    attribution = rep.json()["attribution"]
    game = rep.json()["game"]

    return render.Root(
        child = render.Column(
            expanded = False,
            children = [                
                render.Text(
                    #font = "tom-thumb",
                    content = ("# %s: " % quoteId),
                    color = "#099"
                ),
                render.Marquee(
                    width = 64,
                    height = 12,
                    child = render.WrappedText(
                        height = 16,
                        linespacing = -1,
                        content = ("%s" % quote),
                    ),
                ),
                render.Marquee(
                    width = 64,
                    offset_end = 0,
                    child = render.Text(
                        color = "#0a0",
                        content = ("-%s" % attribution),
                    ),
                )
            ]
        )
    )
    