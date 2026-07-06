
switch_jump_table_dense.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	sub	x0, x0, #0x3
               	cmp	x0, #0x11
               	b.hs	<addr>
               	adr	x17, <addr>
               	ldrsw	x16, [x17, x0, lsl #2]
               	add	x17, x17, x16
               	br	x17
               	udf	#0x44
               	udf	#0x4c
               	udf	#0x54
               	udf	#0x5c
               	udf	#0x64
               	udf	#0x6c
               	udf	#0x74
               	udf	#0x7c
               	udf	#0x84
               	udf	#0x8c
               	udf	#0x94
               	udf	#0x9c
               	udf	#0xa4
               	udf	#0xb8
               	udf	#0xc0
               	udf	#0xc8
               	udf	#0xd0
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ret
               	mov	x0, #0xd                // =13
               	ret
               	mov	x0, #0xe                // =14
               	ret
               	mov	x0, #0xf                // =15
               	ret
               	mov	x0, #0x10               // =16
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>

<dense_negative_bias>:
               	add	x0, x0, #0x6
               	cmp	x0, #0x9
               	b.hs	<addr>
               	adr	x17, <addr>
               	ldrsw	x16, [x17, x0, lsl #2]
               	add	x17, x17, x16
               	br	x17
               	udf	#0x24
               	udf	#0x2c
               	udf	#0x34
               	udf	#0x3c
               	udf	#0x44
               	udf	#0x4c
               	udf	#0x54
               	udf	#0x5c
               	udf	#0x64
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>

<dense_unsigned_high>:
               	mov	w0, w0
               	mov	x17, #0xfff6            // =65526
               	movk	x17, #0xffff, lsl #16
               	sub	x0, x0, x17
               	cmp	x0, #0xa
               	b.hs	<addr>
               	adr	x17, <addr>
               	ldrsw	x16, [x17, x0, lsl #2]
               	add	x17, x17, x16
               	br	x17
               	udf	#0x28
               	udf	#0x30
               	udf	#0x38
               	udf	#0x40
               	udf	#0x48
               	udf	#0x50
               	udf	#0x58
               	udf	#0x60
               	udf	#0x68
               	udf	#0x70
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x3               // =3
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0xf
               	b.eq	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0xf
               	b.ge	<addr>
               	sub	x0, x20, #0x2
               	sxtw	x21, w0
               	sxtw	x0, w20
               	bl	<addr>
               	sxtw	x1, w21
               	cmp	x0, x1
               	b.eq	<addr>
               	b	<addr>
               	sub	x0, x20, #0x3
               	sxtw	x21, w0
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x13
               	b.le	<addr>
               	mov	x0, #0xf                // =15
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x80000000         // =2147483648
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x7fff, lsl #16
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x20, #0xfffa            // =65530
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	b	<addr>
               	mov	x0, x20
               	bl	<addr>
               	add	x1, x20, #0x7
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	x20, #0x2
               	b.le	<addr>
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x100000000        // =4294967296
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xffff00000000     // =281470681743360
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	w0, w20
               	mov	x17, #0xfff6            // =65526
               	movk	x17, #0xffff, lsl #16
               	add	x0, x0, x17
               	mov	w0, w0
               	bl	<addr>
               	mov	w1, w20
               	add	x1, x1, #0x1
               	mov	w1, w1
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	w0, w20
               	add	x20, x0, #0x1
               	mov	w0, w20
               	cmp	x0, #0xa
               	b.lo	<addr>
               	mov	x0, #0xfff5             // =65525
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x7fff, lsl #16
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
               	mov	x0, #0xd                // =13
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
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
