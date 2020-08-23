# Generated by Django 3.0.2 on 2020-08-23 21:50

from django.db import migrations

station_regions = [
    {"region": "Avon & Somerset", "stations": [
        "Patchway",
        "Keynsham",
        "Bridgewater",
    ]},
    {"region": "Bedfordshire", "stations": [
        "Luton",
        "Kempston Police Station",
    ]},
    {"region": "Cambridgeshire", "stations": [
        "Huntingdon",
        "March",
        "Parkside",
        "Thorpewood",
    ]},
    {"region": "Cheshire", "stations": [
        "Runcorn",
        "Middlewich",
        "Blacon",
    ]},
    {"region": "Cleveland", "stations": [
        "Middlehaven",
        "Kirkleatham (reserve)",
    ]},
    {"region": "Cumbria", "stations": [
        "Barrow",
        "Durranhill",
        "Workington",
        "Kendal",
    ]},
    {"region": "Derbyshire", "stations": [
        "Buxton",
        "Chesterfield",
        "Derby",
        "Ripley",
    ]},
    {"region": "Devon & Cornwall", "stations": [
        "Exeter",
        "Plymouth",
        "Barnstaple",
        "Torquay",
        "Newquay",
        "Camborne",
    ]},
    {"region": "Dorset", "stations": [
        "Weymouth",
        "Poole",
        "Bournemouth",
    ]},
    {"region": "Durham", "stations": [
        "Durham",
        "Darlington",
        "Bishop",
        "Peterlee",
        "Consett",
        "Spennymoor",
    ]},
    {"region": "Essex", "stations": [
        "Southend",
        "Colchester",
        "Harlow",
        "Basildon",
        "Grays",
        "Clacton",
        "Chelmsford",
    ]},
    {"region": "Gloucestershire", "stations": [
        "Gloucestershire",
    ]},
    {"region": "Greater Manchester", "stations": [
        "North Manchester",
        "Longsight",
        "Swinton",
        "Ashton",
        "Cheadle Heath",
        "Bolton",
        "Wigan",
        "Pendleton",
        "Bury",
        "Chadderton",
    ]},
    {"region": "Hampshire", "stations": [
        "Basingstoke",
        "Portsmouth",
        "Southampton",
        "Newport",
    ]},
    {"region": "Hertfordshire", "stations": [
        "Hatfield",
        "Stevenage",
    ]},
    {"region": "Humberside", "stations": [
        "Clough Road",
        "Southbank (Birchin way)",
        "Grimsby",
        "Priory Road",
    ]},
    {"region": "Kent", "stations": [
        "Medway",
        "Northfleet (North Kent)",
        "Canterbury",
        "Folkestone",
        "Maidstone",
        "Margate",
        "Tonbridge",
    ]},
    {"region": "Lancashire", "stations": [
        "Blackburn",
        "Blackpoool",
        "Burnley",
        "Lancaster",
        "Preston",
    ]},
    {"region": "Leicestershire", "stations": [
        "Beaumont Lays",
        "Euston Street",
        "Keyham",
    ]},
    {"region": "Lincolnshire", "stations": [
        "Lincoln",
        "Grantham",
        "Boston",
        "Skegness",
    ]},
    {"region": "Merseyside", "stations": [
        "Wirral",
        "St Annes St",
        "Copy Lane",
        "Belle Valle",
        "Wavertree Road",
    ]},
    {"region": "Metropolitan Police", "stations": [
        "Acton",
        "Dagenham and Barking",
        "Bethnal Green",
        "Brixton",
        "Bromley",
        "Charing Cross",
        "Colindale",
        "Croydon",
        "Forest Gate",
        "Heathrow",
        "Holborn",
        "Hounslow",
        "Ilford",
        "Islington",
        "Kingston",
        "Lewisham",
        "Leyton",
        "Romford",
        "Stoke Newington",
        "Walworth",
        "Wandsworth",
        "Wembley",
        "Woodgreen",
        "Belgravia",
        "Edmonton",
        "Harrow",
        "Peckham",
        "West End Central",
        "Plumstead",
        "Sutton",
    ]},
    {"region": "British Transport Police", "stations": [
        "Brewery Road",
    ]},
    {"region": "City of London", "stations": [
        "Bishopsgate",
    ]},
    {"region": "Norfolk / Suffolk", "stations": [
        "Aylsham",
        "Great Yarmouth",
        "King's Lynn",
        "Wymondham",
        "Bury",
        "Ipswich",
    ]},
    {"region": "North Yorkshire", "stations": [
        "Harrogate",
        "Scarborough",
        "York",
    ]},
    {"region": "Northamptonshire", "stations": [
        "Criminal Justice Centre",
        "Weekley Woods",
    ]},
    {"region": "Northumbria", "stations": [
        "New Castle City Centre",
        "Middle Engine",
        "Southwick",
        "Berwick",
        "Bedlington",
        "Etal Lane",
        "South Shields",
    ]},
    {"region": "Nottinghamshire", "stations": [
        "Nottingham Bridewell",
        "Mansfield",
        "Newark",
    ]},
    {"region": "South Yorkshire", "stations": [
        "Doncaster Custody Suite",
        "Shepcote Lane Custody Suite",
        "Barnsley Custody Suite",
    ]},
    {"region": "Staffordshire", "stations": [
        "NACF",
        "Watling Custody Facility",
        "Burton",
    ]},
    {"region": "Surrey", "stations": [
        "Guildford",
        "Salford",
        "Staines",
        "Woking",
    ]},
    {"region": "Sussex", "stations": [
        "Crawley Police Station",
        "Hastings Police Station",
        "Brighton Custody Suite",
        "Eastbourne Custody Suite",
        "Chichester Custody Suite",
        "Worthington Custody Suite",
    ]},
    {"region": "Thames Valley", "stations": [
        "Abingdon",
        "Aylesbury",
        "Banbury",
        "High Wycombe",
        "Loddon Valley",
        "Maidenhead",
        "Milton Keynes",
        "Newbury",
    ]},
    {"region": "Warwickshire", "stations": [
        "Nuneaton",
        "Leamington",
        "Rugby",
    ]},
    {"region": "West Mercia", "stations": [
        "Hereford",
        "Kidderminster",
        "Shrewsbury",
        "Telford",
        "Worcestor",
    ]},
    {"region": "West Midlands", "stations": [
        "Bloxwich",
        "Central Custody",
        "Coventry Central",
        "Stechford",
        "Western Custody",
        "Wolverhampton Central",
    ]},
    {"region": "West Yorkshire", "stations": [
        "Trafalgar House",
        "Halifax",
        "Dewsbury",
        "Huddersfield",
        "Elland Road",
        "Stainbeck",
    ]},
    {"region": "Wiltshire", "stations": [
        "Havertop",
        "Melksham",
        "Swindon",
    ]},
    {"region": "Dyfed-Powys", "stations": [
        "Aberystwyth",
        "Ammanford",
        "Brecon",
        "Cardigan",
        "Haverfordwest",
        "Llanelli",
        "Newtown",
    ]},
    {"region": "Gwent", "stations": [
        "Newport",
        "Ystrad Mynach",
    ]},
    {"region": "North Wales", "stations": [
        "Llay",
        "Caernarfon",
        "St Asaph",
        "Mold",
        "Dolgellau",
    ]},
    {"region": "South Wales", "stations": [
        "Cardiff",
        "Swansea",
        "Merthyr Bridewell",
        "Bridgend Bridewell",
    ]},
]

def create_station_list(apps, schema_editor):
    Station = apps.get_model('backoffice', 'Station')
    StationRegion = apps.get_model('backoffice', 'StationRegion')
    for region in station_regions:
        region_object = StationRegion.objects.create(name=region['region'])
        Station.objects.bulk_create([Station(name=station, region=region_object, verified=True, rejected=False) for station in region['stations']])

class Migration(migrations.Migration):

    dependencies = [
        ('backoffice', '0004_station_stationregion'),
    ]

    operations = [
        migrations.RunPython(create_station_list),
    ]
