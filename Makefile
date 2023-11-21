.phony: alpine/amd64
alpine/amd64:
	docker build --platform=linux/amd64 --build-arg="VERSION=3.8"  --output=alpine-amd64/3.8/  -f dockerfiles/alpine-amd64.dockerfile dockerfiles
	docker build --platform=linux/amd64 --build-arg="VERSION=3.9"  --output=alpine-amd64/3.9/  -f dockerfiles/alpine-amd64.dockerfile dockerfiles
	docker build --platform=linux/amd64 --build-arg="VERSION=3.10" --output=alpine-amd64/3.10/ -f dockerfiles/alpine-amd64.dockerfile dockerfiles
	docker build --platform=linux/amd64 --build-arg="VERSION=3.11" --output=alpine-amd64/3.11/ -f dockerfiles/alpine-amd64.dockerfile dockerfiles
	docker build --platform=linux/amd64 --build-arg="VERSION=3.12" --output=alpine-amd64/3.12/ -f dockerfiles/alpine-amd64.dockerfile dockerfiles
	docker build --platform=linux/amd64 --build-arg="VERSION=3.13" --output=alpine-amd64/3.13/ -f dockerfiles/alpine-amd64.dockerfile dockerfiles
	docker build --platform=linux/amd64 --build-arg="VERSION=3.14" --output=alpine-amd64/3.14/ -f dockerfiles/alpine-amd64.dockerfile dockerfiles
	docker build --platform=linux/amd64 --build-arg="VERSION=3.15" --output=alpine-amd64/3.15/ -f dockerfiles/alpine-amd64.dockerfile dockerfiles
	docker build --platform=linux/amd64 --build-arg="VERSION=3.16" --output=alpine-amd64/3.16/ -f dockerfiles/alpine-amd64.dockerfile dockerfiles
	docker build --platform=linux/amd64 --build-arg="VERSION=3.17" --output=alpine-amd64/3.17/ -f dockerfiles/alpine-amd64.dockerfile dockerfiles
	docker build --platform=linux/amd64 --build-arg="VERSION=3.18" --output=alpine-amd64/3.18/ -f dockerfiles/alpine-amd64.dockerfile dockerfiles

.phony: alpine/arm64
alpine/arm64:
	docker build --platform=linux/arm64 --build-arg="VERSION=3.8"  --output=alpine-arm64/3.8/  -f dockerfiles/alpine-arm64.dockerfile dockerfiles
	docker build --platform=linux/arm64 --build-arg="VERSION=3.9"  --output=alpine-arm64/3.9/  -f dockerfiles/alpine-arm64.dockerfile dockerfiles
	docker build --platform=linux/arm64 --build-arg="VERSION=3.10" --output=alpine-arm64/3.10/ -f dockerfiles/alpine-arm64.dockerfile dockerfiles
	docker build --platform=linux/arm64 --build-arg="VERSION=3.11" --output=alpine-arm64/3.11/ -f dockerfiles/alpine-arm64.dockerfile dockerfiles
	docker build --platform=linux/arm64 --build-arg="VERSION=3.12" --output=alpine-arm64/3.12/ -f dockerfiles/alpine-arm64.dockerfile dockerfiles
	docker build --platform=linux/arm64 --build-arg="VERSION=3.13" --output=alpine-arm64/3.13/ -f dockerfiles/alpine-arm64.dockerfile dockerfiles
	docker build --platform=linux/arm64 --build-arg="VERSION=3.14" --output=alpine-arm64/3.14/ -f dockerfiles/alpine-arm64.dockerfile dockerfiles
	docker build --platform=linux/arm64 --build-arg="VERSION=3.15" --output=alpine-arm64/3.15/ -f dockerfiles/alpine-arm64.dockerfile dockerfiles
	docker build --platform=linux/arm64 --build-arg="VERSION=3.16" --output=alpine-arm64/3.16/ -f dockerfiles/alpine-arm64.dockerfile dockerfiles
	docker build --platform=linux/arm64 --build-arg="VERSION=3.17" --output=alpine-arm64/3.17/ -f dockerfiles/alpine-arm64.dockerfile dockerfiles
	docker build --platform=linux/arm64 --build-arg="VERSION=3.18" --output=alpine-arm64/3.18/ -f dockerfiles/alpine-arm64.dockerfile dockerfiles
