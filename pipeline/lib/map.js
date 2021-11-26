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

module.exports = { mapCouncils }
