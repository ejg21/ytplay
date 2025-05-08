const express = require('express');
const { exec } = require('child_process');
const app = express();
const port = process.env.PORT || 3000;

// Serve the static frontend files
app.use(express.static('public'));

// Handle the route for video URLs
app.get('/video/:videoid/m3u8', (req, res) => {
    const videoId = req.params.videoid;
    const url = `https://www.youtube.com/watch?v=${videoId}`;

    // Use yt-dlp to fetch the M3U8 URLs
    exec(`yt-dlp -f 232+233 -g "${url}"`, (err, stdout, stderr) => {
        if (err) {
            console.error(`Error executing yt-dlp: ${stderr}`);
            return res.status(500).json({ error: 'Failed to retrieve video URLs' });
        }

        // Parse the output to extract the two m3u8 URLs
        const urls = stdout.split('\n').filter(line => line.includes('manifest.googlevideo.com'));
        if (urls.length < 2) {
            return res.status(404).json({ error: 'Not enough manifest URLs found' });
        }

        // Return the two m3u8 URLs in the response
        res.json({
            video1: urls[0].trim(), // First video stream URL
            video2: urls[1].trim()  // Second video stream URL
        });
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
