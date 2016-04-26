# zktools
Collection of scripts used for troubleshooting ZooKeeper on a CM/CDH cluster

Compatible with CM 5.0+

## DumpZKLog.sh
Dumps latest ZK log file for CM/CDH-based Hadoop Distributions
##### Usage: ./DumpZKLog.sh

Example:
```
$ ./DumpZKLog.sh | head -10
Running LogFormatter...
ZooKeeper Transactional Log File with dbid 0 txnlog format version 2
4/23/16 12:38:06 PM PDT session 0x154166644b163ba cxid 0x0 zxid 0x2fda9 createSession 30000

4/23/16 12:38:06 PM PDT session 0x154166644b163ba cxid 0x3 zxid 0x2fdaa create '/cloudera_manager_zookeeper_canary,#434d205a6f6f4b65657065722063616e61727920726f6f742c206372656174656420617420323031362d30342d32335431323a33383a30362e3139372d30373a3030,v{s{31,s{'world,'anyone}}},F,24428

4/23/16 12:38:06 PM PDT session 0x154166644b163bb cxid 0x0 zxid 0x2fdab createSession 30000

4/23/16 12:38:06 PM PDT session 0x154166644b163bb cxid 0x2 zxid 0x2fdac create '/cloudera_manager_zookeeper_canary/zookeeper-SERVER-bd492682d4f953be764c6be5f3dbc55b,#2f636c6f75646572615f6d616e616765725f7a6f6f6b65657065725f63616e6172792f7a6f6f6b65657065722d5345525645522d6264343932363832643466393533626537363463366265356633646263353562,v{s{31,s{'world,'anyone}}},T,1
...
```

##DumpZKSnapshot.sh
Dumps latest ZK snapshot for CM/CDH-based Hadoop Distributions
##### Usage: ./DumpZKSnapshot.sh [-all]
-all flag will display all output of SnapshotFormatter
Omitting -all flag will only report znodes

Examples:
```
$ ./DumpZKSnapshot.sh
Running SnapshotFormatter...
/
/hive_zookeeper_namespace_hive
/zookeeper
/zookeeper/quota
```

```
# ./DumpZKSnapshot.sh --all
Running SnapshotFormatter...
ZNode Details (count=5):
----
/
  cZxid = 0x00000000000000
  ctime = Wed Dec 31 16:00:00 PST 1969
  mZxid = 0x00000000000000
  mtime = Wed Dec 31 16:00:00 PST 1969
  pZxid = 0x0000000002fda7
  cversion = 24427
  dataVersion = 0
  aclVersion = 0
  ephemeralOwner = 0x00000000000000
  dataLength = 0
----
/hive_zookeeper_namespace_hive
  cZxid = 0x00000000010e4c
  ctime = Tue Apr 12 09:55:55 PDT 2016
  mZxid = 0x00000000010e4c
  mtime = Tue Apr 12 09:55:55 PDT 2016
  pZxid = 0x000000000175ba
  cversion = 59
  dataVersion = 0
  aclVersion = 0
  ephemeralOwner = 0x00000000000000
  dataLength = 0
...
Session Details (sid, timeout, ephemeralCount):
0x154166644b163b8, 30000, 0
```
