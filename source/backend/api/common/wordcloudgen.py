import wordcloud
import io

def wordcloudgen(text, labels, filename="wordcloud.png", width=600, height=400, maxfreq=True):
    wc=wordcloud.WordCloud(mode="RGBA", width=width, height=height, background_color=None, contour_width=1)

    words=wc.process_text(text)

    if not maxfreq:
        mean=sum([words[i] for i in words])/len(words)
        meansq=sum([words[i]**2 for i in words])/len(words)
        std=(meansq-mean**2)**.5
        weight=mean+STD_DEVS*std
    else:
        weight=max( [ words[i] for i in words ] )

    for i in labels:
        if not (i in words):
            words[i]=0
        words[i]+=weight

    wc.generate_from_frequencies(words)
    im=wc.to_image()
    buf=io.BytesIO()
    im.save(buf,format="PNG")
    imbytes=buf.getvalue()
    return imbytes