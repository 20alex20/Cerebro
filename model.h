#include <QAbstractListModel>
#include <QStringList>


class Record {
public:
    Record(const QString &body, const bool blockDeletion);
    QString body() const;
    QString blockDeletion() const;
    void setBlockDeletion(const QVariant &value);
private:
    QString text;
    QString flag;
};

class RecordModel : public QAbstractListModel {
    Q_OBJECT
public:
    enum RecordRoles {
        BodyRole = Qt::UserRole + 1,
        BlockDeletionRole
    };

    RecordModel(QObject *parent = 0);
    void addRecord(const Record &record);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, const int role);
protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<Record> records;
};
