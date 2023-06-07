use color_eyre::Result;
use reqwest::header::HeaderMap;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

/// A release.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Release {
    pub assets: Vec<ReleaseAsset>,
    pub assets_url: String,
    pub body: Option<String>,
    pub body_html: Option<String>,
    pub body_text: Option<String>,
    pub created_at: String,
    pub draft: bool,
    pub html_url: String,
    pub id: i64,
    pub name: Option<String>,
    pub tag_name: String,
    pub tarball_url: Option<String>,
    pub target_commitish: String,
    pub upload_url: String,
    pub url: String,
    pub zipball_url: Option<String>,
}

/// Data related to a release.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ReleaseAsset {
    pub browser_download_url: String,
    pub content_type: String,
    pub created_at: String,
    pub id: i64,
    pub name: String,
    pub node_id: String,
    pub size: i64,
    pub state: State,
    pub updated_at: String,
    pub url: String,
}

/// State of the release asset.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum State {
    Open,
    Uploaded,
}

pub fn new_client() -> Result<reqwest::Client> {
    let headers = HeaderMap::try_from(&HashMap::from([
        ("X-GitHub-Api-Version".to_string(), "2022-11-28".to_string()),
        (
            "Accept".to_string(),
            "application/vnd.github+json".to_string(),
        ),
    ]))?;

    Ok(reqwest::Client::builder()
        .default_headers(headers)
        .user_agent("reqwest")
        .build()?)
}

pub async fn fetch_latest_release(client: &reqwest::Client, repo: &str) -> Result<Release> {
    Ok(client
        .get(format!(
            "https://api.github.com/repos/{repo}/releases/latest"
        ))
        .send()
        .await?
        .json::<Release>()
        .await?)
}
