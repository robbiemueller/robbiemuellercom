import json
import boto3
from botocore.exceptions import ClientError

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('visitor_counter')


def lambda_handler(event, context):
    try:
        response = table.update_item(
            Key={
                'page': 'resume'
            },
            UpdateExpression='ADD visits :incr',
            ExpressionAttributeValues={
                ':incr': 1
            },
            ReturnValues='UPDATED_NEW'
        )
    except ClientError as e:
        print(e.response['Error']['Message'])
        return {
            'statusCode': 500,
            'body': json.dumps('An error occurred while updating the visitor counter.')
        }
    else:
        return {
            'statusCode': 200,
            'body': json.dumps(f"Total visits: {response['Attributes']['visits']}")
        }
