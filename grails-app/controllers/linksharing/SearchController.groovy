package linksharing

class SearchController {

    SearchService searchService

    def index() {
        String query = params.query?.trim()

        if(!query) {
            redirect(uri: request.getHeader("referer"))
        }

        Map res = searchService.searchAll(query)

        def topicNames = Topic.list()*.name

        def topics = res.topics
        def resources = res.resources

        [topics: topics, resources: resources, query: query, topicNames: topicNames]
    }
}