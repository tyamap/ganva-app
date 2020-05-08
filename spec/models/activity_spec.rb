require 'rails_helper'

RSpec.describe Activity, type: :model do
  around do |e|
    travel_to(Time.zone.parse('2020-4-1 12:30')) {e.run}
  end
  
  # 宣言と結果
  let(:commit_act) {build :activity}

  # 現在日時
  let(:dt_now) {Time.zone.parse('2020-4-1 12:30')}

  # 日付
  let(:today) {dt_now.strftime("%Y-%m-%d")}
  let(:yesterday) {dt_now.yesterday.strftime("%Y-%m-%d")}
  let(:tomorrow) {dt_now.tomorrow.strftime("%Y-%m-%d")}

  # 時間
  let(:nowtime) {dt_now.strftime("%H:%M")} 
  let(:hour_ago) {dt_now.ago(1.hours).strftime("%H:%M")} 
  let(:two_hour_ago) {dt_now.ago(2.hours).strftime("%H:%M")} 
  let(:hour_togo) {dt_now.since(1.hours).strftime("%H:%M")} 
  let(:two_hour_togo) {dt_now.since(2.hours).strftime("%H:%M")} 

  describe 'validation' do

    example '開始時刻が終了時刻より後のものは登録できない' do
      commit_act.date = today
      commit_act.start_time = two_hour_togo
      commit_act.end_time = hour_togo
      expect(commit_act.start_datetime > commit_act.end_datetime).to be_truthy
      expect(commit_act).not_to be_valid
    end
    example '開始時刻が終了時刻と等しいものは登録できない' do
      commit_act.date = today
      commit_act.start_time = hour_togo
      commit_act.end_time = hour_togo
      expect(commit_act.start_datetime == commit_act.end_datetime).to be_truthy
      expect(commit_act).not_to be_valid
    end
    example '開始時刻が終了時刻より１秒後のものは登録できない' do
      commit_act.date = today
      commit_act.start_time = dt_now.since(60.seconds).strftime("%H:%M:%S")
      commit_act.end_time = dt_now.since(59.seconds).strftime("%H:%M:%S")
      expect(commit_act.start_datetime - commit_act.end_datetime).to eq 1.0
      expect(commit_act).not_to be_valid
    end

    #
    # ステータスの設定
    #
    describe 'status' do
      example '既定の文字列以外は登録できない' do
        commit_act.status = 'hogefuga'
        expect(commit_act).not_to be_valid
      end

      describe 'ready' do
        example '開始時刻が現在時刻より未来のものを登録できる' do
          commit_act.date = today
          commit_act.start_time = hour_togo
          commit_act.end_time = two_hour_togo
          commit_act.status = Settings.activity.status.ready

          # 前提条件の確認
          expect(commit_act.start_datetime > dt_now).to be_truthy
          # テスト
          expect(commit_act).to be_valid
        end

        example '開始時刻が現在時刻より過去のものは登録できない' do
          commit_act.date = today
          commit_act.start_time = two_hour_ago
          commit_act.end_time = hour_togo
          commit_act.status = Settings.activity.status.ready

          expect(commit_act.start_datetime < dt_now).to be_truthy
          expect(commit_act).not_to be_valid
        end
      end

      describe 'aborted' do
        example '終了時刻が現在時刻より未来のものを登録できる' do
          commit_act.date = today
          commit_act.start_time = hour_togo
          commit_act.end_time = two_hour_togo
          commit_act.status = Settings.activity.status.aborted
          expect(commit_act.end_datetime > dt_now).to be_truthy
          expect(commit_act).to be_valid
        end

        example '終了時刻が現在時刻より過去のものは登録できない' do
          commit_act.date = today
          commit_act.start_time = two_hour_ago
          commit_act.end_time = hour_ago
          commit_act.status = Settings.activity.status.aborted

          expect(commit_act.end_datetime < dt_now).to be_truthy
          expect(commit_act).not_to be_valid
        end
      end

      describe 'done' do
        example '開始時刻が現在時刻より過去のものを登録できる' do
          commit_act.date = today
          commit_act.start_time = two_hour_ago
          commit_act.end_time = hour_togo
          commit_act.status = Settings.activity.status.done

          expect(commit_act.start_datetime < dt_now).to be_truthy
          expect(commit_act).to be_valid
        end

        example '開始時刻が現在時刻より未来のものは登録できない' do
          commit_act.date = today
          commit_act.start_time = hour_togo
          commit_act.end_time = two_hour_togo
          commit_act.status = Settings.activity.status.done

          expect(commit_act.start_datetime > dt_now).to be_truthy
          expect(commit_act).not_to be_valid
        end
      end

      describe 'recorded' do
        example '終了時刻が現在時刻より過去のものを登録できる' do
          commit_act.date = today
          commit_act.start_time = two_hour_ago
          commit_act.end_time = hour_ago
          commit_act.status = Settings.activity.status.recorded

          expect(commit_act.end_datetime < dt_now).to be_truthy
          expect(commit_act).to be_valid
        end
        
        example '終了時刻が現在時刻より未来のものは登録できない' do
          commit_act.date = today
          commit_act.start_time = hour_togo
          commit_act.end_time = two_hour_togo
          commit_act.status = Settings.activity.status.recorded

          expect(commit_act.end_datetime > dt_now).to be_truthy
          expect(commit_act).not_to be_valid
        end
      end
    end
  end

  #
  # ステータス変更
  #
  describe 'update' do
    describe 'status' do
      example 'ready から aborted に変更できる' do
        act = create :activity
        expect(act.status).to eq Settings.activity.status.ready
        expect(act.update(date: tomorrow, status: Settings.activity.status.aborted)).to be_truthy
      end

      example 'ready から done に変更できる' do
        act = create :activity
        expect(act.status).to eq Settings.activity.status.ready
        expect(act.update(date: yesterday, status: Settings.activity.status.done)).to be_truthy
      end

      example 'ready から recorded に変更できる' do
        act = create :activity
        expect(act.status).to eq Settings.activity.status.ready
        expect(act.update(date: yesterday, status: Settings.activity.status.recorded)).to be_truthy
      end

      example 'aborted から ready に変更できる' do
        act = create :activity, :with_aborted
        expect(act.status).to eq Settings.activity.status.aborted
        expect(act.update(date: tomorrow, status: Settings.activity.status.ready)).to be_truthy
      end

      example 'aborted から done に変更できない' do
        act = create :activity, :with_aborted
        expect(act.status).to eq Settings.activity.status.aborted
        expect(act.update(date: yesterday, status: Settings.activity.status.done)).to be_falsey
      end

      example 'aborted から recorded に変更できない' do
        act = create :activity, :with_aborted
        expect(act.status).to eq Settings.activity.status.aborted
        expect(act.update(date: yesterday, status: Settings.activity.status.recorded)).to be_falsey
      end

      example 'done から ready に変更できない' do
        act = create :activity, :with_done
        expect(act.status).to eq Settings.activity.status.done
        expect(act.update(date: tomorrow, status: Settings.activity.status.ready)).to be_falsey
      end

      example 'done から aborted に変更できない' do
        act = create :activity, :with_done
        expect(act.status).to eq Settings.activity.status.done
        expect(act.update(date: tomorrow, status: Settings.activity.status.aborted)).to be_falsey
      end

      example 'done から recorded に変更できる' do
        act = create :activity, :with_done
        expect(act.status).to eq Settings.activity.status.done
        expect(act.update(date: yesterday, status: Settings.activity.status.recorded)).to be_truthy
      end

      example 'recorded から ready には変更できない' do
        act = create :activity, :with_recorded
        expect(act.status).to eq Settings.activity.status.recorded
        expect(act.update(date: tomorrow, status: Settings.activity.status.ready)).to be_falsey
      end

      example 'recorded から done には変更できない' do
        act = create :activity, :with_recorded
        expect(act.status).to eq Settings.activity.status.recorded
        expect(act.update(date: yesterday, status: Settings.activity.status.done)).to be_falsey
      end

      example 'recorded から aborted には変更できない' do
        act = create :activity, :with_recorded
        expect(act.status).to eq Settings.activity.status.recorded
        expect(act.update(date: tomorrow, status: Settings.activity.status.aborted)).to be_falsey
      end
    end
  end
end
