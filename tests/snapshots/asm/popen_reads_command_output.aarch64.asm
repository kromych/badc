
popen_reads_command_output.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	mov	x2, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	sub	x1, x29, #0x40
               	str	x1, [sp, #0x18]
               	mov	x0, x1
               	bl	<addr>
               	ldr	x1, [sp, #0x18]
               	b	<addr>
               	sub	x0, x0, #0x1
               	strb	wzr, [x1, x0]
               	cbz	x0, <addr>
               	sub	x2, x0, #0x1
               	ldrb	w3, [x1, x2]
               	cmp	w3, #0xa
               	b.eq	<addr>
               	cmp	w3, #0xd
               	b.eq	<addr>
               	sub	x3, x29, #0x40
               	ldrb	w2, [x3, x2]
               	cmp	w2, #0x20
               	b.eq	<addr>
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
