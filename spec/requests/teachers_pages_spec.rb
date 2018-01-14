require 'rails_helper'

RSpec.describe "TeachersPages", type: :request do
  
    subject {page}
    
    #教师注册测试代码
    describe "teacher register" do
        before {visit teachers_entry_path}
        
        let(:register) { "注册" }
        
        describe "with invalid information" do
           it "should not create a teacher" do
              expect { click_button register }.not_to change(Teacher, :count) 
           end
        end
        
        describe "with valid information" do
            before do
                fill_in "username", with: "何以忘忧"
                fill_in "email", with: "1096221716@qq.com"
                fill_in "password", with: "123456"
            end
            
            it "should create a teacher" do
               expect { click_button register }.to change(Teacher, :count).by(1) 
            end
        end
        #其他注册用例
        
        
        
    end
    
    #教师登录测试代码
    describe "teacher login" do
        before {visit teachers_entry_path}
        
        let(:login) { "登录" }
        
        describe "with invalid information" do
            before do
                fill_in "email_1", with: "1096221@qq.com"
                fill_in "password_1", with: "12345"
                click_button '登录' 
            end
            
           #it { should have_title('教师入口|TA 教学助手') } 
           it { should have_selector('div.error', text: '登录失败') } 
        end
        
        #describe "with valid information" do
        #    let(:teacher) { FactoryGirl.create(:teachers) } 
        #    before do
        #        fill_in "email_1", with: teacher.email.upcase
        #        fill_in "password_1", with: teacher.password
        #        click_button '登录' 
        #    end
            
           #it { should have_title('教师主页') } 
           #it { should have_link('退出登录', href: teachers_entry_path) }
        #   it { should have_selector('div.info', text: '登录成功') } 
        #end
    end
end
