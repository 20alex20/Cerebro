#include "model.h"


Record::Record(const QString &body, const bool blockDeletion) : text(body), flag(blockDeletion) { }

QString Record::body() const {
    return text;
}

bool Record::blockDeletion() const {
    return flag;
}

void Record::changeBlockDeletion() {
    flag = !flag;
}


RecordModel::RecordModel(QObject *parent) : QAbstractListModel(parent) { }

void RecordModel::push(const QString &body) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    records << Record(body, false);
    endInsertRows();
}

void RecordModel::remove(const int index, const int count) {
    beginRemoveRows(QModelIndex(), index, index + count - 1);
    for (int row = 0; row < count; ++row) {
        records.removeAt(index);
    }
    endRemoveRows();
}

void RecordModel::changeBlockDeletion(const int index) {
    if (index < 0 || index >= records.count())
        return;

    records[index].changeBlockDeletion();
    const QModelIndex &i = this->index(index, 0);
    emit dataChanged(i, i, { BlockDeletionRole });
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

QHash<int, QByteArray> RecordModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[BodyRole] = "body";
    roles[BlockDeletionRole] = "blockDeletion";
    return roles;
}
