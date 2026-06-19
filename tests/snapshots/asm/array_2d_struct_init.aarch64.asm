
array_2d_struct_init.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x3, #0x1                // =1
               	scvtf	d1, x3
               	fcmp	d0, d1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	add	x1, x0, #0x18
               	ldr	d0, [x1]
               	mov	x1, #0x4                // =4
               	scvtf	d1, x1
               	fcmp	d0, d1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x2, #0x1                // =1
               	cbnz	x3, <addr>
               	add	x1, x0, #0x20
               	ldr	d0, [x1]
               	mov	x1, #0x5                // =5
               	scvtf	d1, x1
               	fcmp	d0, d1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x0, x0, #0x38
               	ldr	d0, [x0]
               	mov	x0, #0x8                // =8
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x2, #0x1                // =1
               	scvtf	d1, x2
               	fcmp	d0, d1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x78
               	ldr	d0, [x0]
               	mov	x0, #0x8                // =8
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x50
               	ldr	d0, [x0]
               	mov	x0, #0x6                // =6
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x9                // =9
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, ne
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x10               // =16
               	add	x0, x0, #0x38
               	ldr	d0, [x0]
               	scvtf	d1, x1
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldr	d0, [x0]
               	mov	x0, #0xb                // =11
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
