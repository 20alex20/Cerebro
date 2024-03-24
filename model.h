#include <QAbstractListModel>
#include <QStringList>
#include <QDebug>


class Record {
public:
    Record(const QString &body, const bool checked);
    QString body() const;
    bool checked() const;
    void changeChecked();
private:
    QString text;
    bool flag;
};


class RecordModel : public QAbstractListModel {
    Q_OBJECT
public:
    enum RecordRoles {
        BodyRole = Qt::UserRole + 1,
        CheckedRole
    };

    RecordModel(QObject *parent = 0);
    Q_INVOKABLE void push(const QString &body);
    Q_INVOKABLE void remove(const int index);
    Q_INVOKABLE void removeChecked();
    Q_INVOKABLE void changeChecked(const int index);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, const int role) const;
protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<Record> records;
};
