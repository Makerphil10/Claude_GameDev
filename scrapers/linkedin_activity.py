"""
Scrape LinkedIn recent activity for a profile using the Apify platform.

Actor: harvestapi/linkedin-profile-posts
Target: https://www.linkedin.com/in/philipp-gebhardt/recent-activity/all/

Setup:
    cp .env.example .env
    # Fill in your APIFY_API_TOKEN in .env
    pip install -r scrapers/requirements.txt

Run:
    python scrapers/linkedin_activity.py
"""

import json
import os
from pathlib import Path

from apify_client import ApifyClient
from dotenv import load_dotenv

PROFILE_URL = "https://www.linkedin.com/in/philipp-gebhardt/recent-activity/all/"
ACTOR_ID = "harvestapi/linkedin-profile-posts"
OUTPUT_FILE = Path(__file__).parent / "output" / "linkedin_activity.json"
MAX_POSTS = 50


def main():
    load_dotenv()
    api_token = os.getenv("APIFY_API_TOKEN")
    if not api_token:
        raise ValueError(
            "APIFY_API_TOKEN is not set. Copy .env.example to .env and add your token."
        )

    client = ApifyClient(api_token)

    print(f"Starting Apify actor '{ACTOR_ID}'...")
    print(f"Target URL: {PROFILE_URL}")

    run = client.actor(ACTOR_ID).call(
        run_input={
            "targetUrls": [PROFILE_URL],
            "maxPosts": MAX_POSTS,
        }
    )

    dataset_id = run.get("defaultDatasetId")
    items = list(client.dataset(dataset_id).iterate_items())

    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_FILE.write_text(json.dumps(items, indent=2, ensure_ascii=False))

    print(f"Scraped {len(items)} post(s), saved to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
