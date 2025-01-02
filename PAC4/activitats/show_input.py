from PIL import Image
import matplotlib.pyplot as plt

img = Image.open('test_image.ppm')
plt.imshow(img)
plt.axis('off')
plt.show()
