
inline_memory_class_struct_param.aarch64:	file format elf64-littleaarch64

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

<weigh>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	x0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	ldr	x0, [x0, #0x8]
               	mul	x0, x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<use_sum>:
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x0, [x0, #0x20]
               	lsl	x2, x2, #1
               	add	x1, x1, x2
               	lsl	x2, x3, #2
               	add	x1, x1, x2
               	lsl	x2, x4, #3
               	add	x1, x1, x2
               	lsl	x0, x0, #4
               	add	x0, x1, x0
               	ret

<use_forward>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x1, x0
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0x28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	bl	<addr>
               	sub	x1, x29, #0x28
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<use_clobber>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	mov	x6, #0x63               // =99
               	str	x6, [x0]
               	mov	x6, #0x4d               // =77
               	str	x6, [x0, #0x20]
               	mov	x17, #0x2710            // =10000
               	mul	x0, x1, x17
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	mov	x17, #0x64              // =100
               	mul	x1, x3, x17
               	add	x0, x0, x1
               	mov	x17, #0xa               // =10
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	add	x0, x0, x5
               	ret

<use_pick>:
               	sxtw	x2, w2
               	ldr	x0, [x0, #0x10]
               	ldr	x1, [x1, #0x18]
               	cbz	x2, <addr>
               	ret
               	mov	x0, x1
               	b	<addr>

<use_find>:
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x10]
               	ldr	x0, [x0, #0x20]
               	cmp	x2, x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	x3, x1
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [sp], #0x10
               	bl	<addr>
               	cmp	x0, #0x81
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	ldr	x1, [x0]
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldr	x1, [x0, #0x20]
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [sp], #0x10
               	bl	<addr>
               	mov	x17, #0x3039            // =12345
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x63
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x20]
               	cmp	x0, #0x4d
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x28
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x50
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x28
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
