import os
from datetime import datetime
import feedparser

SOURCES = {
    "OpenAI Blog": "https://openai.com/blog/rss.xml",
    "Google AI Blog": "https://blog.google/technology/ai/rss/",
    "Anthropic News": "https://www.anthropic.com/news/rss.xml",
    "arXiv cs.AI": "https://export.arxiv.org/rss/cs.AI",
    "Hugging Face Blog": "https://huggingface.co/blog/feed.xml"
}

def main():
    today = datetime.now().strftime("%Y-%m-%d")
    out_dir = os.path.join(os.getcwd(), "ai_topic_library")
    os.makedirs(out_dir, exist_ok=True)
    out_file = os.path.join(out_dir, f"{today}.md")

    lines = [f"# AI题材库 - {today}", ""]
    for name, url in SOURCES.items():
        feed = feedparser.parse(url)
        lines.append(f"## {name}")
        if not feed.entries:
            lines.append("- 暂无抓取结果")
            lines.append("")
            continue
        for e in feed.entries[:5]:
            title = getattr(e, "title", "无标题").replace("\n", " ").strip()
            link = getattr(e, "link", "").strip()
            pub = getattr(e, "published", "").strip()
            lines.append(f"- {title} | {pub} | {link}")
        lines.append("")

    with open(out_file, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print(f"已生成: {out_file}")

if __name__ == "__main__":
    main()
