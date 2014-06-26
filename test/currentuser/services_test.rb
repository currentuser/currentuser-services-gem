require 'helper'

module Currentuser
  module Services

    class ServicesTest < ActiveSupport::TestCase

      # timestamp_recent?

      test 'timestamp_recent? returns the expected result' do
        assert Services.timestamp_recent?(Time.now)
        assert Services.timestamp_recent?(Time.now - 9 * 60)
        assert Services.timestamp_recent?(Time.now + 9 * 60)
        refute Services.timestamp_recent?(Time.now - 11 * 60)
        refute Services.timestamp_recent?(Time.now + 11 * 60)
      end

      # signature_authentic?

      test 'signature_authentic returns the expected result' do
        timestamp = 100000
        user_id = 'user_id_1'
        signature = "RmYbwPNZc418905uSHHmrmkKcekj7OQw8zU372g6aEuMufOExuEJcSH3Zokq\nbJLFT89wxcF0/s9Ks2EV3cmuvoe5RQeanro7a0m+KpZskBt3IqxRiXFGr6sE\nvBfWrDQC24lJjKjIn76qMvwd/A6PmN0uyQz/QtE1FjXdNauYPq9xJoSPdL+T\nr3Y8uCnBkT8E1AwuiMC9zIjQVEBukmbR9LW8QNvg3+vdJfoxIsf4Gxxs5V6e\n0r7fk5Vz5uws3D/DmUWnfRaPaW9KYVB5VoOAD/P2TlGNZ7wurlYXuHPfK0QX\njkThXYrpFn6m5u2rVyFoNanroDTqIcndKxLDeXE0sg==\n"

        assert Services.signature_authentic?(signature, "#{user_id}#{timestamp}")
        refute Services.signature_authentic?(signature, "0#{user_id}#{timestamp}")
        refute Services.signature_authentic?("0#{signature}", "#{user_id}#{timestamp}")
      end

      # check_authentication_params!

      test 'can authenticate (stubbing :timestamp_recent?)' do

        # These data have been prepare using current-services private key.
        timestamp = 100000
        user_id = 'user_id_1'
        signature = "RmYbwPNZc418905uSHHmrmkKcekj7OQw8zU372g6aEuMufOExuEJcSH3Zokq\nbJLFT89wxcF0/s9Ks2EV3cmuvoe5RQeanro7a0m+KpZskBt3IqxRiXFGr6sE\nvBfWrDQC24lJjKjIn76qMvwd/A6PmN0uyQz/QtE1FjXdNauYPq9xJoSPdL+T\nr3Y8uCnBkT8E1AwuiMC9zIjQVEBukmbR9LW8QNvg3+vdJfoxIsf4Gxxs5V6e\n0r7fk5Vz5uws3D/DmUWnfRaPaW9KYVB5VoOAD/P2TlGNZ7wurlYXuHPfK0QX\njkThXYrpFn6m5u2rVyFoNanroDTqIcndKxLDeXE0sg==\n"

        # As we use a fixed timestamp we have to simulate it is recent
        Services.stub :timestamp_recent?, true do
          Services.check_authentication_params! currentuser_id: user_id, timestamp: timestamp, signature: signature
        end
      end

      test 'can authenticate (stubbing :signature_authentic?)' do

        # Take a recent timestamp
        timestamp = (Time.now - 60).to_i.to_s
        user_id = 'user_id_1'
        signature = 'any_signature'

        # By pass signature checking
        Services.stub :signature_authentic?, true do
          Services.check_authentication_params! currentuser_id: user_id, timestamp: timestamp, signature: signature
        end
      end

      test 'raises if timestamp too old' do

        # Take an old timestamp (and an invalid signature, but this has no impact)
        timestamp = (Time.now - 15 * 60).to_i.to_s
        user_id = 'user_id_1'
        signature = 'any_signature'

        assert_raises Services::TimestampTooOld do
          Services.check_authentication_params! currentuser_id: user_id, timestamp: timestamp, signature: signature
        end
      end

      test 'raises if signature invalid' do

        # Take a recent timestamp and an invalid signature
        timestamp = (Time.now - 60).to_i.to_s
        user_id = 'user_id_1'
        signature = 'any_signature'

        assert_raises Services::SignatureNotAuthentic do
          Services.check_authentication_params! currentuser_id: user_id, timestamp: timestamp, signature: signature
        end
      end
    end
  end
end
