
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
               	mov	x6, #0x0                // =0
               	mov	x2, #-0x2               // =-2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x1f               // =31
               	mov	x5, #0x21               // =33
               	mov	x0, #-0x1               // =-1
               	mov	x1, #0x0                // =0
               	mul	x7, x6, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	add	x6, x1, #0x2
               	mov	x16, x6
               	mov	x6, x1
               	mov	x1, x16
               	add	x6, x6, x1
               	mul	x1, x1, x3
               	sub	x6, x6, x1
               	add	x1, x1, x6
               	lsl	x6, x6, #1
               	sub	x1, x1, #0x1
               	add	x6, x6, #0x7
               	add	x1, x1, x6
               	mul	x6, x6, x4
               	add	x1, x6, x1
               	add	x6, x7, x1
               	mov	x1, #0x1                // =1
               	mul	x7, x6, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	mov	x6, #0x0                // =0
               	add	x1, x6, #0x2
               	add	x6, x6, x1
               	mul	x1, x1, x3
               	sub	x6, x6, x1
               	add	x1, x1, x6
               	lsl	x6, x6, #1
               	sub	x1, x1, #0x1
               	add	x6, x6, #0x7
               	add	x1, x1, x6
               	mul	x6, x6, x4
               	add	x1, x6, x1
               	add	x6, x7, x1
               	mov	x1, #0x2                // =2
               	mul	x6, x6, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	mov	x0, #0x0                // =0
               	add	x1, x0, #0x2
               	add	x0, x0, x1
               	mul	x1, x1, x3
               	sub	x0, x0, x1
               	add	x1, x1, x0
               	lsl	x0, x0, #1
               	sub	x1, x1, #0x1
               	add	x0, x0, #0x7
               	add	x1, x1, x0
               	mul	x0, x0, x4
               	add	x0, x0, x1
               	add	x1, x6, x0
               	mov	x0, #0x0                // =0
               	mul	x8, x1, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	mov	x1, #0x1                // =1
               	add	x6, x1, #0x2
               	add	x7, x1, x6
               	mul	x1, x6, x3
               	sub	x6, x7, x1
               	add	x1, x1, x6
               	lsl	x6, x6, #1
               	sub	x7, x1, #0x1
               	add	x1, x6, #0x7
               	add	x6, x7, x1
               	mul	x1, x1, x4
               	add	x1, x1, x6
               	add	x6, x8, x1
               	mov	x1, #0x1                // =1
               	mul	x7, x6, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	add	x6, x1, #0x2
               	mov	x16, x6
               	mov	x6, x1
               	mov	x1, x16
               	add	x6, x6, x1
               	mul	x1, x1, x3
               	sub	x6, x6, x1
               	add	x1, x1, x6
               	lsl	x6, x6, #1
               	sub	x1, x1, #0x1
               	add	x6, x6, #0x7
               	add	x1, x1, x6
               	mul	x6, x6, x4
               	add	x1, x6, x1
               	add	x6, x7, x1
               	mov	x1, #0x2                // =2
               	mul	x6, x6, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	mov	x0, #0x1                // =1
               	add	x1, x0, #0x2
               	add	x0, x0, x1
               	mul	x1, x1, x3
               	sub	x0, x0, x1
               	add	x1, x1, x0
               	lsl	x0, x0, #1
               	sub	x1, x1, #0x1
               	add	x0, x0, #0x7
               	add	x1, x1, x0
               	mul	x0, x0, x4
               	add	x0, x0, x1
               	add	x6, x6, x0
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mul	x7, x6, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	mov	x6, #0x2                // =2
               	add	x0, x6, #0x2
               	add	x6, x6, x0
               	mul	x0, x0, x3
               	sub	x6, x6, x0
               	add	x0, x0, x6
               	lsl	x6, x6, #1
               	sub	x0, x0, #0x1
               	add	x6, x6, #0x7
               	add	x0, x0, x6
               	mul	x6, x6, x4
               	add	x0, x6, x0
               	add	x0, x7, x0
               	mul	x8, x0, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	mov	x0, #0x2                // =2
               	add	x6, x0, #0x2
               	add	x7, x0, x6
               	mul	x0, x6, x3
               	sub	x6, x7, x0
               	add	x0, x0, x6
               	lsl	x6, x6, #1
               	sub	x7, x0, #0x1
               	add	x0, x6, #0x7
               	add	x6, x7, x0
               	mul	x0, x0, x4
               	add	x0, x0, x6
               	add	x6, x8, x0
               	mov	x0, #0x2                // =2
               	mul	x7, x6, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	mov	x1, x0
               	add	x6, x1, #0x2
               	add	x1, x1, x6
               	mul	x6, x6, x3
               	sub	x1, x1, x6
               	add	x6, x6, x1
               	lsl	x1, x1, #1
               	sub	x6, x6, #0x1
               	add	x1, x1, #0x7
               	add	x6, x6, x1
               	mul	x1, x1, x4
               	add	x1, x1, x6
               	add	x6, x7, x1
               	mov	x1, #0x0                // =0
               	mul	x7, x6, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	mov	x6, #0x3                // =3
               	add	x1, x6, #0x2
               	add	x6, x6, x1
               	mul	x1, x1, x3
               	sub	x6, x6, x1
               	add	x1, x1, x6
               	lsl	x6, x6, #1
               	sub	x1, x1, #0x1
               	add	x6, x6, #0x7
               	add	x1, x1, x6
               	mul	x6, x6, x4
               	add	x1, x6, x1
               	add	x6, x7, x1
               	mov	x1, #0x1                // =1
               	mul	x7, x6, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	mov	x6, #0x3                // =3
               	add	x1, x6, #0x2
               	add	x6, x6, x1
               	mul	x1, x1, x3
               	sub	x6, x6, x1
               	add	x1, x1, x6
               	lsl	x6, x6, #1
               	sub	x1, x1, #0x1
               	add	x6, x6, #0x7
               	add	x1, x1, x6
               	mul	x6, x6, x4
               	add	x1, x6, x1
               	add	x6, x7, x1
               	mov	x1, #0x2                // =2
               	mul	x6, x6, x5
               	cmp	x2, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x2, lsl #3]
               	br	x17
               	mov	x0, #0x3                // =3
               	add	x1, x0, #0x2
               	add	x0, x0, x1
               	mul	x1, x1, x3
               	sub	x0, x0, x1
               	add	x1, x1, x0
               	lsl	x0, x0, #1
               	sub	x1, x1, #0x1
               	add	x0, x0, #0x7
               	add	x1, x1, x0
               	b	<addr>
               	mov	x0, #-0x2               // =-2
               	b	<addr>
               	mov	x1, #-0x2               // =-2
               	b	<addr>
               	mov	x0, #0xd                // =13
               	mov	x1, #0x11               // =17
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, #-0x2               // =-2
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	mov	x6, x0
               	b	<addr>
               	mov	x6, #0xd                // =13
               	mov	x1, #0x11               // =17
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, #-0x2               // =-2
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, #0xd                // =13
               	mov	x1, #0x11               // =17
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	mov	x6, x0
               	b	<addr>
               	mov	x6, #-0x2               // =-2
               	b	<addr>
               	mov	x1, #0xd                // =13
               	mov	x6, #0x11               // =17
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x6, x1
               	mov	x0, x1
               	b	<addr>
               	mov	x6, x1
               	mov	x7, x1
               	b	<addr>
               	mov	x0, x1
               	mov	x7, x1
               	b	<addr>
               	mov	x0, x1
               	mov	x6, x1
               	b	<addr>
               	mov	x0, x1
               	mov	x6, x1
               	b	<addr>
               	mov	x0, x1
               	mov	x6, x1
               	b	<addr>
               	mov	x7, x1
               	mov	x6, x1
               	b	<addr>
               	mov	x7, x1
               	mov	x0, x1
               	b	<addr>
               	mov	x0, #-0x1               // =-1
               	mov	x6, x1
               	b	<addr>
               	mov	x6, #-0x1               // =-1
               	mov	x0, x1
               	b	<addr>
               	mov	x0, #0xd                // =13
               	mov	x6, #0x11               // =17
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	mov	x6, #-0x1               // =-1
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	mov	x6, #0xd                // =13
               	mov	x0, #0x11               // =17
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #-0x2               // =-2
               	b	<addr>
               	mov	x0, #0xd                // =13
               	mov	x1, #0x11               // =17
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, #0x0                // =0
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	mov	x6, x0
               	b	<addr>
               	mov	x6, #0xd                // =13
               	mov	x1, #0x11               // =17
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x6, x0
               	mov	x1, x0
               	b	<addr>
               	mov	x6, x0
               	mov	x7, x0
               	b	<addr>
               	mov	x1, x0
               	mov	x7, x0
               	b	<addr>
               	mov	x1, x0
               	mov	x6, x0
               	b	<addr>
               	mov	x1, x0
               	mov	x6, x0
               	b	<addr>
               	mov	x1, x0
               	mov	x6, x0
               	b	<addr>
               	mov	x7, x0
               	mov	x6, x0
               	b	<addr>
               	mov	x7, x0
               	mov	x1, x0
               	b	<addr>
               	mov	x6, x0
               	mov	x1, x0
               	b	<addr>
               	mov	x6, x0
               	mov	x1, x0
               	b	<addr>
               	mov	x1, #0xd                // =13
               	mov	x6, #0x11               // =17
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x1, #-0x2               // =-2
               	b	<addr>
               	mov	x0, #0xd                // =13
               	mov	x1, #0x11               // =17
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	mov	x6, x0
               	b	<addr>
               	mov	x6, #0xd                // =13
               	mov	x1, #0x11               // =17
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, #0x1                // =1
               	b	<addr>
               	mov	x6, x0
               	b	<addr>
               	mov	x6, #0xd                // =13
               	mov	x1, #0x11               // =17
               	b	<addr>
               	mul	x0, x0, x4
               	add	x0, x0, x1
               	add	x6, x6, x0
               	add	x2, x2, #0x1
               	cmp	w2, #0xe
               	b.lt	<addr>
               	mov	x17, #0x2760            // =10080
               	movk	x17, #0x4634, lsl #16
               	movk	x17, #0xf948, lsl #32
               	movk	x17, #0xd14a, lsl #48
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
