
import json
import csv

home    ='C:/Projects/soccer'
srcDir  = home + '/rawdata/json'
distDir = home + '/rawdata/csv'

teamsSrcfn        = 'teams.json'
playersSrcfn      = 'players.json'
coachesSrcfn      = 'coaches.json'
refereesSrcfn     = 'referees.json'
competitionsSrcfn = 'competitions.json'

eventsSrcFns = ['events/events_World_Cup.json'
                ,'events/events_European_Championship.json'
                ,'events/events_England.json'
                ,'events/events_France.json'
                ,'events/events_Germany.json'
                ,'events/events_Italy.json'
                ,'events/events_Spain.json'
            ]

matchessrcFns = ['matches/matches_World_Cup.json'
                ,'matches/matches_European_Championship.json'
                ,'matches/matches_England.json'
                ,'matches/matches_France.json'
                ,'matches/matches_Germany.json'
                ,'matches/matches_Italy.json'
                ,'matches/matches_Spain.json'
            ]


def readEntities(srcfn):
    with open(srcfn, 'r', encoding='utf-8') as infile:
        entities = json.load(infile)
    return entities


def writeCsv(rows, header, outfn):
    with open(outfn, 'w', newline='', encoding='utf-8') as outfile:
        writer = csv.writer(outfile)
        writer.writerow(header)
        writer.writerows(rows)


def eliminateDuplicates(csvRows):
    csvRows.sort(key=lambda row:row[0])
    dublicateFreeRows = []
    previousId = csvRows[0][0]
    dublicateFreeRows.append(csvRows[0])
    for idx in range(1, len(csvRows)):
        currentId = csvRows[idx][0]
        if previousId != currentId:
            dublicateFreeRows.append(csvRows[idx])
            previousId = currentId
    return dublicateFreeRows



def replaceNullStr(val):
    if val == None or isinstance(val, int):
        return val
    if val != '' and  val.lower().strip() != 'null':
        return val.strip()
    else:
        return None

def str2ascii(val):
    if val == None or isinstance(val, int):
        return val
    s = []
    for c in val:
        if ord(c) < 128:
            s.append(c)
        else:
            h = hex(ord(c))
            if len(h) > 4:
                s.append('\\' + h.replace('x', ''))
            else:
                s.append('\\' + h.replace('x', '0'))
    return ''.join(s)


## ------------------------- ##
## Players and Player Roles  ##
## ------------------------- ##
def getPlayerRole(e):
    return (
            replaceNullStr(e['role']['name'])
            ,replaceNullStr(e['role']['code2'])
            ,replaceNullStr(e['role']['code3'])
        )


def getPlayer(e):
    p = []
    p.append(replaceNullStr(e['wyId']))
    p.append(replaceNullStr(e['firstName']))
    p.append(replaceNullStr(e['middleName']))
    p.append(replaceNullStr(e['lastName']))
    p.append(replaceNullStr(e['shortName']))
    p.append(replaceNullStr(e['birthDate']))
    p.append(replaceNullStr(e['birthArea']['id']))
    p.append(replaceNullStr(e['passportArea']['id']))
    p.append(replaceNullStr(e['height']))
    p.append(replaceNullStr(e['foot'])) 
    p.append(replaceNullStr(e['currentTeamId'])) 
    p.append(replaceNullStr(e['currentNationalTeamId']))
    return p


def extractPlayers():
    print('Extracting players from ' + playersSrcfn + ' ...')
    entities = readEntities(srcDir + '/' + playersSrcfn)
    roleDic = {}
    players = []
    for e in entities:
        role = getPlayerRole(e)
        if role not in roleDic:
            roleId = len(roleDic) + 1
            roleDic[role] = roleId
        player = getPlayer(e)
        player.append(roleDic[role])
        players.append(player)

    playerRoles = []
    for r, rId in roleDic.items():
        playerRoles.append([rId, r[0], r[1], r[2]]
                           )
    playerRoleHeader = ['roleId', 'name', 'code2', 'code3']
    playerRoles.sort(key=lambda r:r[0])
    writeCsv(playerRoles, playerRoleHeader, distDir + '/' + 'playerRoles.csv')

    playerHeader = ['playerId', 'firstName', 
                    'middleName', 'lastName', 
                    'shortName','birthDate',
                    'birthAreaId', 'passportAreaId', 
                    'height', 'foot',
                    'currentTeamId', 'currentNationalTeamId',
                    'roleId'
                ]
    players.sort(key=lambda p:p[0])
    writeCsv(players, playerHeader, distDir + '/' + 'players.csv')


## -------- ##
## Referees ##
## -------- ##
def getReferee(e):
    t = []
    t.append(replaceNullStr(e['wyId']))
    t.append(replaceNullStr(e['firstName']))
    t.append(replaceNullStr(e['middleName']))
    t.append(replaceNullStr(e['lastName']))
    t.append(replaceNullStr(e['shortName']))
    t.append(replaceNullStr(e['birthDate']))
    t.append(replaceNullStr(e['birthArea']['id']))      #birthAreaId
    t.append(replaceNullStr(e['passportArea']['id']))   #passPortAreaId
    return [str2ascii(v) for v in t]


def extractReferees():
    print('Extracting referees from ' + refereesSrcfn + ' ...')
    referees = []
    entities = readEntities(srcDir + '/' + refereesSrcfn)
    for e in entities:
        referees.append(getReferee(e))
    referees.sort(key=lambda r:r[0])

    refereeHeader = ['refereeId', 'firstName', 'middleName', 'lastName', 
                     'shortName', 'birthDate', 'birthAreaId', 'passportAreaId'
                ]
    writeCsv(referees, refereeHeader, distDir + '/' + 'referees.csv')


## ------- ##
## Coaches ##
## ------- ##
def getCoach(e):
    c = []
    c.append(replaceNullStr(e['wyId']))
    c.append(replaceNullStr(e['firstName']))
    c.append(replaceNullStr(e['middleName']))
    c.append(replaceNullStr(e['lastName']))
    c.append(replaceNullStr(e['shortName']))
    c.append(replaceNullStr(e['birthDate']))
    c.append(replaceNullStr(e['currentTeamId']))
    c.append(replaceNullStr(e['birthArea']['id']))      #birthAreaId
    c.append(replaceNullStr(e['passportArea']['id']))   #passPortAreaId
    return [str2ascii(v) for v in c]


def extractCoaches():
    print('Extracting coaches from ' + coachesSrcfn + ' ...')
    coaches = []
    entities = readEntities(srcDir + '/' + coachesSrcfn)
    for e in entities:
        coaches.append(getCoach(e))
    
    coachHeader = ['coachId', 'firstName', 'middleName', 'lastName', 
                   'shortName', 'birthDate', 'currentTeamId',  'birthAreaId', 
                   'passportAreaId' 
                ]
    coaches.sort(key=lambda c:c[0])
    writeCsv(coaches, coachHeader, distDir + '/coaches.csv')


## ------------ ##
## Competitions ##
## ------------ ##
def getCompetition(e):
    c = []
    c.append(e['wyId'])
    c.append(e['name'])
    c.append(e['format'])
    c.append(e['area']['id']) # areaId
    c.append(e['type'])
    return c


def extractCompetitions():
    print('Extracting competitions from ' + competitionsSrcfn + ' ...')
    competitions = []
    entities = readEntities(srcDir + '/' + competitionsSrcfn)
    for e in entities:
        competitions.append(getCompetition(e))

    competitionHeader = ['competitionId', 'name', 'format', 'areaId', 'type']
    competitions.sort(key=lambda c:c[0])
    writeCsv(competitions, competitionHeader, distDir + '/competitions.csv')


## ----- ##
## Teams ##
## ----- ##
def getTeam(e):
    t = []
    t.append(replaceNullStr(e['wyId']))
    t.append(replaceNullStr(e['name']))
    t.append(replaceNullStr(e['officialName']))
    t.append(replaceNullStr(e['city']))
    t.append(replaceNullStr(e['area']['id'])) #areaID
    t.append(replaceNullStr(e['type']))
    return t


def extractTeams():
    print('Extracting teams from ' + teamsSrcfn + ' ...')
    teams = []
    entities = readEntities(srcDir + '/' + teamsSrcfn)
    for e in entities:
        teams.append(getTeam(e))

    teamHeader = ['teamId', 'name', 'officialName', 'city', 'areaId', 'type']
    teams.sort(key=lambda t:t[0])
    writeCsv(teams, teamHeader, distDir + '/teams.csv')


## ----- ##
## Areas ##
## ----- ##
def getArea(e):
    a = []
    a.append(int(e['id']))
    a.append(replaceNullStr(e['name']))
    a.append(replaceNullStr(e['alpha2code']))
    a.append(replaceNullStr(e['alpha3code']))
    return a


def extractAreas():
    areas = []
    for srcfn in (playersSrcfn, refereesSrcfn, coachesSrcfn):
        entities = readEntities(srcDir + '/' + srcfn)
        print('Extracting areas from ' + srcfn + ' ...')
        for e in entities:
            areas.append(getArea(e['birthArea']))
            areas.append(getArea(e['passportArea']))
    for srcfn in (teamsSrcfn, competitionsSrcfn):
        print('Extracting areas from ' + srcfn + ' ...')
        entities = readEntities(srcDir + '/' + srcfn)
        for e in entities:
            areas.append(getArea(e['area']))

    areaHeader = ['areaId', 'name', 'alpha2code', 'alpha3code']
    areas.sort(key=lambda area:area[0])
    writeCsv(eliminateDuplicates(areas), areaHeader, distDir + '/areas.csv')


## ------------------------------ ##
## Event Types and Subevent Types ##
## ------------------------------ ##
def getEventType(e):
    ev = []
    ev.append(e['eventId'])
    ev.append(e['eventName'])
    ev.append(None)
    return ev


def getSubEventType(e):
    sev = []
    if (e['subEventId'] == ''):
        sev.append(-1)
    else:
        sev.append(e['subEventId'])
    sev.append(e['subEventName'])
    sev.append(e['eventId'])
    return sev


def extractEventTypes():
    eventTypes    = []
    subEventTypes = []
    for srcfn in eventsSrcFns:
        print('Extracting eventTypes from ' + srcfn + ' ...')
        entities = readEntities(srcDir + '/' + srcfn)
        for e in entities:
            eventTypes.append(getEventType(e))
            subEventTypes.append(getSubEventType(e))

    eventTypeHeader = ['typeId', 'typeName', 'superTypeId']
    eventTypes.sort(key=lambda et:et[0])
    writeCsv(eliminateDuplicates(eventTypes), eventTypeHeader, distDir + '/eventTypes.csv')

    subEventTypeHeader = ['typeId', 'typeName', 'superTypeId']
    subEventTypes.sort(key=lambda set:set[0])
    writeCsv(eliminateDuplicates(subEventTypes), subEventTypeHeader, distDir + '/eventSubTypes.csv')


## -------------------------- ##
## Events and Event Positions ##
## -------------------------- ##
def addPosition(yx, positions):
    if yx not in positions:
        idx = len(positions)
        positions[yx] = idx


def extractPositions(e, positions):
    ePositions = e['positions']
    extractedPositions = []
    if ePositions != None:
        if len(ePositions) >= 1:
            addPosition((ePositions[0]['y'], ePositions[0]['x']), positions)
            extractedPositions.append((ePositions[0]['y'], ePositions[0]['x']))
        if len(ePositions) == 2:
            addPosition((ePositions[1]['y'], ePositions[1]['x']), positions)
            extractedPositions.append((ePositions[1]['y'], ePositions[1]['x']))
    return extractedPositions


def getEvent(e, positions):
    ee = []
    ee.append(e['id'])
    ee.append(e['matchId'])
    ee.append(e['teamId'])
    ee.append(e['playerId'])
    ee.append(e['matchPeriod'])
    ee.append(e['eventSec'])
    ee.append(e['eventId'])
    ee.append(e['subEventId'])

    ePositions = extractPositions(e, positions)
    if len(ePositions) == 0:
        ee.append(0)
        ee.append(0)
    else:
        posAId = positions[ePositions[0]]
        ee.append(posAId)
        if len(ePositions) == 2:
            posBId = positions[ePositions[1]]
            ee.append(posBId)
        else:
            ee.append(0)
    return ee


def extractEvents():
    positions = {(-1, -1):0}
    events = []
    for srcfn in eventsSrcFns:
        print('Extracting events from ' + srcfn + ' ...')
        entities = readEntities(srcDir + '/' + srcfn)
        for e in entities:
            extractPositions(e, positions)
            events.append(getEvent(e, positions))

    positionHeader = ['id', 'y', 'x']
    positions1 = []
    for p in positions:
        positions1.append([positions[p], p[0], p[1]])
    positions1.sort(key=lambda p:p[0])
    writeCsv(positions1, positionHeader, distDir + '/positions.csv')

    eventHeader = ['eventId', 'matchId', 'teamId', 
                   'playerId', 'matchPeriod', 'eventSec', 
                   'eventTypeId', 'eventSubTypeId', 'posAId', 'posBId'
                ]
    events.sort(key=lambda e:e[0])
    writeCsv(events, eventHeader, distDir + '/events.csv')


## -------------------------- ##
## Matches ##
## -------------------------- ##
def getMatchPlayer(matchId, teamId, formation, d):
    p = []
    p.append(matchId)
    p.append(teamId)
    p.append(d['playerId'])
    #p.append(d['assists'])
    p.append(replaceNullStr(d['goals']))
    p.append(replaceNullStr(d['ownGoals']))
    p.append(replaceNullStr(d['redCards']))
    p.append(replaceNullStr(d['yellowCards']))
    p.append(formation)
    return p


def getMatchPlayers(e):
    mp = []
    matchId = e['wyId']
    for teamId in e['teamsData']:
        for pDic in e['teamsData'][teamId]['formation']['bench']:   
            mp.append(getMatchPlayer(matchId, teamId, 'bench', pDic))
        for pDic in e['teamsData'][teamId]['formation']['lineup']:   
            mp.append(getMatchPlayer(matchId, teamId, 'lineup', pDic))
    return mp


def getMatchSubstitution(matchId, teamId, d):
    if 'playerIn' not in d:
        return []
    s = []
    s.append(matchId)
    s.append(teamId)
    s.append(d['playerIn'])
    #s.append(d['assists'])
    s.append(d['playerOut'])
    s.append(d['minute'])
    return s


def getMatchSubstitutions(e):
    ms = []
    matchId = e['wyId']
    for teamId in e['teamsData']:
        for sDic in e['teamsData'][teamId]['formation']['substitutions']: 
            s = getMatchSubstitution(matchId, teamId, sDic)
            if len(s) > 0:
                ms.append(s)
    return ms


def getMatchReferee(matchId, d):
    r = []
    r.append(matchId)
    r.append(d['refereeId'])
    r.append(d['role'])
    return r


def getMatchReferees(e):
    mr = []
    matchId = e['wyId']
    for rDic in e['referees']:
        mr.append(getMatchReferee(matchId, rDic))
    return mr


def getMatchTeam(matchId, teamId, d):
    t = []
    t.append(matchId)
    t.append(teamId)
    t.append(d['coachId'])
    t.append(d['side'])
    t.append(d['score'])
    t.append(d['scoreHT'])
    t.append(d['scoreET'])
    t.append(d['scoreP'])
    return t

    
def getMatchTeams(e):
    mt = []
    matchId = e['wyId']
    for teamId in e['teamsData']:
        mt.append(getMatchTeam(matchId, teamId, e['teamsData'][teamId]))
    return mt


def getMatch(e):
    m = []
    m.append(e['wyId'])
    m.append(e['roundId'])
    m.append(e['seasonId'])
    m.append(e['competitionId'])
    m.append(e['status'])
    m.append(e['winner'])
   # m.append(e['groupName'])
    m.append(e['gameweek'])
    m.append(e['venue'])
    m.append(e['label'])
    m.append(e['dateutc'])
    m.append(e['date'])
    m.append(e['duration'])
    return m


def extractMatches():
    matches            = []
    matchTeams         = []
    matchPlayers       = []
    matchReferees      = []
    matchSubstitutions = []
    for srcfn in matchessrcFns:
        print('Extracting matches from ' + srcfn + ' ...')
        entities = readEntities(srcDir + '/' + srcfn)
        for e in entities:
            matches.append(getMatch(e))
            matchTeams.extend(getMatchTeams(e))
            matchPlayers.extend(getMatchPlayers(e))
            matchReferees.extend(getMatchReferees(e))
            matchSubstitutions.extend(getMatchSubstitutions(e))
    
    matchHeader = ['matchId', 'roundId', 'seasonId', 'competitionId', 'status', 
                   'winner', 'gameweek', 'venue', 'label', 'dateutc', 'date', 'duration'
                ]
    matches.sort(key=lambda m:m[0])
    writeCsv(matches, matchHeader, distDir + '/matches.csv')

    matchTeamHeader = ['matchId', 'teamId', 'coachId', 'side', 
                        'score', 'scoreHT', 'scoreET', 'scoreP'
                    ]
    matchTeams.sort(key=lambda mt:mt[0])
    writeCsv(matchTeams, matchTeamHeader, distDir + '/matchTeams.csv')

    matchPlayerHeader = ['matchId', 'teamId', 'playerId', 'goals', 'ownGoals', 
                         'redCards', 'yellowCards', 'formation'
                    ]
    matchPlayers.sort(key=lambda mp:mp[0])
    writeCsv(matchPlayers, matchPlayerHeader, distDir + '/matchPlayers.csv')

    matchSubstitutionHeader = ['matchId', 'teamId', 'playerInId',  'playerOutId', 'minute']
    matchSubstitutions.sort(key=lambda ms:ms[0])
    writeCsv(matchSubstitutions, matchSubstitutionHeader, distDir + '/matchSubstitutions.csv')

    matchRefereeHeader = ['matchId', 'refereeId', 'role']
    matchReferees.sort(key=lambda mr:mr[0])
    writeCsv(matchReferees, matchRefereeHeader, distDir + '/matchReferees.csv')


extractPlayers()
extractReferees()
extractCoaches()
extractCompetitions()
extractTeams()
extractAreas()
extractEventTypes()
extractEvents()        
extractMatches()