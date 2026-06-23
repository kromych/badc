
tail_call_args_from_spill.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sxtw	x2, w2
               	sxtw	x3, w3
               	sxtw	x0, w0
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	lsl	x1, x3, #2
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<forward>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	str	x20, [sp]
               	sxtw	x0, w0
               	sxtw	x1, w0
               	add	x2, x0, #0x1
               	sxtw	x2, w2
               	add	x3, x0, #0x2
               	sxtw	x3, w3
               	add	x4, x0, #0x3
               	sxtw	x4, w4
               	add	x5, x0, #0x4
               	sxtw	x5, w5
               	add	x6, x0, #0x5
               	sxtw	x6, w6
               	add	x7, x0, #0x6
               	sxtw	x7, w7
               	add	x8, x0, #0x7
               	sxtw	x8, w8
               	add	x9, x0, #0x8
               	sxtw	x9, w9
               	add	x10, x0, #0x9
               	sxtw	x10, w10
               	add	x11, x0, #0xa
               	sxtw	x11, w11
               	add	x12, x0, #0xb
               	sxtw	x12, w12
               	add	x13, x0, #0xc
               	sxtw	x13, w13
               	add	x14, x0, #0xd
               	sxtw	x14, w14
               	add	x15, x0, #0xe
               	sxtw	x15, w15
               	add	x0, x0, #0xf
               	sxtw	x0, w0
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x1, x1, x4
               	sxtw	x1, w1
               	add	x1, x1, x5
               	sxtw	x1, w1
               	add	x1, x1, x7
               	sxtw	x1, w1
               	add	x1, x1, x8
               	sxtw	x1, w1
               	add	x1, x1, x9
               	sxtw	x1, w1
               	add	x1, x1, x10
               	sxtw	x1, w1
               	add	x1, x1, x11
               	sxtw	x1, w1
               	add	x1, x1, x12
               	sxtw	x1, w1
               	add	x1, x1, x13
               	sxtw	x1, w1
               	add	x1, x1, x15
               	sxtw	x1, w1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w3
               	lsl	x1, x6, #1
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0x3               // =3
               	mul	x1, x10, x17
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	lsl	x1, x14, #2
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w20
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w20
               	cmp	x0, #0xbf
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
