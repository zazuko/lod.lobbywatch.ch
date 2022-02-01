function filterEmpty(quad) {

    if ((quad.predicate.value === "https://lod.lobbywatch.ch/organizationType") && (quad.object.value === "https://lod.lobbywatch.ch/organization-type/")) {
        return false
    }

    return true
}

function filterProcessedLegalForm(quad) {
    if ((quad.predicate.value === "https://lod.lobbywatch.ch/legalForm")) {
        return false
    }

    return true
}

function filterAll(quad) {
    return filterProcessedLegalForm(filterEmpty(quad))
}

module.exports = { filterAll, filterEmpty }
