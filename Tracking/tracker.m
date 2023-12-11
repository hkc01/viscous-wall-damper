close all, clear, clc
% Import the video
videoFile = 'motor1.mov';  % replace with your video file
videoReader = VideoReader(videoFile);

% Read the first frame and select points to track
frame = readFrame(videoReader);
imshow(frame);
title('Select points to track');
[xPoints, yPoints] = getpts;
close;
points = [xPoints, yPoints];
points_to_track = cornerPoints(points);  % convert to cornerPoints object

% Create a point tracker
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Initialize the tracker with the initial point locations and the initial video frame
initialize(pointTracker, points_to_track.Location, frame);

videoPlayer  = vision.VideoPlayer('Position', [100, 100, size(frame, 2), size(frame, 1)]);

% Initialize array to store tracked points
tracked_points = [];

% Track the points from frame to frame
while hasFrame(videoReader)
    frame = readFrame(videoReader);
    [points, validity] = step(pointTracker, frame);
    out = insertMarker(frame, points(validity, :), 'circle', 'Size', 30, "Color", "red");
    step(videoPlayer, out);
    % Append points to the tracked_points array
    tracked_points = cat(3, tracked_points, points);
end

% Release video player and tracker
release(videoPlayer); release(pointTracker);
pause(1); delete(videoPlayer);

xPos= squeeze(tracked_points(:, 1, :));
yPos= squeeze(tracked_points(:, 2, :));

%%
close all;
scaleFactor= (mean(yPos(5:8))-mean(yPos(1:4)))/15; % pixel / cm
xReal= xPos/scaleFactor; 
yReal= yPos/scaleFactor;

time= [1:length(xPos)]/240;

figure(1), sgtitle("Plate Movements")
subplot(2, 1, 1), hold on
plot(time, xReal(4, :)-xReal(4, 1), DisplayName= "Upper Plate", LineWidth= 2)
plot(time, xReal(5, :)-xReal(5, 1), DisplayName= "Ground", LineWidth= 2)
xlabel("time (s)"), ylabel("Position in x-direction (cm)"), grid
title("no VWD"), legend

subplot(2, 1, 2), hold on
plot(time, xReal(1, :)-xReal(1, 1), DisplayName= "Upper Plate", LineWidth= 2)
plot(time, xReal(5, :)-xReal(5, 1), DisplayName= "Ground", LineWidth= 2)
xlabel("time (s)"), ylabel("Position in x-direction (cm)"), grid
title("with VWD"), legend

figure(2), sgtitle("Interstory Drift")
subplot(2, 1, 1), hold on
plot(time, [xReal(4, :)-xReal(4, 1)]-[xReal(5, :)-xReal(5, 1)], Color= "#7E2F8E", LineWidth= 2)
xlabel("time (s)"), ylabel("Column deflection (cm)"), grid
title("no VWD"), a= axis;

subplot(2, 1, 2), hold on
plot(time, [xReal(1, :)-xReal(1, 1)]-[xReal(5, :)-xReal(5, 1)], Color= "#7E2F8E", LineWidth= 2)
xlabel("time (s)"), ylabel("Column deflection (cm)"), grid
title("with VWD"), axis(a)