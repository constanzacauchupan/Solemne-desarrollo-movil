import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'registration_screen.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> usuario;

  const ProfileScreen({super.key, required this.usuario});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : s;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final usuario = widget.usuario;
    final String nombre = usuario["nombre"] ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Editar datos',
            onPressed: () async {
              final editado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      RegistrationScreen(usuarioExistente: usuario),
                ),
              );
              if (editado != null) {
                editado.forEach((k, v) => usuario[k] = v);
                setState(() {});
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Configuración',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SettingsScreen(usuario: usuario)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Avatar y nombre ───────────────────────────────────────────
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(
                      nombre.isNotEmpty ? nombre[0].toUpperCase() : '?',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(nombre,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    usuario["correo"] ?? "",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Información personal ──────────────────────────────────────
            Text('Información personal',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _InfoCard(children: [
              _InfoRow(
                icon: Icons.phone_outlined,
                label: 'Teléfono',
                value: usuario["telefono"]?.toString() ?? "—",
              ),
              const Divider(height: 1),
              _InfoRow(
                icon: Icons.cake_outlined,
                label: 'Edad',
                value: usuario["edad"] != null
                    ? '${usuario["edad"]} años'
                    : "—",
              ),
              const Divider(height: 1),
              _InfoRow(
                icon: Icons.notes_outlined,
                label: 'Descripción',
                value: usuario["descripcion"] ?? "—",
              ),
            ]),

            const SizedBox(height: 24),

            // ── Preferencias ──────────────────────────────────────────────
            Text('Preferencias',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _InfoCard(children: [
              _InfoRow(
                icon: Icons.palette_outlined,
                label: 'Tema',
                value: _capitalize(
                    usuario["tema"]?.toString() ?? "sistema"),
              ),
              const Divider(height: 1),
              _InfoRow(
                icon: Icons.color_lens_outlined,
                label: 'Color principal',
                value: _capitalize(
                    usuario["colorPrincipal"]?.toString() ?? "azul"),
              ),
              const Divider(height: 1),
              _InfoRow(
                icon: Icons.notifications_outlined,
                label: 'Notificaciones',
                value: (usuario["notificacionesGenerales"] == true)
                    ? 'Activadas'
                    : 'Desactivadas',
              ),
            ]),

            // ── Chips tipos de notificación ───────────────────────────────
            Builder(builder: (context) {
              final tipos = [
                if (usuario["notifPromociones"] == true) 'Promociones',
                if (usuario["notifRecordatorios"] == true) 'Recordatorios',
                if (usuario["notifAlertas"] == true) 'Alertas críticas',
              ];
              if (tipos.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text('Tipos de notificación activos',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tipos
                        .map((t) => Chip(
                              label: Text(t),
                              backgroundColor: colorScheme.secondaryContainer,
                              labelStyle: TextStyle(
                                  color: colorScheme.onSecondaryContainer),
                            ))
                        .toList(),
                  ),
                ],
              );
            }),

            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar datos'),
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    onPressed: () async {
                      final editado = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegistrationScreen(
                              usuarioExistente: usuario),
                        ),
                      );
                      if (editado != null) {
                        editado.forEach((k, v) => usuario[k] = v);
                        setState(() {});
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.settings_outlined),
                    label: const Text('Preferencias'),
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SettingsScreen(usuario: usuario)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ── Widgets auxiliares ────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant, width: 0.5),
      ),
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 12),
          Text(label,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: colorScheme.onSurfaceVariant)),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}