
attribute_alias_target_later.aarch64:	file format elf64-littleaarch64

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

<probe_generic>:
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x1, x2, x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<after_alias>:
               	mov	x0, #0x5                // =5
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	bl	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrsw	x0, [x20]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	ldrsw	x0, [x20]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x4
               	str	w0, [x20]
               	sxtw	x0, w0
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
