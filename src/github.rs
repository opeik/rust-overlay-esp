use std::collections::HashMap;

use color_eyre::{eyre::ContextCompat, Result};
use reqwest::{header::HeaderMap, Client};
use serde::{Deserialize, Serialize};
use url::Url;

use crate::metadata::{Fetch, Metadata, Name, Parse, RawMetadata};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Release {
    pub assets: Vec<Asset>,
    pub assets_url: String,
    pub author: Author,
    pub body: Option<String>,
    pub body_html: Option<String>,
    pub body_text: Option<String>,
    pub created_at: String,
    pub discussion_url: Option<String>,
    pub draft: bool,
    pub html_url: String,
    pub id: i64,
    pub mentions_count: Option<i64>,
    pub name: Option<String>,
    pub node_id: String,
    pub prerelease: bool,
    pub published_at: Option<String>,
    pub reactions: Option<Reaction>,
    pub tag_name: String,
    pub tarball_url: Option<String>,
    pub target_commitish: String,
    pub upload_url: String,
    pub url: String,
    pub zipball_url: Option<String>,
}

/// Data related to a release.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Asset {
    pub browser_download_url: String,
    pub content_type: String,
    pub created_at: String,
    pub download_count: i64,
    pub id: i64,
    pub label: Option<String>,
    pub name: String,
    pub node_id: String,
    pub size: i64,
    pub state: AssetState,
    pub updated_at: String,
    pub uploader: Option<User>,
    pub url: String,
}

/// State of the release asset.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum AssetState {
    Open,
    Uploaded,
}

/// A GitHub user.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct User {
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
pub struct Author {
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
pub struct Reaction {
    #[serde(rename = "+1")]
    pub upvotes: i64,
    #[serde(rename = "-1")]
    pub downvotes: i64,
    pub confused: i64,
    pub eyes: i64,
    pub heart: i64,
    pub hooray: i64,
    pub laugh: i64,
    pub rocket: i64,
    pub total_count: i64,
    pub url: String,
}

pub fn new_client() -> Result<Client> {
    let headers = HeaderMap::try_from(&HashMap::from([
        ("X-GitHub-Api-Version".to_string(), "2022-11-28".to_string()),
        (
            "Accept".to_string(),
            "application/vnd.github+json".to_string(),
        ),
    ]))?;

    Ok(Client::builder()
        .default_headers(headers)
        .user_agent("reqwest")
        .build()?)
}

pub async fn fetch_latest_release(client: &Client, url: Url) -> Result<Release> {
    let mut parts = url
        .path_segments()
        .context("failed to split github url")?
        .rev()
        .take(2);
    let repo = parts.next().context("missing github repo in url")?;
    let user = parts.next().context("missing github user in url")?;

    Ok(client
        .get(format!(
            "https://api.github.com/repos/{user}/{repo}/releases/latest"
        ))
        .send()
        .await?
        .json::<Release>()
        .await?)
}

pub struct Github;

impl Fetch for Github {
    async fn fetch<P: Parse>(url: Url) -> Result<impl Iterator<Item = Result<Metadata>>> {
        let client = new_client()?;
        let release = fetch_latest_release(&client, url).await?;
        Ok(release.assets.into_iter().map(move |x| {
            P::parse(RawMetadata {
                url: x.browser_download_url.as_str().try_into()?,
                name: Name::new(&x.name)?,
            })
        }))
    }
}
