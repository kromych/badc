
signed_cast_extends.aarch64:	file format elf64-littleaarch64

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

<rtu>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0xff               // =255
               	bl	<addr>
               	and	x0, x0, #0xff
               	sxtb	x0, w0
               	cmn	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x80               // =128
               	bl	<addr>
               	and	x0, x0, #0xff
               	sxtb	x0, w0
               	cmn	w0, #0x80
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7f               // =127
               	bl	<addr>
               	and	x0, x0, #0xff
               	sxtb	x0, w0
               	cmp	w0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	bl	<addr>
               	sxtb	x0, w0
               	cmn	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	bl	<addr>
               	sxtb	x0, w0
               	cmp	w0, #0x78
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xabff             // =44031
               	movk	x0, #0x1234, lsl #16
               	bl	<addr>
               	sxtb	x0, w0
               	cmn	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	bl	<addr>
               	and	x0, x0, #0xffff
               	sxth	x0, w0
               	cmn	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8000             // =32768
               	bl	<addr>
               	and	x0, x0, #0xffff
               	sxth	x0, w0
               	mov	x17, #-0x8000           // =-32768
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	bl	<addr>
               	sxth	x0, w0
               	mov	x17, #0x5678            // =22136
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x1234, lsl #16
               	bl	<addr>
               	sxth	x0, w0
               	cmn	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffd6             // =65494
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	sxtb	x0, w0
               	cmn	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	bl	<addr>
               	and	x16, x0, #0xff
               	str	x16, [sp, #0x8]
               	mov	x0, #0x42               // =66
               	bl	<addr>
               	and	x16, x0, #0xff
               	str	x16, [sp]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	ldr	x16, [sp, #0x8]
               	sxtb	x0, w16
               	cmn	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x16, [sp]
               	orr	x0, x16, #0xffffffffffffff00
               	cmn	w0, #0xbe
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
