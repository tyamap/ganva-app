require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'validation' do
    # User 定義
    let(:spidey) {build :user, :with_commit_activities}
    let(:ironman) {build :user, :with_result_activities}
    
    # 宣言と結果
    let(:commit_act) {spidey.activities.first}
    let(:result_act) {ironman.activities.first}

    # 現在日時
    let(:dt_now) {Time.current}

    # 日付
    let(:today) {dt_now.strftime("%Y-%m-%d")}
    let(:yesterday) {dt_now.yesterday.strftime("%Y-%m-%d")}
    let(:tomorrow) {dt_now.tomorrow.strftime("%Y-%m-%d")}

    # 時間
    let(:nowtime) {dt_now.strftime("%H:%M:%S")} 
    let(:hour_ago) {dt_now.ago(1.hours).strftime("%H:%M:%S")} 
    let(:two_hour_ago) {dt_now.ago(2.hours).strftime("%H:%M:%S")} 
    let(:hour_togo) {dt_now.since(1.hours).strftime("%H:%M:%S")} 
    let(:two_hour_togo) {dt_now.since(2.hours).strftime("%H:%M:%S")} 

    example '開始時刻が終了時刻より前のものは登録できない' do
      commit_act.date = today
      commit_act.start_time = two_hour_togo
      commit_act.end_time = hour_togo
      expect(commit_act).not_to be_valid
    end
    example '開始時刻が終了時刻と等しいものは登録できない' do
      commit_act.date = today
      commit_act.start_time = hour_togo
      commit_act.end_time = hour_togo
      expect(commit_act).not_to be_valid
    end
    example '開始時刻が終了時刻より１秒前のものは登録できない' do
      commit_act.date = yesterday
      commit_act.start_time = '14:00:01'
      commit_act.end_time = '14:00:00'
      commit_act.status = Settings.activity.status_done
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
          commit_act.status = Settings.activity.status_ready

          # 前提条件の確認
          expect(commit_act.start_datetime > dt_now).to be_truthy
          # テスト
          expect(commit_act).to be_valid
        end

        example '開始時刻が現在時刻より過去のものは登録できない' do
          commit_act.date = today
          commit_act.start_time = two_hour_ago
          commit_act.end_time = hour_togo
          commit_act.status = Settings.activity.status_ready

          expect(commit_act.start_datetime < dt_now).to be_truthy
          expect(commit_act).not_to be_valid
        end
      end

      describe 'aborted' do
        example '終了時刻が現在時刻より未来のものを登録できる' do
          commit_act.date = today
          commit_act.start_time = hour_togo
          commit_act.end_time = two_hour_togo
          commit_act.status = Settings.activity.status_aborted

          expect(commit_act.end_datetime > dt_now).to be_truthy
          expect(commit_act).to be_valid
        end

        example '終了時刻が現在時刻より過去のものは登録できない' do
          commit_act.date = today
          commit_act.start_time = two_hour_ago
          commit_act.end_time = hour_ago
          commit_act.status = Settings.activity.status_aborted

          expect(commit_act.end_datetime < dt_now).to be_truthy
          expect(commit_act).not_to be_valid
        end
      end

      describe 'done' do
        example '開始時刻が現在時刻より過去のものを登録できる' do
          commit_act.date = today
          commit_act.start_time = two_hour_ago
          commit_act.end_time = hour_togo
          commit_act.status = Settings.activity.status_done

          expect(commit_act.start_datetime < dt_now).to be_truthy
          expect(commit_act).to be_valid
        end

        example '開始時刻が現在時刻より未来のものは登録できない' do
          commit_act.date = today
          commit_act.start_time = hour_togo
          commit_act.end_time = two_hour_togo
          commit_act.status = Settings.activity.status_done

          expect(commit_act.start_datetime > dt_now).to be_truthy
          expect(commit_act).not_to be_valid
        end
      end

      describe 'recorded' do
        example '終了時刻が現在時刻より過去のものを登録できる' do
          commit_act.date = today
          commit_act.start_time = two_hour_ago
          commit_act.end_time = hour_ago
          commit_act.status = Settings.activity.status_result

          expect(commit_act.end_datetime < dt_now).to be_truthy
          expect(commit_act).to be_valid
        end
        
        example '終了時刻が現在時刻より未来のものは登録できない' do
          commit_act.date = today
          commit_act.start_time = hour_togo
          commit_act.end_time = two_hour_togo
          commit_act.status = Settings.activity.status_result

          expect(commit_act.end_datetime > dt_now).to be_truthy
          expect(commit_act).not_to be_valid
        end
      end
    end

    #
    # ステータス変更
    #
    describe 'update status' do
      example 'ready から aborted に変更できる' do
        spidey.save!
        expect(spidey.activities.first.status).to eq Settings.activity.status_ready
        expect(spidey.activities.first.update(status: Settings.activity.status_aborted)).to be_truthy
      end

      example 'ready から done に変更できる' do
        spidey.save!
        expect(spidey.activities.first.status).to eq Settings.activity.status_ready
        expect(spidey.activities.first.update(status: Settings.activity.status_done)).to be_truthy
      end

      example 'ready から recorded に変更できる' do
        spidey.save!
        expect(spidey.activities.first.status).to eq Settings.activity.status_ready
        expect(spidey.activities.first.update(status: Settings.activity.status_recorded)).to be_truthy
      end

      example 'aborted から ready に変更できる' do
        spidey.activities.first.status = Settings.activity.status_aborted
        spidey.save!
        expect(spidey.activities.first.status).to eq Settings.activity.status_aborted
        expect(spidey.activities.first.update(status: Settings.activity.status_ready)).to be_truthy
      end

      example 'aborted から done に変更できない' do
        spidey.activities.first.status = Settings.activity.status_aborted
        spidey.save!
        expect(spidey.activities.first.status).to eq Settings.activity.status_aborted
        expect(spidey.activities.first.update(status: Settings.activity.status_done)).to be_falsey
      end

      example 'aborted から recorded に変更できない' do
        spidey.activities.first.status = Settings.activity.status_aborted
        spidey.save!
        expect(spidey.activities.first.status).to eq Settings.activity.status_aborted
        expect(spidey.activities.first.update(status: Settings.activity.status_recorded)).to be_falsey
      end

      example 'done から ready に変更できない' do
        spidey.activities.first.status = Settings.activity.status_done
        spidey.save!
        expect(spidey.activities.first.status).to eq Settings.activity.status_done
        expect(spidey.activities.first.update(status: Settings.activity.status_ready)).to be_falsey
      end

      example 'done から aborted に変更できない' do
        spidey.activities.first.status = Settings.activity.status_done
        spidey.save!
        expect(spidey.activities.first.status).to eq Settings.activity.status_done
        expect(spidey.activities.first.update(status: Settings.activity.status_aborted)).to be_falsey
      end

      example 'done から recorded に変更できる' do
        spidey.activities.first.status = Settings.activity.status_done
        spidey.save!
        expect(spidey.activities.first.status).to eq Settings.activity.status_done
        expect(spidey.activities.first.update(status: Settings.activity.status_recorded)).to be_truthy
      end

      example 'recorded から ready には変更できない' do
        ironman.save!
        expect(ironman.activities.first.status).to eq Settings.activity.status_recorded
        expect(ironman.activities.first.update(status: Settings.activity.status_ready)).to be_falsey
      end

      example 'recorded から done には変更できない' do
        ironman.save!
        expect(ironman.activities.first.status).to eq Settings.activity.status_recorded
        expect(ironman.activities.first.update(status: Settings.activity.status_done)).to be_falsey
      end

      example 'recorded から aborted には変更できない' do
        ironman.save!
        expect(ironman.activities.first.status).to eq Settings.activity.status_recorded
        expect(ironman.activities.first.update(status: Settings.activity.status_aborted)).to be_falsey
      end
    end
  end
end
