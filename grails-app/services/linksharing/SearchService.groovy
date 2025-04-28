package linksharing

import groovy.transform.CompileStatic

@CompileStatic
class SearchService {

    def searchAll(String query) {
        String searchTerm = "%${query}%".toLowerCase()

        def topics = Topic.createCriteria().list {
            ilike("name", searchTerm)
        }

        def resources = Resource.createCriteria().list {
            ilike("description", searchTerm)
        }

        return [topics: topics, resources: resources]
    }
}