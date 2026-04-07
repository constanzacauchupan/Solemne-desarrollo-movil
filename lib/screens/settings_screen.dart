import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Map<String, dynamic> usuario;

  const SettingsScreen({super.key, required this.usuario});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Preferencias visuales
  late String _tema;
  late String _colorPrincipal;

  // Preferencias de notificación
  late bool _notificacionesGenerales;
  late bool _notifPromociones;
  late bool _notifRecordatorios;
  late bool _notifAlertas;

  @override
  void initState() {
    super.initState();
    _tema = widget.usuario["tema"]?.toString() ?? "sistema";
    _colorPrincipal =
        widget.usuario["colorPrincipal"]?.toString() ?? "azul";
    _notificacionesGenerales =
        widget.usuario["notificacionesGenerales"] == true;
    _notifPromociones = widget.usuario["notifPromociones"] == true;
    _notifRecordatorios = widget.usuario["notifRecordatorios"] == true;
    _notifAlertas = widget.usuario["notifAlertas"] == true;
  }

  void _guardar() {
    // Persiste en el mismo Map que vino de usuariosSolemne
    widget.usuario["tema"] = _tema;
    widget.usuario["colorPrincipal"] = _colorPrincipal;
    widget.usuario["notificacionesGenerales"] = _notificacionesGenerales;
    widget.usuario["notifPromociones"] = _notifPromociones;
    widget.usuario["notifRecordatorios"] = _notifRecordatorios;
    widget.usuario["notifAlertas"] = _notifAlertas;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preferencias guardadas correctamente'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilledButton(
              onPressed: _guardar,
              child: const Text('Guardar'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Preferencias visuales ────────────────────────────────────
            _SectionHeader(
                icon: Icons.palette_outlined,
                title: 'Preferencias visuales'),
            const SizedBox(height: 16),

            Text('Tema de la aplicación',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 8),

            _OptionCard(
              child: Column(
                children: [
                  for (final opcion in ['claro', 'oscuro', 'sistema'])
                    RadioListTile<String>(
                      value: opcion,
                      groupValue: _tema,
                      title: Text({
                        'claro': 'Claro',
                        'oscuro': 'Oscuro',
                        'sistema': 'Sistema (automático)',
                      }[opcion]!),
                      secondary: Icon({
                        'claro': Icons.light_mode_outlined,
                        'oscuro': Icons.dark_mode_outlined,
                        'sistema': Icons.brightness_auto_outlined,
                      }[opcion]),
                      onChanged: (v) {
                        if (v != null) setState(() => _tema = v);
                      },
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text('Color principal',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 8),

            _OptionCard(
              child: DropdownButtonFormField<String>(
                value: _colorPrincipal,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.color_lens_outlined),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'azul',
                    child: Row(children: [
                      Icon(Icons.circle, color: Colors.blue, size: 16),
                      SizedBox(width: 10),
                      Text('Azul'),
                    ]),
                  ),
                  DropdownMenuItem(
                    value: 'verde',
                    child: Row(children: [
                      Icon(Icons.circle, color: Colors.green, size: 16),
                      SizedBox(width: 10),
                      Text('Verde'),
                    ]),
                  ),
                  DropdownMenuItem(
                    value: 'naranja',
                    child: Row(children: [
                      Icon(Icons.circle, color: Colors.orange, size: 16),
                      SizedBox(width: 10),
                      Text('Naranja'),
                    ]),
                  ),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _colorPrincipal = v);
                },
              ),
            ),

            const SizedBox(height: 28),

            // ── Preferencias de notificación ─────────────────────────────
            _SectionHeader(
                icon: Icons.notifications_outlined,
                title: 'Preferencias de notificación'),
            const SizedBox(height: 16),

            _OptionCard(
              child: SwitchListTile(
                secondary:
                    const Icon(Icons.notifications_active_outlined),
                title: const Text('Notificaciones generales'),
                subtitle: const Text('Activar o desactivar todas'),
                value: _notificacionesGenerales,
                onChanged: (v) =>
                    setState(() => _notificacionesGenerales = v),
              ),
            ),

            const SizedBox(height: 16),

            Text('Tipos de notificación',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 8),

            _OptionCard(
              child: Column(
                children: [
                  CheckboxListTile(
                    secondary: const Icon(Icons.local_offer_outlined),
                    title: const Text('Promociones'),
                    subtitle: const Text('Ofertas y descuentos'),
                    value: _notifPromociones,
                    enabled: _notificacionesGenerales,
                    onChanged: (v) {
                      if (v != null)
                        setState(() => _notifPromociones = v);
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  CheckboxListTile(
                    secondary: const Icon(Icons.alarm_outlined),
                    title: const Text('Recordatorios'),
                    subtitle: const Text('Tareas y eventos próximos'),
                    value: _notifRecordatorios,
                    enabled: _notificacionesGenerales,
                    onChanged: (v) {
                      if (v != null)
                        setState(() => _notifRecordatorios = v);
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  CheckboxListTile(
                    secondary:
                        const Icon(Icons.warning_amber_outlined),
                    title: const Text('Alertas críticas'),
                    subtitle: const Text('Avisos importantes del sistema'),
                    value: _notifAlertas,
                    enabled: _notificacionesGenerales,
                    onChanged: (v) {
                      if (v != null) setState(() => _notifAlertas = v);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _guardar,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Guardar cambios'),
                style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ── Widgets auxiliares ────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      children: [
        Icon(icon, color: colorScheme.primary, size: 22),
        const SizedBox(width: 10),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _OptionCard extends StatelessWidget {
  final Widget child;
  const _OptionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: child,
      ),
    );
  }
}