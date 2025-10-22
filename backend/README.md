# Smart Tips Backend - FastAPI

## Setup

1. Install dependencies:
   
   ```bash
   pip install -r requirements.txt
   ```

2. Set your Bing Web Search API key (get one from https://www.microsoft.com/en-us/bing/apis/bing-web-search-api):
   
   ```bash
   export BING_API_KEY=your_bing_api_key_here
   ```

3. Run the server:
   
   ```bash
   uvicorn main:app --reload --host 0.0.0.0 --port 8000
   ```

## Usage

POST to `/search` with JSON body:

```
{
  "question": "How do I prevent Newcastle disease in chickens?"
}
```

Response:
```
{
  "answer": "...best snippet from Bing..."
}
```

## Notes
- You can use any web search API (Bing, SerpAPI, etc). This example uses Bing.
- CORS is enabled for all origins for easy Flutter integration.
