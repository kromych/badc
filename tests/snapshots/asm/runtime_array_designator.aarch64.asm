
runtime_array_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<check>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x2, #0x7                // =7
               	mov	x3, #0x3                // =3
               	mov	x4, #0x5                // =5
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x18
               	str	w2, [x0, #0xc]
               	sub	x0, x29, #0x18
               	str	w3, [x0, #0x4]
               	sub	x0, x29, #0x18
               	str	w4, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x7                // =7
               	mov	x1, #0x3                // =3
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x4                // =4
               	mov	x3, #0x9                // =9
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	str	w2, [x0]
               	sub	x0, x29, #0x10
               	str	w3, [x0]
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
