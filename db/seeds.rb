# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PaperTrail.request(:whodunnit => Account::MACHINE_ID, :controller_info => {:context_id => SecureRandom.uuid(), :actor_id => nil}) do
  ActiveRecord::Base.transaction do
    PaymentType.create([
      {:name => "Cash"},
      {:name => "Check"},
      {:name => "Visa"},
      {:name => "Discover Card"},
      {:name => "Mastercard"},
      {:name => "EBT/Foodstamps"},
      {:name => "Giftcards"},
      {:name => "Online Payments"},
      {:name => "Bitcoin/Cryptocurrency"}
    ])

    if Rails.env.development? && ENV.key?("BENCHMARK")
      1000.times.each do
        FactoryBot.create(
          :account,
          *[
            *15.times.map {[]},
            *25.times.map {[:confirmed]},
            *45.times.map {[:confirmed, :completed]},
            *5.times.map {[:confirmed, :completed, :administrator]}
          ].sample
        )
      end
    end

    if Rails.env.production? && Account.count.zero?
      krainboltgreene = Account.create!(
        :username => "krainboltgreene",
        :name => "Kurtis Rainbolt-Greene",
        :email => "kurtis@rainbolt-greene.online",
        :password => SecureRandom.hex(32)
      )
      krainboltgreene.confirm
      krainboltgreene.complete!
      krainboltgreene.upgrade_to_administrator!
    end

    if Rails.env.development?
      administrator = Account.create!(
        :username => "sally",
        :name => "Sally Stuthers",
        :email => "sally@example.com",
        :password => "password"
      )
      administrator.confirm
      administrator.complete!
      administrator.upgrade_to_administrator!

      customer = Account.create!(
        :username => "calvin",
        :name => "Calvin Klean",
        :email => "calvin@example.com",
        :password => "password"
      )
      customer.confirm
      customer.complete!

      PaperTrail.request(:whodunnit => administrator.email, :controller_info => {:context_id => SecureRandom.uuid(), :actor_id => administrator.id}) do
      end
    end
  end
end
