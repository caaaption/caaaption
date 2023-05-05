import ApolloAPI

public let spaceNames: GraphQLNullable<[String?]> = [
  "yam.eth",
  "colony.eth",
  "krausehouse.eth",
  "ens.eth",
  "sushigov.eth",
  "uniswap",
  "gitcoindao.eth",
  "aave.eth",
  "olympusdao.eth",
  "banklessvault.eth",
  "poh.eth",
  "xdaistake.eth",
  "balancer.eth",
  "snapshot.dcl.eth",
  "aavegotchi.eth",
  "curve.eth",
  "badgerdao.eth",
  "graphprotocol.eth",
  "loot-dao.eth",
  "mutantsdao.eth",
  "rarible.eth",
  "ilvgov.eth",
  "cvx.eth",
  "ybaby.eth",
  "doodles.eth",
  "shapeshiftdao.eth",
  "pooltogether.eth",
  "paraswap-dao.eth",
  "devdao.eth",
  "trustwallet",
  "friendswithbenefits.eth",
  "bancornetwork.eth",
  "piedao.eth",
  "gnosis.eth",
  "masknetwork.eth",
  "fei.eth",
  "stakedao.eth",
  "rari",
  "opiumprotocol.eth",
  "sismo.eth",
  "instadapp-gov.eth",
  "pangolindex.eth",
  "officialoceandao.eth",
  "ilv.eth",
  "superraredao.eth",
  "0xgov.eth",
  "frax.eth",
  "rbn.eth",
  "mstablegovernance.eth",
  "cream-finance.eth",
  "gro.xyz",
  "barnbridge.eth",
  "10b57e6da0.eth",
  "pickle.eth",
  "origingov.eth",
  "vote.airswap.eth",
  "dopedao.eth",
  "pushdao.eth",
  "decrypt-media.eth",
  "ffdao.eth",
  "pokt-network",
  "rallygov.eth",
  "meritcircle.eth",
  "harvestfi.eth",
  "vote-perp.eth",
  "gov.dhedge.eth",
  "apwine.eth",
  "gov.radicle.eth",
  "daocity.eth",
  "aragon",
  "zora.eth",
  "tokenlon.eth",
  "streamr.eth",
  "unlock-protocol.eth",
  "jbdao.eth",
  "qidao.eth",
  "beefydao.eth",
  "thegurudao.eth",
  "opcollective.eth",
  "dodobird.eth",
  "layer2dao.org",
  "shellprotocol.eth",
  "lensterapp.eth",
  "stgdao.eth",
  "arbitrum-odyssey.eth",
  "cow.eth",
  "bestfork.eth",
  "lido-snapshot.eth",
  "dlytoken.eth",
  "wagdie.eth",
  "primerating.eth",
  "biswap-org.eth",
  "hectordao.eth",
  "alpacafinance.eth",
  "lgcryptounicorns.eth",
  "metislayer2.eth",
  "alchemixstakers.eth",
  "theopendao.eth",
  "evmaverick.eth",
  "livelabs.eth",
  "jadeprotocol.eth",
  "dea.eth",
  "younghwang.eth",
  "tigervc-dao.eth",
  "beets.eth",
  "goodmorningnews.eth",
  "klimadao.eth",
  "redactedcartel.eth",
  "index-coop.eth",
  "club.eth",
  "decentralgames.eth",
  "astardegens.eth",
  "spookyswap.eth",
  "hbot-prp.eth",
  "beanstalkfarms.eth",
  "elyfi-bsc.eth",
  "kogecoin.eth",
  "futera.eth",
  "genesisblocks.eth",
  "gearbox.eth",
  "thelanddaoprop.eth",
  "dcip.eth",
  "otterclam.eth",
  "sharkdao.eth",
  "songadao.eth",
  "apecoin.eth",
  "people-dao.eth",
  "liberofinancial.eth",
  "gauge.rbn.eth",
  "defigeek.eth",
  "unipilot.eth",
  "copernicusbeer.eth",
  "adidas.eth",
  "undw3.eth",
  "abracadabrabymerlinthemagician.eth",
  "cryptexdao.eth",
  "ampleforthorg.eth",
  "hop.eth",
  "idlefinance.eth",
  "staking.idlefinance.eth",
  "beanstalkdao.eth",
  "wearebeansprout.eth",
  "beanstalkfarmsbudget.eth",
  "mantra-dao.eth",
  "community.nexusmutual.eth",
  "specialresolution.nexusmutual.eth",
  "polygonpenguins.eth",
  "swiveldao.eth",
  "poolpool.pooltogether.eth",
  "pancakebunny.eth",
  "glmrapes.eth",
  "tetu.eth",
  "truefigov.eth",
  "rook.eth",
  "silofinance.eth",
  "synthetix-stakers-poll.eth",
  "tempusgov.eth",
  "tracer.eth",
  "varen.eth",
  "notional.eth",
  "bitdao.eth",
  "cre8r.eth",
  "daomstr.eth",
  "dorg.eth",
  "gasdao.eth",
  "gdao.eth",
  "metafactory.eth",
  "primexyz.eth",
  "raidparty.eth",
  "uberhaus.eth",
  "leaguedao.eth",
  "dydxgov.eth",
  "phonon.eth",
  "yieldguild.eth",
  "botto.eth",
  "brightmoments.eth",
  "fingerprints.eth",
  "gmdao.eth",
  "grailers.eth",
  "jennydao.eth",
  "jpeg’d.eth",
  "meebitsdao.eth",
  "squiggledaotreasurysquad.eth",
  "assangedao.eth",
  "cabindao.eth",
  "expansiondao.eth",
  "freerossdao.eth",
  "bullsontheblock.eth",
  "globalcoinresearch.eth",
  "golflinks.eth",
  "tomoondao.eth",
  "popcorn-snapshot.eth",
  "blackpoolhq.eth",
  "vote.vitadao.eth",
  "panda-dao.eth",
  "cultivatordao.eth",
  "eulerdao.eth",
  "cakevote.eth",
  "beanstalkbugbounty.eth",
  "gnars.eth",
  "crowncapital.eth",
  "fatcatsdao.eth",
  "metabrands.eth",
  "seizerdao.eth",
  "treschain.eth",
  "joegovernance.eth",
  "conic-dao.eth",
  "radiantcapital.eth",
  "zechubdao.eth",
  "starknet.eth",
  "arbitrumfoundation.eth",
  "moonbeam-foundation.eth",
  "poktdao.eth",
  "gal.eth",
  "lenster.xyz",
  "beanft.eth"
]

