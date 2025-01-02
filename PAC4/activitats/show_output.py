from PIL import Image
import matplotlib.pyplot as plt

img = Image.open('output_image.ppm')
plt.imshow(img, cmap="gray")
plt.axis('off')
plt.show()
