# coding: utf-8
require 'spec_helper'

describe Dummy do
  let(:dummy) { described_class.new(latitude: 7, longitude: 11) }

  it { expect(dummy).to respond_to(:coordinates) }

  it { expect(dummy).to respond_to(:latitude) }
  it { expect(dummy).to respond_to(:latitude=) }
  it { expect(dummy).to respond_to(:latitude_will_change!) }
  it { expect(dummy).to respond_to(:latitude_changed?) }

  it { expect(dummy).to respond_to(:longitude) }
  it { expect(dummy).to respond_to(:longitude=) }
  it { expect(dummy).to respond_to(:longitude_will_change!) }
  it { expect(dummy).to respond_to(:longitude_changed?) }

  describe '#latitude' do
    it { expect(dummy.latitude).to eq 7 }
  end

  describe '#longitude' do
    it { expect(dummy.longitude).to eq 11 }
  end

  describe '#latitude=' do
    it { expect { dummy.latitude = 14 }.to change { dummy.latitude }.from(7).to(14) }
  end

  describe '#longitude=' do
    it { expect { dummy.longitude = 22 }.to change { dummy.longitude }.from(11).to(22) }
  end

  describe '#latitude_will_change!' do
    before { dummy.latitude_will_change! }

    it { expect(dummy).to be_latitude_changed }
  end

  describe '#longitude_will_change!' do
    before { dummy.longitude_will_change! }

    it { expect(dummy).to be_longitude_changed }
  end

  context 'when is new record' do
    describe 'latitude_changed?' do
      it { expect(dummy).to be_latitude_changed }
    end

    describe 'longitude_changed?' do
      it { expect(dummy).to be_longitude_changed }
    end
  end

  context 'when record is persisted' do
    let(:dummy) { described_class.create(latitude: 7, longitude: 11) }

    describe 'latitude_changed?' do
      context 'when latitude is changed' do
        before { dummy.latitude = 7 }

        it { expect(dummy).not_to be_latitude_changed }
      end

      context 'when latitude is changed' do
        before { dummy.latitude = 14 }

        it { expect(dummy).to be_latitude_changed }
      end
    end

    describe 'longitude_changed?' do
      context 'when longitude is changed' do
        before { dummy.longitude = 11 }

        it { expect(dummy).not_to be_longitude_changed }
      end

      context 'when longitude is changed' do
        before { dummy.longitude = 22 }

        it { expect(dummy).to be_longitude_changed }
      end
    end
  end
end
