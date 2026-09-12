
struct_arg_indirect_subscript.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x1, x0
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x88
               	mov	x3, #0x0                // =0
               	str	x3, [x1]
               	add	x0, x1, #0x8
               	add	x2, x0, #0x0
               	mov	x4, #0x1                // =1
               	str	x4, [x2]
               	str	x3, [x2, #0x8]
               	mov	x3, #0x2                // =2
               	str	x3, [x0, #0x10]
               	add	x2, x0, #0x10
               	str	x4, [x2, #0x8]
               	mov	x2, #0x3                // =3
               	str	x2, [x0, #0x20]
               	add	x4, x0, #0x20
               	str	x3, [x4, #0x8]
               	mov	x3, #0x4                // =4
               	str	x3, [x0, #0x30]
               	add	x4, x0, #0x30
               	str	x2, [x4, #0x8]
               	mov	x4, #0x5                // =5
               	str	x4, [x0, #0x40]
               	sub	x1, x29, #0x88
               	add	x0, x1, #0x8
               	add	x5, x0, #0x40
               	str	x3, [x5, #0x8]
               	mov	x5, #0x6                // =6
               	str	x5, [x0, #0x50]
               	add	x6, x0, #0x50
               	str	x4, [x6, #0x8]
               	mov	x6, #0x7                // =7
               	str	x6, [x0, #0x60]
               	add	x7, x0, #0x60
               	str	x5, [x7, #0x8]
               	mov	x5, #0x8                // =8
               	str	x5, [x0, #0x70]
               	add	x5, x0, #0x70
               	str	x6, [x5, #0x8]
               	add	x0, x0, #0x30
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x6, [x0]
               	mov	x17, #0x3e8             // =1000
               	mul	x6, x6, x17
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x6, x0
               	add	x6, x0, #0x3
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	add	x1, x6, #0x0
               	cbz	x5, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	cmp	x0, #0xfc2
               	b.eq	<addr>
               	mov	x0, x2
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x8, #0x1                // =1
               	ldr	d0, [x1]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	ldr	d1, [x1, #0x8]
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fmul	d1, d1, d17
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
               	scvtf	d3, x8
               	fadd	d4, d0, d3
               	mov	x2, #0x3ff8000000000000 // =4609434218613702656
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	mov	x6, #0x4002000000000000 // =4612248968380809216
               	mov	x5, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x6
               	fmov	d17, x5
               	fmul	d0, d16, d17
               	fmov	d16, x2
               	fmov	d17, x0
               	fmadd	d1, d16, d17, d0
               	mov	x7, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x7
               	fadd	d2, d1, d17
               	fcmp	d4, d2
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x98
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	d4, [x3]
               	ldr	d5, [x3, #0x8]
               	fmov	d17, x5
               	fmul	d5, d5, d17
               	fmov	d17, x0
               	fmadd	d4, d4, d17, d5
               	fadd	d3, d4, d3
               	fcmp	d3, d2
               	b.eq	<addr>
               	mov	x0, x4
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
