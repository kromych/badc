
pointer_to_array_cast.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0x0                // =0
               	mov	x5, #0x3                // =3
               	b	<addr>
               	sub	x3, x29, #0x30
               	sxtw	x1, w0
               	mul	x2, x1, x5
               	mov	x4, x2
               	strh	w4, [x3, x1, lsl #1]
               	add	x0, x1, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	sub	x0, x29, #0x30
               	add	x1, x0, #0x10
               	sub	x1, x1, x0
               	cmp	x1, #0x10
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsh	x1, [x0, #0x14]
               	cmp	w1, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsh	x0, [x0, #0xc]
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
