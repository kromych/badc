
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
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x21, x0
               	cbnz	x21, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	mov	x2, x21
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x20, x29, #0x40
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, #0xa                // =10
               	mov	x3, #0xd                // =13
               	cbz	x0, <addr>
               	sub	x1, x0, #0x1
               	ldrb	w4, [x20, x1]
               	eor	x4, x4, x2
               	cbz	w4, <addr>
               	ldrb	w4, [x20, x1]
               	eor	x4, x4, x3
               	cbz	w4, <addr>
               	sub	x4, x29, #0x40
               	ldrb	w1, [x4, x1]
               	eor	x1, x1, #0x20
               	cbnz	w1, <addr>
               	sub	x0, x0, #0x1
               	strb	wzr, [x20, x0]
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
