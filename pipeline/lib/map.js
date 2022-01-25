const { quad } = require('rdf-ext');
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

    if (subject.value === 'https://lod.lobbywatch.ch/efficacy/tief') {
        subject = rdf.namedNode(subject.value.replace('tief', 'low'))
    }
    else if (subject.value === 'https://lod.lobbywatch.ch/efficacy/mittel') {
        subject = rdf.namedNode(subject.value.replace('mittel', 'medium'))
    }
    else if (subject.value === 'https://lod.lobbywatch.ch/efficacy/hoch') {
        subject = rdf.namedNode(subject.value.replace('hoch', 'high'))
    }

    if (object.value === 'https://lod.lobbywatch.ch/efficacy/tief') {
        object = rdf.namedNode(object.value.replace('tief', 'low'))
    }
    else if (object.value === 'https://lod.lobbywatch.ch/efficacy/mittel') {
        object = rdf.namedNode(object.value.replace('mittel', 'medium'))
    }
    else if (object.value === 'https://lod.lobbywatch.ch/efficacy/hoch') {
        object = rdf.namedNode(object.value.replace('hoch', 'high'))
    }

    return rdf.quad(subject, quad.predicate, object)
}

const legalForms = {
    "https://lod.lobbywatch.ch/organization-forms/ag": "https://ld.admin.ch/ech/97/legalforms/0106",
    "https://lod.lobbywatch.ch/organization-forms/gmb-h": "https://ld.admin.ch/ech/97/legalforms/0107",
    "https://lod.lobbywatch.ch/organization-forms/stiftung": "https://ld.admin.ch/ech/97/legalforms/0110",
    "https://lod.lobbywatch.ch/organization-forms/verein": "https://ld.admin.ch/ech/97/legalforms/0109",
    "https://lod.lobbywatch.ch/organization-forms/einzelunternehmen": "https://ld.admin.ch/ech/97/legalforms/0101",
    "https://lod.lobbywatch.ch/organization-forms/kg": "https://ld.admin.ch/ech/97/legalforms/0103",
    "https://lod.lobbywatch.ch/organization-forms/genossenschaft": "https://ld.admin.ch/ech/97/legalforms/0108",
    "https://lod.lobbywatch.ch/organization-forms/einfache-gesellschaft": "https://ld.admin.ch/ech/97/legalforms/0302",
}

function mapLegalForms(quad) {

    if (quad.predicate.value === "https://lod.lobbywatch.ch/legalForm") {

        if (quad.object.value in legalForms) {
            quad.object = rdf.namedNode(legalForms[quad.object.value])
            quad.predicate = rdf.namedNode("http://schema.org/additionalType")
        }
    }

    return quad
}

function mapRemuneration(quad) {
    let quads
    if (quad.predicate.value === "http://www.w3.org/ns/org#remuneration") {

        if (quad.object.value === 1) {
            quads = [rdf.quad(quad.subject, rdf.namedNode("https://lod.lobbywatch.ch/remunerationType"), rdf.namedNode("https://lod.lobbywatch.ch/Paid"))]
        } else if (quad.object.value === -1) {
            quads = [rdf.quad(quad.subject, rdf.namedNode("https://lod.lobbywatch.ch/remunerationType"), rdf.namedNode("https://lod.lobbywatch.ch/PaidMembership"))]
        } else if (quad.object.value === 0) {
            quads = [quad, rdf.quad(quad.subject, rdf.namedNode("https://lod.lobbywatch.ch/remunerationType"), rdf.namedNode("https://lod.lobbywatch.ch/Unpaid"))]
        } else {
            quads = [quad, rdf.quad(quad.subject, rdf.namedNode("https://lod.lobbywatch.ch/remunerationType"), rdf.namedNode("https://lod.lobbywatch.ch/Paid"))]
        }
    } else {
        quads = [quad]
    }

    return quads
}

function isOrgQuad(quad) {
    return quad.predicate.value === 'https://lod.lobbywatch.ch/organizationType'
}

function isRemunerationQuad(quad) {
    return quad.predicate.value === "http://www.w3.org/ns/org#remuneration"
}

function splitOrganizations(quad) {
    let quads

    if (isOrgQuad(quad)) {
        quads = quad.object.value.split(",").map(orgTyp => rdf.quad(quad.subject, quad.predicate, rdf.namedNode("https://lod.lobbywatch.ch/organization-type/" + orgTyp)))
    } else {
        quads = [quad]
    }
    return quads
}

function splitTriples(quad) {
    let quads

    if (isOrgQuad(quad)) {
        quads = quad.object.value.split(",").map(orgTyp => rdf.quad(quad.subject, quad.predicate, rdf.namedNode("https://lod.lobbywatch.ch/organization-type/" + orgTyp)))
    } else if (isRemunerationQuad(quad)) {

        if (quad.object.value === "1") {
            quads = [rdf.quad(quad.subject, rdf.namedNode("https://lod.lobbywatch.ch/remunerationType"), rdf.namedNode("https://lod.lobbywatch.ch/PaidUnknownAmount"))]
        } else if (quad.object.value === "-1") {
            quads = [rdf.quad(quad.subject, rdf.namedNode("https://lod.lobbywatch.ch/remunerationType"), rdf.namedNode("https://lod.lobbywatch.ch/PaidMembership"))]
        } else if (quad.object.value === "0") {
            quads = [quad, rdf.quad(quad.subject, rdf.namedNode("https://lod.lobbywatch.ch/remunerationType"), rdf.namedNode("https://lod.lobbywatch.ch/Unpaid"))]
        } else {
            quads = [quad, rdf.quad(quad.subject, rdf.namedNode("https://lod.lobbywatch.ch/remunerationType"), rdf.namedNode("https://lod.lobbywatch.ch/PaidKnownAmount"))]
        }
    } else {
        quads = [quad]
    }

    return quads
}



module.exports = { mapCouncils, mapEfficacy, mapLegalForms, splitOrganizations, mapRemuneration, splitTriples }
