require './lib/oyster_card.rb'
describe OysterCard do
  describe "#initialize" do
    it "starting balance of 0" do
      expect(subject.balance).to eq(0)
    end
  end
  describe "#top_up" do
    it "adds to the balance" do
      subject.top_up(30)
      expect(subject.balance).to eq(30)
    end
     it "throws an error if the balance would exceed £90 limit" do
       expect{ subject.top_up(100) }.to raise_error(RuntimeError, "Error, Maximum card limit of £90")
     end
  end
  describe "#deduct" do
    it "deduct the amount entered from balance" do
      subject.top_up(30)
      subject.deduct(20)
      expect(subject.balance).to eq(10)
    end
  end
  describe "#in_journey?" do
    it "return the state" do
      expect(subject.in_journey?).to eq(nil)
    end
  end
  describe "#touch_in" do
    it "switches the state of use to in_journey?" do
    subject.top_up(30)
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end
    it "raises an error if balance is less than MIN" do
      expect{ subject.touch_in }.to raise_error(RuntimeError, "Error, Insufficient Funds")
    end
  end
  describe "#touch_out" do
    it "switches the state of use to not in_journey?"do
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end
    it "deducts the fare from the balance" do
      subject.top_up(30)
      expect { subject.touch_out}.to change{subject.balance}.by(-OysterCard::MIN)
    end
  end
    end
