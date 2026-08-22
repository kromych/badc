
switch_no_jump_tables.aarch64:	file format elf64-littleaarch64

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

<fallthrough_sum>:
               	mov	x1, x0
               	sxtw	x1, w1
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x4
               	b.lt	<addr>
               	cmp	w1, #0x6
               	b.lt	<addr>
               	cmp	w1, #0x7
               	b.lt	<addr>
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxtw	x0, w0
               	ret
               	add	x0, x0, #0x80
               	b	<addr>
               	add	x0, x0, #0x40
               	b	<addr>
               	cmp	w1, #0x5
               	b.lt	<addr>
               	add	x0, x0, #0x20
               	b	<addr>
               	add	x0, x0, #0x10
               	b	<addr>
               	cmp	w1, #0x2
               	b.lt	<addr>
               	cmp	w1, #0x3
               	b.lt	<addr>
               	add	x0, x0, #0x8
               	b	<addr>
               	add	x0, x0, #0x4
               	b	<addr>
               	cmp	w1, #0x1
               	b.lt	<addr>
               	add	x0, x0, #0x2
               	b	<addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x3                // =3
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	b	<addr>
               	cmp	x0, #0xf
               	b.eq	<addr>
               	cmp	x0, #0xf
               	b.ge	<addr>
               	sub	x1, x0, #0x2
               	sxtw	x2, w1
               	cmp	w0, #0xb
               	b.lt	<addr>
               	cmp	w0, #0x10
               	b.lt	<addr>
               	cmp	x0, #0x12
               	b.lt	<addr>
               	cmp	x0, #0x13
               	b.lt	<addr>
               	mov	x1, #0x10               // =16
               	sxtw	x2, w2
               	cmp	x1, x2
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #0xf                // =15
               	b	<addr>
               	cmp	x0, #0x11
               	b.lt	<addr>
               	mov	x1, #0xe                // =14
               	b	<addr>
               	mov	x1, #0xd                // =13
               	b	<addr>
               	cmp	x0, #0xd
               	b.lt	<addr>
               	cmp	x0, #0xe
               	b.lt	<addr>
               	cmp	x0, #0xe
               	b.eq	<addr>
               	mov	x1, x3
               	b	<addr>
               	mov	x1, #0xc                // =12
               	b	<addr>
               	mov	x1, #0xb                // =11
               	b	<addr>
               	cmp	x0, #0xc
               	b.lt	<addr>
               	mov	x1, #0xa                // =10
               	b	<addr>
               	mov	x1, #0x9                // =9
               	b	<addr>
               	cmp	w0, #0x7
               	b.lt	<addr>
               	cmp	x0, #0x9
               	b.lt	<addr>
               	cmp	x0, #0xa
               	b.lt	<addr>
               	mov	x1, #0x8                // =8
               	b	<addr>
               	mov	x1, #0x7                // =7
               	b	<addr>
               	cmp	x0, #0x8
               	b.lt	<addr>
               	mov	x1, #0x6                // =6
               	b	<addr>
               	mov	x1, #0x5                // =5
               	b	<addr>
               	cmp	x0, #0x5
               	b.lt	<addr>
               	cmp	w0, #0x6
               	b.lt	<addr>
               	mov	x1, #0x4                // =4
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x4
               	b.lt	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	cmp	w0, #0x3
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	sub	x1, x0, #0x3
               	sxtw	x2, w1
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	x0, #0x13
               	b.le	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, x0
               	mov	x1, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, x0
               	mov	x1, x0
               	mov	x0, #0xfffa             // =65530
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x4, #0xfffa             // =65530
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x5, #0xfffb             // =65531
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x6, #0xfffc             // =65532
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x7, #0xfffd             // =65533
               	movk	x7, #0xffff, lsl #16
               	movk	x7, #0xffff, lsl #32
               	movk	x7, #0xffff, lsl #48
               	mov	x8, #0xfffe             // =65534
               	movk	x8, #0xffff, lsl #16
               	movk	x8, #0xffff, lsl #32
               	movk	x8, #0xffff, lsl #48
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	b	<addr>
               	cmp	x0, x8
               	b.lt	<addr>
               	cmp	x0, #0x0
               	b.lt	<addr>
               	cmp	x0, #0x1
               	b.lt	<addr>
               	cmp	x0, #0x2
               	b.lt	<addr>
               	mov	x1, #0x9                // =9
               	add	x3, x0, #0x7
               	sxtw	x3, w3
               	cmp	x1, x3
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #0x8                // =8
               	b	<addr>
               	mov	x1, #0x7                // =7
               	b	<addr>
               	cmp	x0, x2
               	b.lt	<addr>
               	mov	x1, #0x6                // =6
               	b	<addr>
               	mov	x1, #0x5                // =5
               	b	<addr>
               	cmp	x0, x6
               	b.lt	<addr>
               	cmp	x0, x7
               	b.lt	<addr>
               	mov	x1, #0x4                // =4
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	x0, x5
               	b.lt	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	cmp	x0, x4
               	b.eq	<addr>
               	mov	x1, x2
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	x0, #0x2
               	b.le	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x2, #0xfff6             // =65526
               	movk	x2, #0xffff, lsl #16
               	mov	x5, #0xfff7             // =65527
               	movk	x5, #0xffff, lsl #16
               	mov	x6, #0xfff8             // =65528
               	movk	x6, #0xffff, lsl #16
               	mov	x7, #0xfff9             // =65529
               	movk	x7, #0xffff, lsl #16
               	mov	x8, #0xfffa             // =65530
               	movk	x8, #0xffff, lsl #16
               	mov	x9, #0xfffb             // =65531
               	movk	x9, #0xffff, lsl #16
               	mov	x10, #0xfffc            // =65532
               	movk	x10, #0xffff, lsl #16
               	mov	x11, #0xfffd            // =65533
               	movk	x11, #0xffff, lsl #16
               	mov	x12, #0xfffe            // =65534
               	movk	x12, #0xffff, lsl #16
               	mov	x13, #0xffff            // =65535
               	movk	x13, #0xffff, lsl #16
               	b	<addr>
               	add	x0, x0, x2
               	mov	w0, w0
               	mov	w0, w0
               	cmp	x0, x9
               	b.lo	<addr>
               	cmp	x0, x11
               	b.lo	<addr>
               	cmp	x0, x12
               	b.lo	<addr>
               	cmp	x0, x13
               	b.lo	<addr>
               	mov	x0, #0xa                // =10
               	mov	w3, w1
               	add	x3, x3, #0x1
               	mov	w3, w3
               	sxtw	x3, w3
               	cmp	x0, x3
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	cmp	x0, x10
               	b.lo	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	cmp	x0, x6
               	b.lo	<addr>
               	cmp	x0, x7
               	b.lo	<addr>
               	cmp	x0, x8
               	b.lo	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, x5
               	b.lo	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, x4
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	w0, w1
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	x0, #0xa
               	b.lo	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, x0
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	x1, #0x100              // =256
               	mov	x0, #0x1                // =1
               	sxtw	x2, w20
               	lsl	x0, x0, x2
               	sub	x0, x1, x0
               	sxtw	x21, w0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, x21
               	b.ne	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	x20, #0x7
               	b.le	<addr>
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
