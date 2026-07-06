
add_sub_negative_imm.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x3e8              // =1000
               	stur	x0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x8]
               	sub	x0, x0, #0x5
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	sub	x0, x0, #0xa
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x7
               	sxtw	x0, w0
               	cmp	x0, #0x11
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	sub	x0, x0, #0x64
               	cmp	x0, #0x384
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x64
               	cmp	x0, #0x44c
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	sub	x0, x0, #0xfff
               	sxtw	x0, w0
               	mov	x17, #0xf00b            // =61451
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	sxtw	x0, w0
               	mov	x17, #0xf00a            // =61450
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x20]
               	b	<addr>
               	ldursw	x0, [x29, #-0x20]
               	add	x1, x1, x0
               	ldursw	x0, [x29, #-0x20]
               	sub	x0, x0, #0x1
               	stur	w0, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x20]
               	cmp	x0, #0x0
               	b.gt	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
