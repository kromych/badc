
offsetof_runtime_subscript.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x6                // =6
               	mov	x3, #0xc                // =12
               	b	<addr>
               	sxtw	x1, w0
               	mul	x4, x1, x3
               	add	x4, x4, #0x58
               	mul	x5, x1, x2
               	lsl	x5, x5, #1
               	add	x5, x5, #0x58
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x3                // =3
               	ret
