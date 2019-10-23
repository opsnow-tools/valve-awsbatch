# valve-awsbatch

## example
* batch-only or batch-with-vpc 실행
  * AWS Batch 인프라를 생성합니다. (compute environment, job queue, ...)
  * batch-with-vpc 는 Batch를 위한 별도의 VPC를 생성합니다.
* batch-to-alertnow
  * 배치 작업 실패 시 AlertNow와 연동하여 인시던트를 생성합니다.
  * AWS CloudWatch Event, Log, Alarm, Simple Notificatio Service(SNS) 등의 AWS 서비스 자원을 생성합니다.
* batch-job
  * 배치 작업을 정의하기 위한 샘플 입니다.

## example 테스트 방법

### 사전 준비
* terraform 설치
* aws access/secret key
* .tfstate 파일 저장을 위한 S3 버킷 생성 및 버킷명 변경(코드에는 seoul-sre-batch-state 를 사용하고 있음)

### 실행
#### 환경 구성 순서
* batch(batch-only, batch-with-vpc)
* batch-to-alertnow
* batch-job

#### 리소스 생성
환경 구성 순서로 각 디렉토리로 이동해서 다음을 수행
```
terraform init # 테라폼 스크립트 오류 검증, 설치에 필요한 모듈 다운로드
terraform plan # 변경 리소스 확인
terraform apply # 변경 리소스 적용
```

#### 테스트
작업을 작업 큐에 등록해서 작업을 실행
```
cd test
aws batch submit-job --cli-input-json file://submit_job.json
```

#### 리소스 삭제
환경 구성 역순으로 각 디렉토리로 이동해서 다음을 수행
```
terraform destroy
```

## Batch 개발
우선 Batch, batch-to-alertnow 를 사용해 배치 인프라를 구성해야 합니다.
위 프로젝트는 모듈 형태로 직접 사용하지 않고 환경별로 별도의 git 레파지토리에 해당 코드를 복제해서 인프라 구성 코드를 작성해야 합니다. 이렇게 코드를 복제해서 사용하는 이유는 코드가 변경되더라도 운영중인 인프라에 영향을 주지 않기 위해서 입니다.

Batch-job의 경우 샘플 코드를 제공합니다. Job은 인프라 정의가 아니라 어플리케이션 구성을 위한 설정이기 때문에 샘플 코드를 참고해서 개발을 진행해야 합니다.

### Batch 프로젝트 디렉토리 샘플

* opsnow-batch-infa
  * dev
    * batch
      * modules(valve-awsbatch/examples/batch-only 폴더 복사, batch-with-vpc로 대체 가능)
      * main.tf
    * batch-to-alertnow
      * modules(valve-awsbatch/examples/batch-to-alertnow 폴더 복사)
      * main.tf
  * prod
    * batch
      * modules(valve-awsbatch/examples/batch-only 폴더 복사, batch-with-vpc로 대체 가능)
      * main.tf
    * batch-to-alertnow
      * modules(valve-awsbatch/examples/batch-to-alertnow 폴더 복사)
      * main.tf

* xwing-da-batch-job
  * dev
    * batch-job
      * job-name.tf
      * ...
      * locals.tf 
      * main.tf
  * prod
    * batch-job
      * job-name.tf
      * ...
      * locals.tf 
      * main.tf
