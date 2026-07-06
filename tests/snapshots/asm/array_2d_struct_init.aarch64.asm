
array_2d_struct_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x2, #0x1                // =1
               	scvtf	d1, x2
               	fcmp	d0, d1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	d0, [x0, #0x18]
               	mov	x1, #0x4                // =4
               	scvtf	d1, x1
               	fcmp	d0, d1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	ldr	d0, [x0, #0x20]
               	mov	x1, #0x5                // =5
               	scvtf	d1, x1
               	fcmp	d0, d1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	d0, [x0, #0x38]
               	mov	x0, #0x8                // =8
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x1                // =1
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0, #0x78]
               	mov	x0, #0x8                // =8
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0, #0x50]
               	mov	x0, #0x6                // =6
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x9                // =9
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x10               // =16
               	ldr	d0, [x0, #0x38]
               	scvtf	d1, x1
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0, #0x10]
               	mov	x0, #0xb                // =11
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
