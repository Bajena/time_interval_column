require 'rails_helper'

describe TimeIntervalColumn do
  let(:options) { {} }

  before do
    DummyModel.time_interval_column :time_interval, options: options
  end

  describe "options" do
    describe "attr_accessor" do
      let(:options) { { attr_accessor: false } }

      it "generates attr_accessors" do
        model = DummyModel.new
        model.assign_attributes({ time_interval_type: 'month', time_interval_value: 10 })

        expect(model.valid?).to eq(true)
      end
    end
  end

  describe "column_name method" do
    it "Extends the class with column_name method" do
      DummyModel.time_interval_column :time_interval
      expect(DummyModel.new.public_methods).to include(:time_interval)
    end

    it "Returns time interval as ActiveSupport Duration (Fixnum) using column_name_value and column_name_type columns" do
      model = DummyModel.new
      model.time_interval_value = 10

      ['year', 'month', 'day', 'hour', 'minute', 'second'].each do |type|
        model.time_interval_type = type
        expect(model.time_interval).to eq(10.send(type))
      end
    end

    it "Returns nil if the value column is empty" do
      model = DummyModel.new
      model.time_interval_value = nil

      ['year', 'month', 'day', 'hour', 'minute', 'second'].each do |type|
        model.time_interval_type = type
        expect(model.time_interval).to eq(nil)
      end
    end
  end

  describe "column_name= method" do
    it "Extends the class with column_name method" do
      DummyModel.time_interval_column :time_interval
      expect(DummyModel.new.public_methods).to include(:time_interval=)
    end

    it "Accepts ActiveSupport Duration (Fixnum) and sets time interval value and type using column_name_value and column_name_type columns" do
        model = DummyModel.new

        ['year', 'month', 'day', 'hour', 'minute', 'second'].each do |type|
          model.time_interval = 20.send(type)

          expect(model.time_interval).to eq(20.send(type))
          expect(model.time_interval_type).to eq(type)
          expect(model.time_interval_value).to eq(20)
        end
    end


    it "Sets column_name_value to nil if passed value is nil" do
      model = DummyModel.new

      model.time_interval = nil
      expect(model.time_interval_value).to eq(nil)
    end
  end
end