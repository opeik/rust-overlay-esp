use color_eyre::Result;
use reqwest::header::HeaderMap;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

/// A release.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Release {
    pub assets: Vec<ReleaseAsset>,
    pub assets_url: String,
    /// A GitHub user.
    pub author: AuthorClass,
    pub body: Option<String>,
    pub body_html: Option<String>,
    pub body_text: Option<String>,
    pub created_at: String,
    /// The URL of the release discussion.
    pub discussion_url: Option<String>,
    /// true to create a draft (unpublished) release, false to create a published one.
    pub draft: bool,
    pub html_url: String,
    pub id: i64,
    pub mentions_count: Option<i64>,
    pub name: Option<String>,
    pub node_id: String,
    /// Whether to identify the release as a prerelease or a full release.
    pub prerelease: bool,
    pub published_at: Option<String>,
    pub reactions: Option<ReactionRollup>,
    /// The name of the tag.
    pub tag_name: String,
    pub tarball_url: Option<String>,
    /// Specifies the commitish value that determines where the Git tag is created from.
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
    pub download_count: i64,
    pub id: i64,
    pub label: Option<String>,
    /// The file name of the asset.
    pub name: String,
    pub node_id: String,
    pub size: i64,
    /// State of the release asset.
    pub state: State,
    pub updated_at: String,
    pub uploader: Option<SimpleUser>,
    pub url: String,
}

/// State of the release asset.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum State {
    Open,
    Uploaded,
}

/// A GitHub user.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SimpleUser {
    pub avatar_url: String,
    pub email: Option<String>,
    pub events_url: String,
    pub followers_url: String,
    pub following_url: String,
    pub gists_url: String,
    pub gravatar_id: Option<String>,
    pub html_url: String,
    pub id: i64,
    pub login: String,
    pub name: Option<String>,
    pub node_id: String,
    pub organizations_url: String,
    pub received_events_url: String,
    pub repos_url: String,
    pub site_admin: bool,
    pub starred_at: Option<String>,
    pub starred_url: String,
    pub subscriptions_url: String,
    #[serde(rename = "type")]
    pub simple_user_type: String,
    pub url: String,
}

/// A GitHub user.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AuthorClass {
    pub avatar_url: String,
    pub email: Option<String>,
    pub events_url: String,
    pub followers_url: String,
    pub following_url: String,
    pub gists_url: String,
    pub gravatar_id: Option<String>,
    pub html_url: String,
    pub id: i64,
    pub login: String,
    pub name: Option<String>,
    pub node_id: String,
    pub organizations_url: String,
    pub received_events_url: String,
    pub repos_url: String,
    pub site_admin: bool,
    pub starred_at: Option<String>,
    pub starred_url: String,
    pub subscriptions_url: String,
    #[serde(rename = "type")]
    pub simple_user_type: String,
    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ReactionRollup {
    #[serde(rename = "+1")]
    pub upvote: i64,
    #[serde(rename = "-1")]
    pub downvote: i64,
    pub confused: i64,
    pub eyes: i64,
    pub heart: i64,
    pub hooray: i64,
    pub laugh: i64,
    pub rocket: i64,
    pub total_count: i64,
    pub url: String,
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
