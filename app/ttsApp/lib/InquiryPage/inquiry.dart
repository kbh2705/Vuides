import 'package:flutter/material.dart';

class Inquiry extends StatelessWidget {
  const Inquiry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "문의하기",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "자주묻는 질문",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              for (int i = 1; i <= 4; i++) ...[
                ListTile(
                  title: Text("Q. 질문 $i"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Handle your onTap here
                  },
                ),
                const Divider(indent: 16, endIndent: 16),
              ],
              const Spacer(),
              Center(
                child: Text(
                  "도움말을 통해 \n문제를 해결하지 못하셨나요?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Handle your onPressed event here
                  },
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text("문의하기"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(230, 50), // set the size
                    primary: Color(0xff473E7C),
                    onPrimary: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
