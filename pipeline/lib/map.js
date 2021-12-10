const rdf = require('rdf-ext');

function mapCouncils(quad) {

    let subject = quad.subject
    let object = quad.object

    if (subject.value.startsWith('https://politics.ld.admin.ch/council/1')) {
        subject = rdf.namedNode(subject.value.replace('council/1', 'council/N'))
    }
    else if (subject.value.startsWith('https://politics.ld.admin.ch/council/2')) {
        subject = rdf.namedNode(subject.value.replace('council/2', 'council/S'))
    }
    else if (subject.value.startsWith('https://politics.ld.admin.ch/council/4')) {
        subject = rdf.namedNode(subject.value.replace('council/4', 'council/FA'))
    }

    if (object.value.startsWith('https://politics.ld.admin.ch/council/1')) {
        object = rdf.namedNode(object.value.replace('council/1', 'council/N'))
    }
    else if (object.value.startsWith('https://politics.ld.admin.ch/council/2')) {
        object = rdf.namedNode(object.value.replace('council/2', 'council/S'))
    }
    else if (object.value.startsWith('https://politics.ld.admin.ch/council/4')) {
        object = rdf.namedNode(object.value.replace('council/4', 'council/FA'))
    }

    return rdf.quad(subject, quad.predicate, object)
}

function mapEfficacy(quad) {

    let subject = quad.subject
    let object = quad.object

    if (subject.value = 'https://lod.lobbywatch.ch/tief') {
        subject = rdf.namedNode(subject.value.replace('tief', 'low'))
    }
    else if (subject.value = 'https://lod.lobbywatch.ch/mittel') {
        subject = rdf.namedNode(subject.value.replace('mittel', 'medium'))
    }
    else if (subject.value = 'https://lod.lobbywatch.ch/hoch') {
        subject = rdf.namedNode(subject.value.replace('hoch', 'high'))
    }

    if (object.value = 'https://lod.lobbywatch.ch/tief') {
        object = rdf.namedNode(object.value.replace('tief', 'low'))
    }
    else if (object.value = 'https://lod.lobbywatch.ch/mittel') {
        object = rdf.namedNode(object.value.replace('mittel', 'medium'))
    }
    else if (object.value = 'https://lod.lobbywatch.ch/hoch') {
        object = rdf.namedNode(object.value.replace('hoch', 'high'))
    }

    return rdf.quad(subject, quad.predicate, object)
}

module.exports = { mapCouncils, mapEfficacy }
