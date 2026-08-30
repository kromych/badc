
switch_jump_table_dense.aarch64:	file format elf64-littleaarch64

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

<dense_signed>:
               	sxtw	x0, w0
               	sub	x0, x0, #0x3
               	cmp	x0, #0x11
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
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

<dense_negative_bias>:
               	add	x0, x0, #0x6
               	cmp	x0, #0x9
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
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

<dense_unsigned_high>:
               	mov	w0, w0
               	mov	x17, #0xfff6            // =65526
               	movk	x17, #0xffff, lsl #16
               	sub	x0, x0, x17
               	cmp	x0, #0xa
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
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

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x3               // =3
               	b	<addr>
               	cmp	w20, #0xf
               	b.eq	<addr>
               	cmp	w20, #0xf
               	b.ge	<addr>
               	sub	x0, x20, #0x2
               	sxtw	x21, w0
               	mov	x0, x20
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
               	cmp	w20, #0x13
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
               	mov	x21, #0x2               // =2
               	mov	x0, x21
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
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x0, x20
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
               	mov	x0, #0xfffa             // =65530
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xfffb             // =65531
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0x2
               	b.ne	<addr>
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x6
               	b.ne	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x8
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x9
               	b.ne	<addr>
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
               	mov	x0, #0xfff6             // =65526
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xfff7             // =65527
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x2
               	b.ne	<addr>
               	mov	x0, #0xfff8             // =65528
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	mov	x0, #0xfffa             // =65530
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	mov	x0, #0xfffb             // =65531
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x6
               	b.ne	<addr>
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x8
               	b.ne	<addr>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x9
               	b.ne	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	cmp	x0, #0xa
               	b.ne	<addr>
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
               	mov	x0, x20
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
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
