### Ruby version
* ruby 2.5.3
* Rails >= 5.2.1

### 설정
git repository를 Fork 또는 Clone
```bash
$ git clone https://github.com/Jongjineee/oEmbed-project
```

### Gem 설치
```bash
$ cd itdaa
$ bundle install
```

### up and running(Test your installation)
여기까지 완료되었다면 개발 서버를 실행할 수 있으며
```bash
$ bin/rails s 
```
그리고 브라우저에서 localhost:3000에 연결합니다.

### 프로젝트 설명
URL을 입력받고 oEmbed 데이터를 수집하여 보여주는 서비스입니다.
URL을 입력받는 폼에 URL을 입력하고 확인 버튼을 누르면 해당 URL에 대한 oembed 정보를 출력하고 html값과 thumbnail_url은 미리보기로 보여줍니다.

![preview](https://github.com/Jongjineee/oEmbed-project/blob/master/app/assets/images/preview.png)

### 참고 사이트
http://oembed.com/
