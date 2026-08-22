
struct_field_displacement.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x18
               	stur	x0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	mov	x2, #0x1                // =1
               	str	w2, [x0]
               	mov	x1, #0x16               // =22
               	str	w1, [x0, #0x4]
               	mov	x1, #0x14d              // =333
               	str	x1, [x0, #0x8]
               	mov	x1, #0x2c               // =44
               	strh	w1, [x0, #0x10]
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x12]
               	mov	x1, #0x63               // =99
               	str	w1, [x0, #0x4]
               	mov	x3, #0x309              // =777
               	str	x3, [x0, #0x8]
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x4]
               	ldr	x1, [x0, #0x8]
               	add	x1, x1, #0xa
               	str	x1, [x0, #0x8]
               	ldrb	w1, [x0, #0x12]
               	add	x1, x1, #0x1
               	strb	w1, [x0, #0x12]
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x64
               	b.eq	<addr>
               	mov	x0, x2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x313
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsh	x1, [x0, #0x10]
               	cmp	w1, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0, #0x12]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
