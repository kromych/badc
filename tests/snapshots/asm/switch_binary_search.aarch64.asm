
switch_binary_search.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2a0              // =672
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<classify_signed>:
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.lt	<addr>
               	cmp	x0, #0x2a
               	b.lt	<addr>
               	cmp	x0, #0x3e8
               	b.lt	<addr>
               	cmp	x0, #0x3e8
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x7                // =7
               	ret
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	cmp	x0, #0x7
               	b.lt	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.lt	<addr>
               	cmp	x0, #0x0
               	b.lt	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x17, #0xff9c            // =65436
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret

<classify_unsigned>:
               	mov	w0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, #0x5
               	b.lo	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, #0xff9c             // =65436
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0xfffd             // =65533
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x0                // =0
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x1                // =1
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x7                // =7
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x2a               // =42
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x3e8              // =1000
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x8                // =8
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x3e7              // =999
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x5                // =5
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0x7fff, lsl #16
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x80000000         // =2147483648
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x1                // =1
               	movk	x1, #0x8000, lsl #16
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x25               // =37
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
