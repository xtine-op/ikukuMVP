from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import httpx
import os

app = FastAPI()

# Allow CORS for Flutter
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class SearchRequest(BaseModel):
    question: str

class SearchResponse(BaseModel):
    answer: str


# Use SerpAPI (Google) for web search
SERPAPI_KEY = os.getenv("SERPAPI_KEY")
SERPAPI_URL = "https://serpapi.com/search.json"

async def serpapi_search(query: str) -> str:
    if not SERPAPI_KEY:
        return "SerpAPI key not set. Set SERPAPI_KEY env variable."
    params = {
        "q": query,
        "api_key": SERPAPI_KEY,
        "engine": "google",
        "num": 3,
        "hl": "en"
    }
    async with httpx.AsyncClient() as client:
        resp = await client.get(SERPAPI_URL, params=params)
        data = resp.json()
        # Try to extract the best and most comprehensive content
        answer_parts = []
        if "answer_box" in data and "answer" in data["answer_box"]:
            answer_parts.append(str(data["answer_box"]["answer"]))
        if "organic_results" in data:
            for result in data["organic_results"][:5]:
                # Prefer rich_snippet or full snippet if available
                snippet = result.get("rich_snippet") or result.get("snippet")
                if snippet:
                    # If snippet is a dict, join all values
                    if isinstance(snippet, dict):
                        snippet = ' '.join(str(v) for v in snippet.values())
                    answer_parts.append(snippet)
        # Remove any ellipsis at the end of snippets
        answer = '\n'.join([part.rstrip(' .…') for part in answer_parts if part])
        if answer:
            return answer
        return "No relevant answer found."

@app.post("/search", response_model=SearchResponse)
async def search(request: SearchRequest):
    answer = await serpapi_search(request.question)
    return {"answer": answer}
