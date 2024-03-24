#include "model.h"


Record::Record(const QString &body, const bool checked) : text(body), flag(checked) { }

QString Record::body() const {
    return text;
}

bool Record::checked() const {
    return flag;
}

void Record::changeChecked() {
    flag = !flag;
}


RecordModel::RecordModel(QObject *parent) : QAbstractListModel(parent) { }

void RecordModel::push(const QString &body) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    records << Record(body, false);
    endInsertRows();
}

void RecordModel::remove(const int index) {
    beginRemoveRows(QModelIndex(), index, index);
    records.removeAt(index);
    endRemoveRows();
}

void RecordModel::removeChecked() {
    int index = 0;
    while (index < records.count()) {
        if (records[index].checked()) {
            beginRemoveRows(QModelIndex(), index, index);
            records.removeAt(index);
            endRemoveRows();
        }
        else {
            index++;
        }
    }
}

void RecordModel::changeChecked(const int index) {
    records[index].changeChecked();
    const QModelIndex &i = this->index(index, 0);
    emit dataChanged(i, i, { CheckedRole });
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
    else if (role == CheckedRole)
        return record.checked();
    return QVariant();
}

QHash<int, QByteArray> RecordModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[BodyRole] = "body";
    roles[CheckedRole] = "checked";
    return roles;
}
