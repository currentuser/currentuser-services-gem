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
    end
  end
end
