import cv2
from ultralytics import YOLO

# Load the YOLOv8 model (you can use 'yolov8n.pt', 'yolov8s.pt', 'yolov8m.pt', etc.)
model = YOLO("yolov8n.pt")  # nano model for speed

# Open webcam
cap = cv2.VideoCapture(0)  # change to a file path if you want to use a video file

def zone(centroid, width):
    x = centroid[0]
    if x < width/3:
        return -1
    elif width/3 <= x < 2*width/3:
        return 0
    else:
        return 1

while True:
    ret, frame = cap.read()
    if not ret:
        break

    # Run YOLOv8 inference on the frame
    # results = model(frame, imgsz=640, conf=0.5, device="cpu")
    results = model(frame, conf=0.6, device="cpu", verbose=False)

    # Get frame dimensions
    height, width = frame.shape[:2]

    # Compute 1/3 and 2/3 of width
    x1 = width // 3
    x2 = 2 * width // 3

    # Draw vertical lines (from top to bottom of the frame)
    cv2.line(frame, (x1, 0), (x1, height), (0, 255, 0), 2)  # Green line
    cv2.line(frame, (x2, 0), (x2, height), (0, 255, 0), 2)  # Green line
    boxes = results[0].boxes

    if(len(boxes) != 1):
        print("Stop")
    else:
        x1, y1, x2, y2 = boxes.xyxy[0] # x1, y1, x2, y2
        class_id = int(boxes[0].cls[0]) # Get the class ID
        class_name = model.names[class_id] # Get the class name

        if(class_name.lower() == "person"):
            print("EMERGENCY Stop")
        else:
            centroid = ((x1 + x2)/2, ((y1 + y2)/2))
            object_zone = zone(centroid, width)

            cv2.circle(frame, (int(centroid[0]), int(centroid[1])), radius=5, color=(0, 0, 255), thickness=-1)
            if object_zone == -1: print("Left")
            elif object_zone == 0: print("Center")
            elif object_zone == 1: print("Right")

    annotated_frame = results[0].plot()  # draw predictions on the frame

    # Show the result
    cv2.imshow("YOLOv8 Detection", annotated_frame)

    # Exit on pressing 'q'
    if cv2.waitKey(10) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
