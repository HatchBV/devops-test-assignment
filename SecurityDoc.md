## Security Concerns and Solutions:
#### Encryption of Data In-Flight Using SSL/TLS:
It keeps data encrypted between our producers and Kafka, as well as our consumers and Kafka.
- Transferring data on PLAINTEXT has been stopped completely
  - Client -> Broker, TLS enabled
  - inter Broker clients -> Broker, TLS enabled
  - Broker -> ZooKeeper, TLS enabled
- Client will do a Hostname verification on the certificate that is presented by the server to prevent Man in the middle attack.
- Kafka broker will have two Certs with CAs, 
  1. Used as server cert with Kafka clients and as client cert with Kafka brokers.
  2. Used as client cert to connect to ZooKeeper.
 - ZooKeeper will have one Cert with CA which will be used to support mTLS when Kafka connects to it and between Znodes.

#### Authentication Using SSL:
It is leveraging a capability from SSL, which we also call two ways authentication.
- Kafka broker will ask the client to send his certificate signed by a certificate authority that allows our Kafka brokers to verify the identity of the clients against the certificate.
- ZooKeeper will ask Kafka broker to send his certificate signed by a certificate authority that allows our ZooKeeper to verify the identity of the clients against the certificate.

#### Authorization:
Kafka needs to be able to decide what they can and cannot do as soon as our Kafka clients are authenticated. This is where Authorization comes in, which is controlled by the Access Control Lists (ACL).
- Kafka will user the Cert CN as user name for ACL.
- ZooKeeper ACL enabled using mTLS alone, so every broker and/or CLI tool must identify itself using the same Distinguished Name (DN). The DN is included in the ZooKeeper ACL, and ZooKeeper only authorizes what is in the DN, so all connections to ZooKeeper must provide the DN
