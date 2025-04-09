package linksharing

class LinkResource extends Resource {
    String url

    static constraints = {
        url nullable: false, blank: false
    }
}