
switch_jump_table_phi_join.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0x0                // =0
               	mov	x4, #0xfffe             // =65534
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x8, #0xfffe             // =65534
               	movk	x8, #0xffff, lsl #16
               	movk	x8, #0xffff, lsl #32
               	movk	x8, #0xffff, lsl #48
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x5, #0x3                // =3
               	mov	x6, #0x1f               // =31
               	mov	x7, #0x21               // =33
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mul	x9, x2, x7
               	sxtw	x3, w4
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	add	x2, x0, #0x2
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	add	x2, x2, x0
               	mul	x0, x0, x5
               	sub	x2, x2, x0
               	add	x0, x0, x2
               	lsl	x2, x2, #1
               	sub	x0, x0, #0x1
               	add	x2, x2, #0x7
               	add	x0, x0, x2
               	mul	x2, x2, x6
               	add	x0, x2, x0
               	add	x2, x9, x0
               	mov	x0, #0x1                // =1
               	mul	x9, x2, x7
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	mov	x2, #0x0                // =0
               	add	x0, x2, #0x2
               	add	x2, x2, x0
               	mul	x0, x0, x5
               	sub	x2, x2, x0
               	add	x0, x0, x2
               	lsl	x2, x2, #1
               	sub	x0, x0, #0x1
               	add	x2, x2, #0x7
               	add	x0, x0, x2
               	mul	x2, x2, x6
               	add	x0, x2, x0
               	add	x2, x9, x0
               	mov	x0, #0x2                // =2
               	mul	x9, x2, x7
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	mov	x2, #0x0                // =0
               	add	x0, x2, #0x2
               	add	x2, x2, x0
               	mul	x0, x0, x5
               	sub	x2, x2, x0
               	add	x0, x0, x2
               	lsl	x2, x2, #1
               	sub	x0, x0, #0x1
               	add	x2, x2, #0x7
               	add	x0, x0, x2
               	mul	x2, x2, x6
               	add	x0, x2, x0
               	add	x2, x9, x0
               	mov	x0, #0x0                // =0
               	mul	x11, x2, x7
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	mov	x2, #0x1                // =1
               	add	x9, x2, #0x2
               	add	x10, x2, x9
               	mul	x2, x9, x5
               	sub	x9, x10, x2
               	add	x2, x2, x9
               	lsl	x9, x9, #1
               	sub	x10, x2, #0x1
               	add	x2, x9, #0x7
               	add	x9, x10, x2
               	mul	x2, x2, x6
               	add	x2, x2, x9
               	add	x9, x11, x2
               	mov	x2, #0x1                // =1
               	mul	x10, x9, x7
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	add	x9, x2, #0x2
               	mov	x16, x9
               	mov	x9, x2
               	mov	x2, x16
               	add	x9, x9, x2
               	mul	x2, x2, x5
               	sub	x9, x9, x2
               	add	x2, x2, x9
               	lsl	x9, x9, #1
               	sub	x2, x2, #0x1
               	add	x9, x9, #0x7
               	add	x2, x2, x9
               	mul	x9, x9, x6
               	add	x2, x9, x2
               	add	x9, x10, x2
               	mov	x2, #0x2                // =2
               	mul	x9, x9, x7
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	mov	x0, #0x1                // =1
               	add	x2, x0, #0x2
               	add	x0, x0, x2
               	mul	x2, x2, x5
               	sub	x0, x0, x2
               	add	x2, x2, x0
               	lsl	x0, x0, #1
               	sub	x2, x2, #0x1
               	add	x0, x0, #0x7
               	add	x2, x2, x0
               	mul	x0, x0, x6
               	add	x0, x0, x2
               	add	x9, x9, x0
               	mov	x0, #0x1                // =1
               	mov	x2, #0x0                // =0
               	mul	x10, x9, x7
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	mov	x9, #0x2                // =2
               	add	x2, x9, #0x2
               	add	x9, x9, x2
               	mul	x2, x2, x5
               	sub	x9, x9, x2
               	add	x2, x2, x9
               	lsl	x9, x9, #1
               	sub	x2, x2, #0x1
               	add	x9, x9, #0x7
               	add	x2, x2, x9
               	mul	x9, x9, x6
               	add	x2, x9, x2
               	add	x9, x10, x2
               	mov	x2, #0x1                // =1
               	mul	x10, x9, x7
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	mov	x9, #0x2                // =2
               	add	x2, x9, #0x2
               	add	x9, x9, x2
               	mul	x2, x2, x5
               	sub	x9, x9, x2
               	add	x2, x2, x9
               	lsl	x9, x9, #1
               	sub	x2, x2, #0x1
               	add	x9, x9, #0x7
               	add	x2, x2, x9
               	mul	x9, x9, x6
               	add	x2, x9, x2
               	add	x9, x10, x2
               	mov	x2, #0x2                // =2
               	mul	x9, x9, x7
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	mov	x0, x2
               	add	x2, x0, #0x2
               	add	x0, x0, x2
               	mul	x2, x2, x5
               	sub	x0, x0, x2
               	add	x2, x2, x0
               	lsl	x0, x0, #1
               	sub	x2, x2, #0x1
               	add	x0, x0, #0x7
               	add	x2, x2, x0
               	mul	x0, x0, x6
               	add	x0, x0, x2
               	add	x9, x9, x0
               	mov	x0, #0x2                // =2
               	mov	x2, #0x0                // =0
               	mul	x10, x9, x7
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	mov	x9, #0x3                // =3
               	add	x2, x9, #0x2
               	add	x9, x9, x2
               	mul	x2, x2, x5
               	sub	x9, x9, x2
               	add	x2, x2, x9
               	lsl	x9, x9, #1
               	sub	x2, x2, #0x1
               	add	x9, x9, #0x7
               	add	x2, x2, x9
               	mul	x9, x9, x6
               	add	x2, x9, x2
               	add	x9, x10, x2
               	mov	x2, #0x1                // =1
               	mul	x10, x9, x7
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	mov	x9, #0x3                // =3
               	add	x2, x9, #0x2
               	add	x9, x9, x2
               	mul	x2, x2, x5
               	sub	x9, x9, x2
               	add	x2, x2, x9
               	lsl	x9, x9, #1
               	sub	x2, x2, #0x1
               	add	x9, x9, #0x7
               	add	x2, x2, x9
               	mul	x9, x9, x6
               	add	x2, x9, x2
               	add	x9, x10, x2
               	mov	x2, #0x2                // =2
               	mul	x9, x9, x7
               	cmp	x3, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x3, lsl #3]
               	br	x17
               	mov	x0, #0x3                // =3
               	add	x2, x0, #0x2
               	add	x0, x0, x2
               	mul	x2, x2, x5
               	sub	x0, x0, x2
               	add	x2, x2, x0
               	lsl	x0, x0, #1
               	sub	x2, x2, #0x1
               	add	x0, x0, #0x7
               	add	x2, x2, x0
               	mul	x0, x0, x6
               	add	x0, x0, x2
               	add	x2, x9, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x8
               	b	<addr>
               	mov	x2, x8
               	b	<addr>
               	mov	x0, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x8
               	b	<addr>
               	mov	x2, x1
               	mov	x9, x0
               	b	<addr>
               	mov	x9, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x8
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x2, x8
               	b	<addr>
               	mov	x0, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x1
               	b	<addr>
               	mov	x2, x1
               	mov	x9, x0
               	b	<addr>
               	mov	x9, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x1
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, x8
               	b	<addr>
               	mov	x0, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, x0
               	b	<addr>
               	mov	x9, #0x0                // =0
               	b	<addr>
               	mov	x2, x1
               	mov	x9, x0
               	b	<addr>
               	mov	x9, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x9, x0
               	mov	x2, x0
               	b	<addr>
               	mov	x9, x0
               	mov	x10, x0
               	b	<addr>
               	mov	x2, x0
               	mov	x10, x0
               	b	<addr>
               	mov	x2, x0
               	mov	x9, x0
               	b	<addr>
               	mov	x2, x0
               	mov	x9, x0
               	b	<addr>
               	mov	x2, x0
               	mov	x9, x0
               	b	<addr>
               	mov	x10, x0
               	mov	x9, x0
               	b	<addr>
               	mov	x10, x0
               	mov	x2, x0
               	b	<addr>
               	mov	x9, x0
               	mov	x2, x0
               	b	<addr>
               	mov	x9, x0
               	mov	x2, x0
               	b	<addr>
               	mov	x2, #0xd                // =13
               	mov	x9, #0x11               // =17
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x0, x8
               	mov	x2, x1
               	b	<addr>
               	mov	x2, #0xd                // =13
               	mov	x0, #0x11               // =17
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x0, x1
               	mov	x2, x1
               	b	<addr>
               	mov	x2, #0xd                // =13
               	mov	x0, #0x11               // =17
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, #0xd                // =13
               	mov	x0, #0x11               // =17
               	b	<addr>
               	add	x4, x3, #0x1
               	cmp	w4, #0xe
               	b.lt	<addr>
               	mov	x17, #0x2760            // =10080
               	movk	x17, #0x4634, lsl #16
               	movk	x17, #0xf948, lsl #32
               	movk	x17, #0xd14a, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
