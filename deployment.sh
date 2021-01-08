
########################################
# Deploying model to Google AI Platform
########################################

#Set these as Enviornment Variables

#MODEL_DIR="gs://n-models"
#VERSION_NAME="initial"
#MODEL_NAME="model_deployment"
#FRAMEWORK="scikit-learn"
#GCP_PROJECT=''



#Copy model pickle file to google bucket
gsutil cp $MODEL_PATH "gs://models/"


#Set GCP Project to be used for hosting a model
gcloud config set project $GCP_PROJECT


#Setup a new Model on GCP AI Platform
gcloud ai-platform models create "model_deployment" --regions us-central1


# Deploy
gcloud ai-platform versions create $VERSION_NAME \
									--model $MODEL_NAME \
									--origin $MODEL_DIR \
									--runtime-version=1.15 \
									--framework $FRAMEWORK \
									--python-version=3.7

# Get details about deployed model
gcloud ai-platform versions describe $VERSION_NAME \
--model $MODEL_NAME