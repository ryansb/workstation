all: slack evince shellcheck bluejeans

clean:
	docker images --format '{{ .Repository }} {{ .ID }}' | grep ryansb | cut -f2 -d' ' | sort | uniq | xargs docker rmi -f

slack: slack.phony

slack.phony:
	docker build slack -t ryansb/slack:$$(date +%Y-%m-%d)
	docker build slack -t ryansb/slack:latest

evince: evince.phony

evince.phony:
	docker build evince -t ryansb/evince:$$(date +%Y-%m-%d)
	docker build evince -t ryansb/evince:latest

shellcheck: shellcheck.phony

shellcheck.phony:
	docker build shellcheck -t ryansb/shellcheck:$$(date +%Y-%m-%d)
	docker build shellcheck -t ryansb/shellcheck:latest

former: former.phony

former.phony:
	docker build former -t ryansb/former:latest

bluejeans: bluejeans.phony

bluejeans.phony:
	docker build bluejeans -t ryansb/bluejeans:$$(date +%Y-%m-%d)
	docker build bluejeans -t ryansb/bluejeans:latest
