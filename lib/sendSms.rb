# Download the twilio-ruby library from twilio.com/docs/libraries/ruby
require 'twilio-ruby'

account_sid = 'AC2d6852132d5cdd9608396a5f5b3a9bd0'
auth_token = '98f334e2e62db3dd6b7bde791a74bb21'
client = Twilio::REST::Client.new(account_sid, auth_token)
from = '+19787170234' # Your Twilio number
to = '+447722160086' # Your mobile phone number

message = client.messages.create(
from: from,
to: to,
body: "your food will arrive in 14:30"
)

puts message.sid