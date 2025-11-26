# Mindfulness Audio Setup Instructions

## Audio Files Required

The mindfulness feature needs the following audio files to work properly:

1. `ocean_waves.mp3` - Ocean waves sound (10 min loop recommended)
2. `rain_thunder.mp3` - Rain and thunder ambience (10 min loop recommended)
3. `forest_sounds.mp3` - Forest nature sounds (10 min loop recommended)
4. `deep_ocean.mp3` - Deep ocean ambience (10 min loop recommended)

## How to Add Audio Files to Xcode

### Step 1: Get Your Audio Files
- Download or create the MP3 files for each sound
- Recommended: Use loopable audio files (seamless loops)
- File format: `.mp3` (other formats supported: `.m4a`, `.wav`)

### Step 2: Add Files to Xcode Project
1. Open your Xcode project
2. Right-click on the `GoonAi` folder in the Project Navigator
3. Select **"Add Files to 'GoonAi'..."**
4. Navigate to your audio files
5. **Important:** Make sure "Copy items if needed" is **checked**
6. **Important:** Make sure "Add to targets: GoonAi" is **checked**
7. Click "Add"

### Step 3: Verify Files Are Added
1. In Xcode, select your project in the navigator
2. Select the `GoonAi` target
3. Go to "Build Phases" tab
4. Expand "Copy Bundle Resources"
5. Verify all 4 audio files are listed there
   - If not, click the `+` button and add them

### Step 4: Test the Audio
1. Build and run the app
2. Navigate to **Library** tab
3. Scroll to the **Mindfulness** section
4. Tap any sound card (e.g., "Ocean Waves")
5. The player should open and the sound should start playing automatically
6. Test the controls:
   - **Play/Pause** button (center)
   - **Restart** button (left)
   - **Close** button (right)

## Current Behavior

### With Audio Files ✅
- Sounds will play in an infinite loop
- Timer shows actual playback time
- Play/pause works correctly
- Restart resets to beginning
- Audio continues in background (if supported)

### Without Audio Files ⚠️
- App will fall back to simulation mode
- Timer will increment but no sound plays
- Console will show: `⚠️ Audio file not found: [filename]`
- Everything else works normally

## Free Audio Resources

You can find free, loopable ambient sounds at:
- **Freesound.org** - https://freesound.org
- **Incompetech** - https://incompetech.com
- **YouTube Audio Library** - https://www.youtube.com/audiolibrary
- **Zapsplat** - https://www.zapsplat.com

Search for:
- "ocean waves loop"
- "rain thunder ambience"
- "forest birds nature"
- "deep ocean underwater"

## Troubleshooting

### "Audio file not found" error
- Check that files are named exactly as expected (case-sensitive)
- Verify files are in "Copy Bundle Resources" in Build Phases
- Clean build folder (Cmd+Shift+K) and rebuild

### Audio doesn't play
- Check device volume is not muted
- Check silent mode switch on iPhone
- Verify audio files are valid MP3s
- Check Xcode console for error messages

### Audio stops when app goes to background
- This is normal iOS behavior unless background audio is enabled
- The app is configured for foreground playback

## Technical Details

- **Audio Player:** AVAudioPlayer
- **Audio Session Category:** `.playback`
- **Loop Mode:** Infinite (`-1`)
- **Supported Formats:** MP3, M4A, WAV, CAF
- **Timer Update Interval:** 0.1 seconds (100ms)
