object DataMod: TDataMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 370
  Width = 440
  object DataBase: TIBDatabase
    DatabaseName = 'D:\Git\teste-delphi\Ex2\IMPOSTO.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = Transaction
    ServerType = 'IBServer'
    Left = 64
    Top = 48
  end
  object Query: TIBQuery
    Database = DataBase
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 128
    Top = 48
  end
  object Transaction: TIBTransaction
    DefaultDatabase = DataBase
    Left = 64
    Top = 112
  end
  object cdsMem: TClientDataSet
    Aggregates = <>
    MasterSource = dsQuery
    PacketRecords = 0
    Params = <>
    Left = 208
    Top = 120
  end
  object dsQuery: TDataSource
    DataSet = Query
    Left = 208
    Top = 56
  end
  object Provider: TDataSetProvider
    DataSet = cdsMem
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 272
    Top = 120
  end
end
