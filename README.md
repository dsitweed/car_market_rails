# README

## Settings version:

- rbenv: rbenv 1.2.0-72-g5d78e47

- Ruby version: ruby 3.2.2 (2023-03-30 revision e51014f9c0) [x86_64-linux]

- Rails version: Rails 7.0.8.4

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

## Command line logs

```bash
rails new car_market

rails db:drop db:reset db:create

rails generate model User email:string:index name:string password_digest:string remember_digest:string role:integer activation_digest:string activated:boolean activated_at:datetime reset_digest:string reset_sent_at:datetime

```

# Thêm config cho test

1. Thêm màu sắc của test case

- Thêm config vào file: test_helper.rb

```ruby
require "minitest/reporters"
Minitest::Reporters.use!
```

cài thư viện:

```ruby
  gem "capybara",                 "3.37.1"
  gem "selenium-webdriver",       "4.2.0"
  gem "webdrivers",               "5.0.0"
  gem "rails-controller-testing", "1.0.5"
  gem "minitest",                 "5.15.0" # hai cái để thêm màu
  gem "minitest-reporters",       "1.5.0" # Thêm màu cho test case
  gem "guard",                    "2.18.0" # Thiết lập tự động chạy test case khi controller thay đổi
  gem "guard-minitest",           "2.4.6"
```

2. Thiết lập tự chạy test-case

- Cài gem guard
- chạy câu lệnh để sử dụng

```ruby
bundle exec guard init # Khởi tạo file  Guardfile tự sửa file hoặc lấy code ngon nghẻ ở đây: https://github.com/learnenough/rails_tutorial_sample_app_7th_ed/blob/main/Guardfile
bundle exec guard # chạy window để chờ kết quả chạy test case mỗi khi quy ước trong file GuardFile có hiệu lực
```

# Kiến thức nền tảng về Ruby

- Đang thiếu trầm trọng cần bổ sung thêm

```ruby
# Class trong ruby
class User
  attr_accessor :name, :email

  def initialize(attributes = {})
    @name = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end
end
```

3. Unit test

```ruby
rails generate integration_test site_layout
# invoke  test_unit
# create    test/integration/site_layout_test.rb
# rails test:integration
```

4. Môi trường test sau khi test sẽ được rollback

```ruby
rails console --sandbox
# ví dụ về việc realod giá trị - giá trị reaload là giá trị được lưu ở database
object.reload.email
```

5. Hỗ trợ debugging với inspect

```ruby
@user = User.new(name: 'example', :email: 'test@gmail.com')
@user.inspect
# duplicate user - 1 hàm rất hay
@user.dup
```

6. Debug in rails
   thêm config debug

```ruby
# thêm ở cuối application_layouts đẻ hiển thị các thông tin cơ bản lên web
 <%= debug (params) if Rails.env.development? %>
# Sau đó thêm dòng debugger để có thể chạy chi tiết trong console: rdbg (Ruby debugger)

debugger

Crtl + D để out ruby debugger
# gem mặc định đã có để debug
gem "debug", platforms: %i(mri mingw x64_mingw)
```

7. Hàm hỗ trợ số nhiều pluralize

```bash
>> helper.pluralize(1, "error")
=> "1 error"
>> helper.pluralize(5, "error")
=> "5 errors"
```

8. Xóa toàn bộ dữ liệu

```bash
rails db:migrate:reset
```

9. Test thành phần

```bash
rails test:integration
rails test test/...path
```

10. Run seed data

```bash
rails db:migrate:reset
rails db:seed
# 2 in 1
rails db:reset
```

11. Thư viện nén ảnh

```bash
sudo apt-get -y install imagemagick
```

12. Làm việc với Hotwire - Tương tự như reactjs không cần phải load lại page
    Cách hoạt động:
    > > Turbo works via so-called Turbo streams to send small snippets of HTML directly to the page using WebSockets, which is a technology that allows for a persistent connection between the client (e.g., a web browser) and the web server.11 Our strategy is to handle Turbo requests and regular requests (as implemented in Section 14.2.4) in a unified way using the important respond_to method, which follows a pattern that looks like this:12

Viết các phản hồi từ controller

```ruby
respond_to do |format|
   format.html { redirect_to user, status: :see_other }
   format.turbo_stream
end
```

Giải quyết phản hồi hiện ra view ở file: <action>.turbo_stream.erb 13. Luôn luôn ghi nhớ sử dung Eager Loading
