module AccountRegisterer
    extend ActiveSupport::Concern

    BASE_CURRENCY = "USD"
    ACCOUNT_NUMBER_LENGTH = 12

    included do
        has_many :accounts, as: :accountable
        has_many :assets, through: :accounts
        after_commit :register_first_fiat_account, on: :create
    end

    def register_an_account(asset)
        account_number = get_available_account_number
        account = self.accounts.new(asset: asset, account_number: account_number)
        return account.save, account.errors.full_messages
    end

    def register_first_fiat_account
        base_fiat = Fiat.find_by_code(BASE_CURRENCY)
        register_an_account(base_fiat)
    end

    def get_available_account_number
        account_number = generate_account_number
        while Account.exists?(account_number: account_number) do
            account_number = generate_account_number
        end
        return account_number
    end

    def generate_account_number
        Array.new(ACCOUNT_NUMBER_LENGTH) { (1..9).to_a.sample }.join
    end
end
