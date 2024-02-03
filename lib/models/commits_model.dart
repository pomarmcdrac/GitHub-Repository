import 'dart:convert';

class CommitsModel {
    final String sha;
    final String nodeId;
    final Commit commit;
    final String url;
    final String htmlUrl;
    final String commentsUrl;
    final CommitsModelAuthor author;
    final CommitsModelAuthor committer;
    final List<Parent> parents;

    CommitsModel({
        required this.sha,
        required this.nodeId,
        required this.commit,
        required this.url,
        required this.htmlUrl,
        required this.commentsUrl,
        required this.author,
        required this.committer,
        required this.parents,
    });

    factory CommitsModel.fromRawJson(String str) => CommitsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CommitsModel.fromJson(Map<String, dynamic> json) => CommitsModel(
        sha: json["sha"],
        nodeId: json["node_id"],
        commit: Commit.fromJson(json["commit"]),
        url: json["url"],
        htmlUrl: json["html_url"],
        commentsUrl: json["comments_url"],
        author: CommitsModelAuthor.fromJson(json["author"]),
        committer: CommitsModelAuthor.fromJson(json["committer"]),
        parents: List<Parent>.from(json["parents"].map((x) => Parent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sha": sha,
        "node_id": nodeId,
        "commit": commit.toJson(),
        "url": url,
        "html_url": htmlUrl,
        "comments_url": commentsUrl,
        "author": author.toJson(),
        "committer": committer.toJson(),
        "parents": List<dynamic>.from(parents.map((x) => x.toJson())),
    };
}

class CommitsModelAuthor {
    final String login;
    final int id;
    final String nodeId;
    final String avatarUrl;
    final String gravatarId;
    final String url;
    final String htmlUrl;
    final String followersUrl;
    final String followingUrl;
    final String gistsUrl;
    final String starredUrl;
    final String subscriptionsUrl;
    final String organizationsUrl;
    final String reposUrl;
    final String eventsUrl;
    final String receivedEventsUrl;
    final String type;
    final bool siteAdmin;

    CommitsModelAuthor({
        required this.login,
        required this.id,
        required this.nodeId,
        required this.avatarUrl,
        required this.gravatarId,
        required this.url,
        required this.htmlUrl,
        required this.followersUrl,
        required this.followingUrl,
        required this.gistsUrl,
        required this.starredUrl,
        required this.subscriptionsUrl,
        required this.organizationsUrl,
        required this.reposUrl,
        required this.eventsUrl,
        required this.receivedEventsUrl,
        required this.type,
        required this.siteAdmin,
    });

    factory CommitsModelAuthor.fromRawJson(String str) => CommitsModelAuthor.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CommitsModelAuthor.fromJson(Map<String, dynamic> json) => CommitsModelAuthor(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        avatarUrl: json["avatar_url"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
        htmlUrl: json["html_url"],
        followersUrl: json["followers_url"],
        followingUrl: json["following_url"],
        gistsUrl: json["gists_url"],
        starredUrl: json["starred_url"],
        subscriptionsUrl: json["subscriptions_url"],
        organizationsUrl: json["organizations_url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        receivedEventsUrl: json["received_events_url"],
        type: json["type"],
        siteAdmin: json["site_admin"],
    );

    Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "node_id": nodeId,
        "avatar_url": avatarUrl,
        "gravatar_id": gravatarId,
        "url": url,
        "html_url": htmlUrl,
        "followers_url": followersUrl,
        "following_url": followingUrl,
        "gists_url": gistsUrl,
        "starred_url": starredUrl,
        "subscriptions_url": subscriptionsUrl,
        "organizations_url": organizationsUrl,
        "repos_url": reposUrl,
        "events_url": eventsUrl,
        "received_events_url": receivedEventsUrl,
        "type": type,
        "site_admin": siteAdmin,
    };
}

class Commit {
    final CommitAuthor author;
    final CommitAuthor committer;
    final String message;
    final Tree tree;
    final String url;
    final int commentCount;
    final Verification verification;

    Commit({
        required this.author,
        required this.committer,
        required this.message,
        required this.tree,
        required this.url,
        required this.commentCount,
        required this.verification,
    });

    factory Commit.fromRawJson(String str) => Commit.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Commit.fromJson(Map<String, dynamic> json) => Commit(
        author: CommitAuthor.fromJson(json["author"]),
        committer: CommitAuthor.fromJson(json["committer"]),
        message: json["message"],
        tree: Tree.fromJson(json["tree"]),
        url: json["url"],
        commentCount: json["comment_count"],
        verification: Verification.fromJson(json["verification"]),
    );

    Map<String, dynamic> toJson() => {
        "author": author.toJson(),
        "committer": committer.toJson(),
        "message": message,
        "tree": tree.toJson(),
        "url": url,
        "comment_count": commentCount,
        "verification": verification.toJson(),
    };
}

class CommitAuthor {
    final String name;
    final String email;
    final DateTime date;

    CommitAuthor({
        required this.name,
        required this.email,
        required this.date,
    });

    factory CommitAuthor.fromRawJson(String str) => CommitAuthor.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CommitAuthor.fromJson(Map<String, dynamic> json) => CommitAuthor(
        name: json["name"],
        email: json["email"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "date": date.toIso8601String(),
    };
}

class Tree {
    final String sha;
    final String url;

    Tree({
        required this.sha,
        required this.url,
    });

    factory Tree.fromRawJson(String str) => Tree.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Tree.fromJson(Map<String, dynamic> json) => Tree(
        sha: json["sha"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "sha": sha,
        "url": url,
    };
}

class Verification {
    final bool verified;
    final String reason;
    final dynamic signature;
    final dynamic payload;

    Verification({
        required this.verified,
        required this.reason,
        required this.signature,
        required this.payload,
    });

    factory Verification.fromRawJson(String str) => Verification.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Verification.fromJson(Map<String, dynamic> json) => Verification(
        verified: json["verified"],
        reason: json["reason"],
        signature: json["signature"],
        payload: json["payload"],
    );

    Map<String, dynamic> toJson() => {
        "verified": verified,
        "reason": reason,
        "signature": signature,
        "payload": payload,
    };
}

class Parent {
    final String sha;
    final String url;
    final String htmlUrl;

    Parent({
        required this.sha,
        required this.url,
        required this.htmlUrl,
    });

    factory Parent.fromRawJson(String str) => Parent.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        sha: json["sha"],
        url: json["url"],
        htmlUrl: json["html_url"],
    );

    Map<String, dynamic> toJson() => {
        "sha": sha,
        "url": url,
        "html_url": htmlUrl,
    };
}
