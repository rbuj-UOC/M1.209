from PIL import Image
import numpy as np
import matplotlib.pyplot as plt

width, height = 1920, 1080
data = np.zeros((height, width, 3), dtype=np.uint8)
for x in range(width):
    for y in range(height):
        data[y, x] = [x % 256, (y % 256), (x * y) % 256]  # Color pattern

img = Image.fromarray(data, 'RGB')
img.save('test_image.ppm')
