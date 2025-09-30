import { createClient } from 'npm:@supabase/supabase-js@2'
import { JWT } from 'npm:google-auth-library@9'
import serviceAccount from '../service-account.json' with { type: 'json' }

interface Notification {
  id: string
  user_id: string
  title: string
  message: string
  created_at: string
}

interface WebhookPayload {
  type: 'INSERT'
  table: string
  record: Notification
  schema: 'public'
}

const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)

Deno.serve(async (req) => {
  try {
    const payload: WebhookPayload = await req.json()
    console.log('Received webhook payload:', JSON.stringify(payload, null, 2))

    // Get all FCM tokens for the user
    const { data: tokens, error } = await supabase
      .from('user_fcm_tokens')
      .select('fcm_token')
      .eq('user_id', payload.record.user_id)

    if (error) {
      console.error('Error fetching FCM tokens:', error)
      throw error
    }

    if (!tokens || tokens.length === 0) {
      console.log('No FCM tokens found for user:', payload.record.user_id)
      return new Response(JSON.stringify({ message: 'No devices to notify' }), {
        status: 200,
        headers: { 'Content-Type': 'application/json' },
      })
    }

    console.log(`Found ${tokens.length} FCM tokens for user`)

    // Get access token for FCM
    let accessToken
    try {
      accessToken = await getAccessToken({
        clientEmail: serviceAccount.client_email,
        privateKey: serviceAccount.private_key,
      })
      console.log('Successfully obtained FCM access token')
    } catch (tokenError) {
      console.error('Error getting FCM access token:', tokenError)
      throw tokenError
    }

    // Send notification to all devices
    const results = await Promise.allSettled(
      tokens.map(({ fcm_token }) => 
        sendNotification(fcm_token, payload.record, accessToken)
          .catch(error => {
            console.error(`Error sending to token ${fcm_token.substring(0, 10)}...:`, error)
            throw error
          })
      )
    )

    const successful = results.filter(r => r.status === 'fulfilled').length
    const failed = results.filter(r => r.status === 'rejected').length
    
    console.log(`Notifications sent: ${successful} successful, ${failed} failed`)
    
    // Log detailed results
    results.forEach((result, index) => {
      if (result.status === 'rejected') {
        console.error(`Failed to send to token ${tokens[index].fcm_token.substring(0, 10)}...:`, result.reason)
      }
    })

    return new Response(JSON.stringify({ 
      success: true,
      sent: successful,
      failed
    }), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    })

  } catch (error) {
    console.error('Error in notification handler:', {
      error: error.message,
      stack: error.stack,
      name: error.name
    })
    return new Response(JSON.stringify({ 
      error: 'Failed to send notifications',
      details: error.message,
      stack: error.stack
    }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    })
  }
})

async function sendNotification(token: string, notification: Notification, accessToken: string) {
  const url = `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`
  console.log(`Sending notification to FCM for token: ${token.substring(0, 10)}...`)

  const response = await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${accessToken}`,
    },
    body: JSON.stringify({
      message: {
        token: token,
        notification: {
          title: notification.title,
          body: notification.message,
        },
        data: {
          notificationId: String(notification.id),  // Convert number to string
          title: notification.title,
          message: notification.message,
          type: 'general',
          // Add any other fields as strings
        },
      },
    }),
  })

  const responseData = await response.json()
  console.log('FCM response:', {
    status: response.status,
    statusText: response.statusText,
    data: responseData
  })

  if (!response.ok) {
    throw new Error(`FCM error: ${JSON.stringify(responseData)}`)
  }

  return responseData
}


const getAccessToken = ({
  clientEmail,
  privateKey,
}: {
  clientEmail: string
  privateKey: string
}): Promise<string> => {
  return new Promise((resolve, reject) => {
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
    })
    jwtClient.authorize((err, tokens) => {
      if (err) {
        reject(err)
        return
      }
      resolve(tokens!.access_token!)
    })
  })
}