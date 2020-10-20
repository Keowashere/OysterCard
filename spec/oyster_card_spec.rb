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

  describe "#in_journey?" do
    it "return the state" do
      expect(subject.in_journey?).to eq(nil)
    end
  end
  describe "#touch_in" do
    let(:entry_station) {double :entry_station}
    it "switches the state of use to in_journey?" do
      subject.top_up(30)
      subject.touch_in(:entry_station)
      expect(subject.in_journey?).to eq(true)
    end
    it "know where I've travelled from" do
    subject.top_up(30)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq(entry_station)
    end
    it "raises an error if balance is less than MIN" do
      expect{ subject.touch_in(:entry_station) }.to raise_error(RuntimeError, "Error, Insufficient Funds")
    end
  end
  describe "#touch_out" do

    let (:entry_station) {double :station}
    let (:exit_station) {double :station}
    it "it stores entry and exits stations" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    expect(subject.exit_station).to eq entry_station
    end

    it "switches the state of use to not in_journey?" do
      subject.touch_out(:exit_station)
    expect(subject.in_journey?).to eq(false)
    end
    it "deducts the fare from the balance" do
      subject.top_up(30)
    expect { subject.touch_out(:exit_station)}.to change{subject.balance}.by(-OysterCard::MIN)
    end
  end
end
