from random import randint 
import time
import os
import asyncio
from azure.iot.device.aio import IoTHubDeviceClient


async def main():
    print("Starting Azure Device...")

    # Fetch the connection string from an enviornment variable
    conn_str = os.getenv("IOTHUB_DEVICE_CONNECTION_STRING")
 
    # Create instance of the device client using the authentication provider
    device_client = IoTHubDeviceClient.create_from_connection_string(conn_str)

    # Connect the device client.
    await device_client.connect()
    print("Connected to IoT Hub")

    # Send a single message
    print("Sending message...")
    await device_client.send_message("This is a message that is being sent")
    print("Message successfully sent!")

    while (True) :
        message = "{\"devID\":\" JBThing1 \",\"temperature\":" + str(randint(50,100)) + ",\"humidity\":" + str(randint(10,99))+"}"
        print("Sending Message: " + message)
        await device_client.send_message(message)
        time.sleep(10)

    # finally, disconnect
    await device_client.disconnect()


if __name__ == "__main__":
    asyncio.run(main())