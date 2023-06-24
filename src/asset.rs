use color_eyre::Result;
use data_encoding::HEXLOWER;
use futures_util::{stream, Stream, StreamExt};
use ring::digest::{Context, SHA256};
use tracing::info;

use crate::metadata::{Metadata, Sha256Digest};

#[derive(Debug, Clone)]
pub struct Asset {
    pub metadata: Metadata,
    pub sha256_digest: Option<Sha256Digest>,
}

pub fn fetch(
    metadata: impl IntoIterator<Item = Metadata>,
    buffer: usize,
) -> impl Stream<Item = Result<Asset>> {
    stream::iter(metadata)
        .map(fetch_asset)
        .buffer_unordered(buffer)
}

async fn fetch_asset(metadata: Metadata) -> Result<Asset> {
    let mut stream = reqwest::get(metadata.url.as_ref()).await?.bytes_stream();
    let mut context = Context::new(&SHA256);

    info!("downloading `{}`...", metadata.url);
    while let Some(chunk_result) = stream.next().await {
        let chunk = chunk_result?;
        context.update(&chunk)
    }

    Ok(Asset {
        metadata,
        sha256_digest: Some(Sha256Digest::new(
            HEXLOWER.encode(context.finish().as_ref()),
        )?),
    })
}
