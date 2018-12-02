# dvhacksai-sfhackers
Project for DV Hacks: AI Hackathon


## Overview:
1. Serve as a platform to augment research trial screening, data collection for clinical trials. 
2. Utilize machine learning techniques to help researchers determine the key variables affecting outcomes to create new research.
3. Give researchers access to repository of anonymized data from millions of users to determine new research opportunities to generate breakthrough cures, regiments, and control our biology.

## Key Technologies:
- CoreML(CNN, MLImageClassifierBuilder)
- Data from International Skin Imaging Collaboration(Dataset of 320 images)
- We split the data into 80/20 with 5-fold cross validation
- 88% validation on avarage 

- Log output:

```
Extracting image features from full data set.
Analyzing and extracting image features.
+------------------+--------------+------------------+
| Images Processed | Elapsed Time | Percent Complete |
+------------------+--------------+------------------+
| 1                | 1.67s        | 0.25%            |
| 2                | 1.84s        | 0.75%            |
| 3                | 2.00s        | 1.25%            |
| 4                | 2.13s        | 1.5%             |
| 5                | 2.27s        | 2%               |
| 10               | 2.94s        | 4%               |
| 25               | 4.89s        | 10.25%           |
| 50               | 7.76s        | 20.75%           |
| 75               | 10.72s       | 31.25%           |
| 100              | 13.90s       | 41.5%            |
| 125              | 17.16s       | 52%              |
| 150              | 20.26s       | 62.5%            |
| 175              | 23.49s       | 72.75%           |
| 200              | 27.04s       | 83.25%           |
| 225              | 30.70s       | 93.75%           |
| 240              | 32.84s       | 100%             |
+------------------+--------------+------------------+
Automatically generating validation set from 5% of the data.
Beginning model training on processed features. 
Calibrating solver; this may take some time.
+-----------+--------------+-------------------+---------------------+
| Iteration | Elapsed Time | Training Accuracy | Validation Accuracy |
+-----------+--------------+-------------------+---------------------+
| 0         | 0.016709     | 0.510917          | 0.272727            |
| 1         | 0.093525     | 0.772926          | 0.909091            |
| 2         | 0.176042     | 0.790393          | 0.818182            |
| 3         | 0.209288     | 0.786026          | 0.818182            |
| 4         | 0.247443     | 0.781659          | 0.818182            |
| 5         | 0.275712     | 0.781659          | 0.818182            |
| 10        | 0.443477     | 0.877729          | 0.909091            |
+-----------+--------------+-------------------+---------------------+
Completed (Iteration limit reached).
Extracting image features from evaluation data.
Analyzing and extracting image features.
+------------------+--------------+------------------+
| Images Processed | Elapsed Time | Percent Complete |
+------------------+--------------+------------------+
| 1                | 216.249ms    | 1.25%            |
| 2                | 558.327ms    | 2.5%             |
| 3                | 785.792ms    | 3.75%            |
| 4                | 1.01s        | 5%               |
| 5                | 1.23s        | 6.25%            |
| 10               | 2.64s        | 12.5%            |
| 25               | 6.49s        | 31.25%           |
| 50               | 12.35s       | 62.5%            |
| 75               | 17.85s       | 93.75%           |
| 80               | 18.99s       | 100%             |
+------------------+--------------+------------------+
----------------------------------
Number of examples: 80
Number of classes: 2
Accuracy: 88.50%
```

## Steps to Build and Test:
1. Download repo
2. Run the project in Xcode
3. Drag and Drop images from the test folder to simulator Photos<br> 
      3.1 EXTRA(Real device): Connect your iPhone and run the project. Ensure a valid provisioning profile is selected.
5. Test time

