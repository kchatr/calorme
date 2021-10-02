# CalorMe
<h2>🍳 Inspiration</h2>

<p>It seems like the world could not be more eager to inform us that the nutritional apocalypse is upon us: one in every five children is obese, one in every three adults is obese, and heart disease and stroke are among the leading causes of death worldwide. On a whole, obesity rates have more than tripled since 1975 and are still on the rise.</p>

<p>Of course, upon hearing this, we feel worry, concern, and frankly, disheartenment. Because it seems as though all hope is lost and all that awaits humanity is impending doom. We toss and turn in bed, unable to take our minds off the troubling news we heard earlier that day.</p>

<p>And then, we wake up the very next day and forget everything we learned the day before. The end.
*(And they all lived happily ever after. Until they died from heart disease because of their poor eating habits.) *</p>

<p><strong>Enter: CalorMe, a way to prolong the story by providing consumers with an actionable way to take a step towards leading healthier and happier lives.</strong></p>

<hr>

<h2>🔍What it does</h2>

<p>CalorMe is a mobile app that allows users to take their nutritional choices into their own hands. Users simply take or upload a picture of their next meal to the CalorMe platform and, with the help of computer vision and deep learning, users can see important nutritional information, such as calorie count and macronutrient breakdown. </p>

<hr>

<h2>🔨How we built it</h2>

<p><strong>For the AI portion:</strong>
We used Keras with TensorFlow and coded everything in Jupyter notebooks. I used the data from the Food-101 dataset <a href="https://www.kaggle.com/kmader/food41?select=images" rel="nofollow">food dataset</a>. </p>

<p>We started off with our own convolutional neural network but quickly realized we would achieve better results with shorter training times by using transfer learning. We tried three different bases of different pre-trained models: InceptionV3, VGG16, and MobileNetV2 <a href="https://keras.io/api/applications/" rel="nofollow">Keras Pre-trained models</a>. InceptionV3 worked the best so we used this base and continued to optimize it to achieve a validation accuracy of 86% and a training accuracy of 97%. </p>

<p><strong>For the Mobile App portion:</strong>
We created the mobile app using Google's Flutter framework. Flutter enables you to create native-looking and performing apps for Android, iOS, Windows, and even the web all from one codebase. </p>

<p>Creating the front-end with Flutter was relatively easy, with an MVP being able to be produced in just a few hours. Flutter had packages for image selection and specific UI elements, allowing us to develop without recreating the wheel. The classification of the uploaded picture is done through TensorFlow Lite (TFLite), a package that allowed us to integrate our trained neural network with the app. Finally, once the image is classified, an API request is made via HTTPS to Edamam, providing the nutritional information in a JSON string. This is finally deserialized to a map object and the relevant information is retrieved and presented to the user. </p>

<hr>

<h2>🚧Challenges we ran into</h2>

<h4>Training takes a lot of time and kills computers</h4>

<ol>
<li>The many features of the dataset in combination with the difficulty of training a convolutional neural network meant that it would take hours to train our own network even when using a GPU. In order to optimize the training process, we cut down on the image size and did more preprocessing to reduce the amount of noise that the model would have to sift through. We also switched to transfer learning and used a pre-trained base so that we can  <em>reuse</em>  parts of an already-trained network.</li>
</ol>

<h4>Overfitting sucks</h4>

<ol>
<li>After training our network, we plotted the loss and accuracy of the training over multiple epochs. We were quick to realize that the model was slightly over-fitting, meaning that it was relying too heavily on the training data. In order to fix this issue, we implemented dropout layers and reduced the depth of the network we were adding onto the pre-trained base. We also implemented early stopping so we could specify it to train for more epochs and it would stop training automatically when there was no improvement for multiple epochs. </li>
</ol>

<h4>Integration was pain :D</h4>

<ol>
<li>We also had difficulties in integrating the AI model into Flutter. The current version of TFLite contained deprecated Android Embedding (whatever that meant), which could lead to possible runtime errors through no fault of our code. After some experiments, we realized the issue was not with the Flutter code, but the model's - it was <em>too new</em>. So, we had to retrain the model on a previous version of TensorFlow, re-integrate it with the code, and sort out any errors that came up.</li>
</ol>

<p>It was an incredibly long and tiring process since it was hard to figure out exactly <em>where</em> the errors came from.  </p>

<h4>Figuring out errors</h4>

<ol>
<li>When you have as many components in an app as we do - the actual app, the TFLite model, and the API - it can be very hard to figure out exactly where a component is broken and what needs to be fixed. The issue could lie with our code, the package, or how we're integrating the two; it could be that the API is returning null because of incorrect formatting; maybe the package contains code that breaks with our Flutter version. There are so many factors that depend upon one another, so any errors that come up are incredibly difficult to decipher. </li>
</ol>

<hr>

<h2>Accomplishments that we're proud of 🏆</h2>

<ul>
<li>Our app works (somehow) and is production-ready!</li>
<li>We finished on time :)</li>
<li>The AI model works and can accurately classify foods it hasn't been trained on</li>
<li>We created a fully functioning app that not only looks good but has an AI component and can make API requests - all in the span of under 36 hours. </li>
</ul>

<hr>

<h2>What we learned 💡</h2>

<ul>
<li>We learned how to create a mobile application in Flutter and how to effectively test and debug Flutter projects</li>
<li>We learned how to train a Convolutional Neural Network in TensorFlow and convert it to a TFLite model for mobile</li>
<li>We learned how to make an API request via HTTPS in Flutter, as well as retrieve, deserialize, and use JSON data </li>
<li>We learned how to create a fully functioning app with an intuitive UX that is production-ready and achieved our initial goals</li>
</ul>

<hr>

<h2>What's next for CalorMe 💭</h2>

<ul>
<li>Training the model on a larger variety of foods (be able to identify all common foods)</li>
<li>Fine-tuning the neural network to increase the accuracy values</li>
<li>A new feature to record new recipes, making the model 'actively learn'</li>
<li>Allow users to track their foods, with the app tabulating their caloric and nutritional intake for the day, and how that compares to the recommended intake for their age, height, and weight</li>
<li>Gamify a healthy lifestyle </li>
</ul>



---


A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


