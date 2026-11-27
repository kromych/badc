
switch_jump_table_phi_join.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	mov	x4, #0x0                // =0
               	mov	x1, #-0x2               // =-2
               	mov	x3, #0x1f               // =31
               	b	<addr>
               	mul	x0, x0, x3
               	add	x0, x0, x2
               	add	x4, x4, x0
               	add	x1, x1, #0x1
               	cmp	w1, #0xe
               	b.ge	<addr>
               	mov	x0, #-0x1               // =-1
               	mov	x2, #0x0                // =0
               	add	x5, x4, x4, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	add	x4, x2, #0x2
               	mov	x16, x4
               	mov	x4, x2
               	mov	x2, x16
               	add	x4, x4, x2
               	add	x2, x2, x2, lsl #1
               	sub	x4, x4, x2
               	add	x2, x2, x4
               	lsl	x4, x4, #1
               	sub	x2, x2, #0x1
               	add	x4, x4, #0x7
               	add	x2, x2, x4
               	mul	x4, x4, x3
               	add	x2, x4, x2
               	add	x4, x5, x2
               	mov	x2, #0x1                // =1
               	add	x5, x4, x4, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x4, #0x0                // =0
               	add	x2, x4, #0x2
               	add	x4, x4, x2
               	add	x2, x2, x2, lsl #1
               	sub	x4, x4, x2
               	add	x2, x2, x4
               	lsl	x4, x4, #1
               	sub	x2, x2, #0x1
               	add	x4, x4, #0x7
               	add	x2, x2, x4
               	mul	x4, x4, x3
               	add	x2, x4, x2
               	add	x4, x5, x2
               	mov	x2, #0x2                // =2
               	add	x4, x4, x4, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x0, #0x0                // =0
               	add	x2, x0, #0x2
               	add	x0, x0, x2
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	add	x2, x2, x0
               	lsl	x0, x0, #1
               	sub	x2, x2, #0x1
               	add	x0, x0, #0x7
               	add	x2, x2, x0
               	mul	x0, x0, x3
               	add	x0, x0, x2
               	add	x2, x4, x0
               	mov	x0, #0x0                // =0
               	add	x5, x2, x2, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x2, #0x1                // =1
               	add	x4, x2, #0x2
               	add	x6, x2, x4
               	add	x2, x4, x4, lsl #1
               	sub	x4, x6, x2
               	add	x2, x2, x4
               	lsl	x4, x4, #1
               	sub	x6, x2, #0x1
               	add	x2, x4, #0x7
               	add	x4, x6, x2
               	mul	x2, x2, x3
               	add	x2, x2, x4
               	add	x4, x5, x2
               	mov	x2, #0x1                // =1
               	add	x5, x4, x4, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	add	x4, x2, #0x2
               	mov	x16, x4
               	mov	x4, x2
               	mov	x2, x16
               	add	x4, x4, x2
               	add	x2, x2, x2, lsl #1
               	sub	x4, x4, x2
               	add	x2, x2, x4
               	lsl	x4, x4, #1
               	sub	x2, x2, #0x1
               	add	x4, x4, #0x7
               	add	x2, x2, x4
               	mul	x4, x4, x3
               	add	x2, x4, x2
               	add	x4, x5, x2
               	mov	x2, #0x2                // =2
               	add	x4, x4, x4, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x0, #0x1                // =1
               	add	x2, x0, #0x2
               	add	x0, x0, x2
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	add	x2, x2, x0
               	lsl	x0, x0, #1
               	sub	x2, x2, #0x1
               	add	x0, x0, #0x7
               	add	x2, x2, x0
               	mul	x0, x0, x3
               	add	x0, x0, x2
               	add	x4, x4, x0
               	mov	x2, #0x1                // =1
               	mov	x0, #0x0                // =0
               	add	x5, x4, x4, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x4, #0x2                // =2
               	add	x0, x4, #0x2
               	add	x4, x4, x0
               	add	x0, x0, x0, lsl #1
               	sub	x4, x4, x0
               	add	x0, x0, x4
               	lsl	x4, x4, #1
               	sub	x0, x0, #0x1
               	add	x4, x4, #0x7
               	add	x0, x0, x4
               	mul	x4, x4, x3
               	add	x0, x4, x0
               	add	x0, x5, x0
               	add	x5, x0, x0, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x0, #0x2                // =2
               	add	x4, x0, #0x2
               	add	x6, x0, x4
               	add	x0, x4, x4, lsl #1
               	sub	x4, x6, x0
               	add	x0, x0, x4
               	lsl	x4, x4, #1
               	sub	x6, x0, #0x1
               	add	x0, x4, #0x7
               	add	x4, x6, x0
               	mul	x0, x0, x3
               	add	x0, x0, x4
               	add	x4, x5, x0
               	mov	x0, #0x2                // =2
               	add	x5, x4, x4, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x2, x0
               	add	x4, x2, #0x2
               	add	x2, x2, x4
               	add	x4, x4, x4, lsl #1
               	sub	x2, x2, x4
               	add	x4, x4, x2
               	lsl	x2, x2, #1
               	sub	x4, x4, #0x1
               	add	x2, x2, #0x7
               	add	x4, x4, x2
               	mul	x2, x2, x3
               	add	x2, x2, x4
               	add	x4, x5, x2
               	mov	x2, #0x0                // =0
               	add	x5, x4, x4, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x4, #0x3                // =3
               	add	x2, x4, #0x2
               	add	x4, x4, x2
               	add	x2, x2, x2, lsl #1
               	sub	x4, x4, x2
               	add	x2, x2, x4
               	lsl	x4, x4, #1
               	sub	x2, x2, #0x1
               	add	x4, x4, #0x7
               	add	x2, x2, x4
               	mul	x4, x4, x3
               	add	x2, x4, x2
               	add	x4, x5, x2
               	mov	x2, #0x1                // =1
               	add	x5, x4, x4, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x4, #0x3                // =3
               	add	x2, x4, #0x2
               	add	x4, x4, x2
               	add	x2, x2, x2, lsl #1
               	sub	x4, x4, x2
               	add	x2, x2, x4
               	lsl	x4, x4, #1
               	sub	x2, x2, #0x1
               	add	x4, x4, #0x7
               	add	x2, x2, x4
               	mul	x4, x4, x3
               	add	x2, x4, x2
               	add	x4, x5, x2
               	mov	x2, #0x2                // =2
               	add	x4, x4, x4, lsl #5
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x0, #0x3                // =3
               	add	x2, x0, #0x2
               	add	x0, x0, x2
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	add	x2, x2, x0
               	lsl	x0, x0, #1
               	sub	x2, x2, #0x1
               	add	x0, x0, #0x7
               	add	x2, x2, x0
               	b	<addr>
               	mov	x0, #-0x2               // =-2
               	b	<addr>
               	mov	x2, #-0x2               // =-2
               	b	<addr>
               	mov	x0, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, #-0x2               // =-2
               	b	<addr>
               	mov	x2, #-0x1               // =-1
               	mov	x4, x0
               	b	<addr>
               	mov	x4, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, #-0x2               // =-2
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x2, #-0x1               // =-1
               	mov	x4, x0
               	b	<addr>
               	mov	x4, #-0x2               // =-2
               	b	<addr>
               	mov	x2, #0xd                // =13
               	mov	x4, #0x11               // =17
               	b	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x4, x2
               	mov	x0, x2
               	b	<addr>
               	mov	x4, x2
               	mov	x6, x2
               	b	<addr>
               	mov	x0, x2
               	mov	x6, x2
               	b	<addr>
               	mov	x0, x2
               	mov	x4, x2
               	b	<addr>
               	mov	x0, x2
               	mov	x4, x2
               	b	<addr>
               	mov	x0, x2
               	mov	x4, x2
               	b	<addr>
               	mov	x6, x2
               	mov	x4, x2
               	b	<addr>
               	mov	x6, x2
               	mov	x0, x2
               	b	<addr>
               	mov	x0, #-0x1               // =-1
               	mov	x4, x2
               	b	<addr>
               	mov	x4, #-0x1               // =-1
               	mov	x0, x2
               	b	<addr>
               	mov	x0, #0xd                // =13
               	mov	x4, #0x11               // =17
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, #0xd                // =13
               	mov	x0, #0x11               // =17
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #-0x2               // =-2
               	b	<addr>
               	mov	x0, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x2, #-0x1               // =-1
               	mov	x4, x0
               	b	<addr>
               	mov	x4, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x4, x0
               	mov	x2, x0
               	b	<addr>
               	mov	x4, x0
               	mov	x6, x0
               	b	<addr>
               	mov	x2, x0
               	mov	x6, x0
               	b	<addr>
               	mov	x2, x0
               	mov	x4, x0
               	b	<addr>
               	mov	x2, x0
               	mov	x4, x0
               	b	<addr>
               	mov	x2, x0
               	mov	x4, x0
               	b	<addr>
               	mov	x6, x0
               	mov	x4, x0
               	b	<addr>
               	mov	x6, x0
               	mov	x2, x0
               	b	<addr>
               	mov	x4, x0
               	mov	x2, x0
               	b	<addr>
               	mov	x4, x0
               	mov	x2, x0
               	b	<addr>
               	mov	x2, #0xd                // =13
               	mov	x4, #0x11               // =17
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x2, #-0x2               // =-2
               	b	<addr>
               	mov	x0, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x2, #-0x1               // =-1
               	mov	x4, x0
               	b	<addr>
               	mov	x4, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, #0x1                // =1
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	mov	x17, #0x2760            // =10080
               	movk	x17, #0x4634, lsl #16
               	movk	x17, #0xf948, lsl #32
               	movk	x17, #0xd14a, lsl #48
               	cmp	x4, x17
               	mov	x17, #0x1               // =1
               	csel	x0, xzr, x17, eq
               	ret
