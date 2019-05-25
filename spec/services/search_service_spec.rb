require 'rails_helper'

RSpec.describe Services::Search do
  let(:params_for_question) { {"query"=>"text", "question"=>"1" } }
  let(:params_for_all_models) { {"query"=>"text" } }
  let(:question) { create :question, body: 'text'}

  it 'invokes search process for ThinkingSphinx' do
    expect(ThinkingSphinx).to receive(:search)
    subject.result(params_for_question)
  end

  it 'searches for questions' do
    expect(ThinkingSphinx).to receive(:search).with("text", {classes: [Question], :page=>nil, :per_page=>10})
    subject.result(params_for_question)
  end

  it 'searches thru all models' do
    expect(ThinkingSphinx).to receive(:search).with("text", {classes: [], :page=>nil, :per_page=>10})
    subject.result(params_for_all_models)
  end
end