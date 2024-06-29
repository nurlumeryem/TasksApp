class TaskService {}


/*if (statusCodeEnums.isSuccess()) {
        final responseBody = request.body;

        List<dynamic> decodedBoy = json.decode(responseBody);

        List<WithdrawBankAccountModel> bankList = decodedBoy
            .map((json) => WithdrawBankAccountModel.fromJson(json))
            .toList();

        print(
            "BankAccountsService /getBankAccounts lenght : ${bankList.length} ");

        return Right(bankList);
      } else {
        print(
          "BankAccountsService /getBankAccounts ${request.statusCode} ${request.reasonPhrase}  ",
        );

        return Left(Failure("Hata!!!"));
      }*/
