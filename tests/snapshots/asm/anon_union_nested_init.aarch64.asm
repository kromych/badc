
anon_union_nested_init.aarch64:	file format elf64-littleaarch64

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

<check_const>:
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	ret

<opaque>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_runtime>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x20, x0
               	mov	x22, x1
               	sub	x0, x29, #0x18
               	mov	x23, #0x0               // =0
               	str	x23, [x0]
               	str	x23, [x0, #0x8]
               	strb	w20, [x0]
               	strb	w22, [x0, #0x1]
               	add	x1, x20, x22
               	strb	w1, [x0, #0x2]
               	mul	x21, x20, x22
               	strb	w21, [x0, #0x3]
               	bl	<addr>
               	mov	x1, x0
               	ldrb	w0, [x1]
               	mov	x17, #0xff              // =255
               	and	x2, x20, x17
               	cmp	w0, w2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x1, #0x3]
               	mov	x17, #0xff              // =255
               	and	x1, x21, x17
               	cmp	w0, w1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sub	x0, x29, #0x8
               	str	x23, [x0]
               	mov	x1, #0x9                // =9
               	strb	w1, [x0]
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x1]
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x2]
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x3]
               	str	w20, [x0, #0x4]
               	bl	<addr>
               	mov	x1, x0
               	ldrb	w0, [x1]
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	mov	w2, w0
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrb	w0, [x1, #0x3]
               	mov	x17, #0x6               // =6
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x1, #0x4]
               	cmp	w0, w20
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
