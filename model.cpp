#include "model.h"

Record::Record(const QString &body, const bool blockDeletion) : text(body), flag(blockDeletion) { }

QString Record::body() const {
    return text;
}

QString Record::blockDeletion() const {
    return flag;
}

void Record::setBlockDeletion(const QVariant &value) {
    flag = value.toBool();
}


RecordModel::RecordModel(QObject *parent) : QAbstractListModel(parent) { }

void RecordModel::addRecord(const Record &record) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    records << record;
    endInsertRows();
}

int RecordModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return records.count();
}

QVariant RecordModel::data(const QModelIndex &index, const int role) const {
    if (index.row() < 0 || index.row() >= records.count())
        return QVariant();

    const Record &record = records[index.row()];
    if (role == BodyRole)
        return record.body();
    else if (role == BlockDeletionRole)
        return record.blockDeletion();
    return QVariant();
}

bool RecordModel::setData(const QModelIndex &index, const QVariant &value, const int role) {
    if (index.row() < 0 || index.row() >= records.count())
        return false;

    if (role == BlockDeletionRole) {
        records[index.row()].setBlockDeletion(value);
        return true;
    }
    return false;
}

QHash<int, QByteArray> RecordModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[BodyRole] = "body";
    roles[BlockDeletionRole] = "blockDeletion";
    return roles;
}
