
struct_tm_tm_zone_offset.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	sub	x20, x29, #0x38
               	mov	x1, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldr	x0, [x20, #0x30]
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldr	x0, [x20, #0x30]
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x40
               	b.le	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
