import 'package:courier/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MethodBadge extends StatelessWidget {
  const MethodBadge(this.method, {super.key, this.fontSize = 12, this.abbreviate = false});

  final String method;
  final double fontSize;
  final bool abbreviate;

  @override
  Widget build(BuildContext context) {
    final label = abbreviate
        ? switch (method) {
            'DELETE' => 'DEL',
            'OPTIONS' => 'OPT',
            'PATCH' => 'PTCH',
            _ => method,
          }
        : method;
    return Text(
      label,
      maxLines: 1,
      style: monoStyle(
        context,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: methodColor(method, Theme.of(context).brightness),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.statusCode, this.reasonPhrase = ''});

  final int statusCode;
  final String reasonPhrase;

  @override
  Widget build(BuildContext context) {
    final color = statusColor(statusCode, Theme.of(context).brightness);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
      child: Text(
        reasonPhrase.isEmpty ? '$statusCode' : '$statusCode $reasonPhrase',
        style: monoStyle(context, fontSize: 12.5, fontWeight: FontWeight.w700, color: color),
      ),
    );
  }
}

class MetricChip extends StatelessWidget {
  const MetricChip({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 15, color: color),
      const SizedBox(width: 4),
      Text(label, style: monoStyle(context, fontSize: 12.5, color: color)),
    ]);
  }
}
