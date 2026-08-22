
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
               	mov	w0, w0
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0xff              // =255
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtb	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x80               // =128
               	bl	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtb	x0, w0
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x7f               // =127
               	bl	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtb	x0, w0
               	cmp	x0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	w0, w0
               	sxtb	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x21, #0x5678            // =22136
               	movk	x21, #0x1234, lsl #16
               	mov	x0, x21
               	bl	<addr>
               	mov	w0, w0
               	sxtb	x0, w0
               	cmp	x0, #0x78
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0xabff             // =44031
               	movk	x0, #0x1234, lsl #16
               	bl	<addr>
               	mov	w0, w0
               	sxtb	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0xffff             // =65535
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	sxth	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x8000             // =32768
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	sxth	x0, w0
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x21
               	bl	<addr>
               	mov	w0, w0
               	sxth	x0, w0
               	mov	x17, #0x5678            // =22136
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x1234, lsl #16
               	bl	<addr>
               	mov	w0, w0
               	sxth	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0xffd6             // =65494
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	sxtb	x0, w0
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0xff              // =255
               	and	x20, x0, x17
               	mov	x0, #0x42               // =66
               	bl	<addr>
               	mov	x17, #0xff              // =255
               	and	x21, x0, x17
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x20, x17
               	sxtb	x1, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	lsl	x0, x1, #8
               	mov	x17, #0xff              // =255
               	and	x1, x21, x17
               	orr	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0xff42            // =65346
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
