import 'package:deeper_riverpod_education/src/features/postcard/domain/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostCard extends ConsumerWidget {
  const PostCard({super.key});

  int countDaysUntilBirthDate(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int daysUntilBirthDate = -1;
    DateTime targetDate =
        DateTime(currentDate.year, birthDate.month, birthDate.day);

    if (currentDate.isAfter(targetDate)) {
      targetDate =
          DateTime(currentDate.year + 1, birthDate.month, birthDate.day);
    }
    Duration difference = targetDate.difference(currentDate);
    daysUntilBirthDate = difference.inDays;
    return daysUntilBirthDate;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userdata = ref.watch(userDataProvider);
    int? dayUntilBirthDate;
    if (userdata.user != null) {
      dayUntilBirthDate = countDaysUntilBirthDate(userdata.user!.birthDate);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('What about your Birthday? :)')),
      body: (userdata.user != null && dayUntilBirthDate != null)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Container(
                  padding: const EdgeInsets.all(50),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: (dayUntilBirthDate == 0)
                      ? Text(
                          maxLines: 3,
                          'Happy birthday to you${userdata.user != null ? ', ${userdata.user?.name.value}' : ''}!!!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          maxLines: 3,
                          "${userdata.user != null ? '${userdata.user?.name.value}, ' : ''} $dayUntilBirthDate days left until your birthday.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 25, fontWeight: FontWeight.normal),
                        ),
                ),
                const Spacer(
                  flex: 1,
                ),
                TextButton(
                  onPressed: () {
                    userdata.removeUserData();
                  },
                  child: Text(
                    'Clear data',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
