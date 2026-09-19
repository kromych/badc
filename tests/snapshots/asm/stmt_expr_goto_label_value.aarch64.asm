
stmt_expr_goto_label_value.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, #0x0                // =0
               	mov	x4, x2
               	mov	x6, x2
               	mov	x5, x2
               	cmp	w4, #0xc8
               	b.hs	<addr>
               	add	x6, x6, #0x1
               	add	x5, x5, x2
               	sub	x3, x29, #0x10
               	add	x1, x2, #0x1
               	mov	x2, #0x64               // =100
               	cmp	w1, #0x64
               	b.hs	<addr>
               	lsr	x0, x1, #6
               	ldr	x7, [x3, x0, lsl #3]
               	mov	x8, #-0x1               // =-1
               	and	x1, x1, #0x3f
               	lsl	x1, x8, x1
               	and	x1, x7, x1
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	lsl	x1, x0, #6
               	cmp	x1, #0x64
               	b.hs	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	cbz	x1, <addr>
               	lsl	x0, x0, #6
               	rbit	x1, x1
               	clz	x1, x1
               	add	x0, x0, x1
               	cmp	x0, #0x64
               	b.hi	<addr>
               	mov	x2, x0
               	add	x4, x4, #0x1
               	cmp	w2, #0x64
               	b.lo	<addr>
               	cmp	x6, #0x5
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x5, #0xcb
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x10
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x1
               	lsl	x1, x0, #6
               	cmp	x1, #0x64
               	b.hs	<addr>
               	ldr	x1, [x2, x0, lsl #3]
               	cbz	x1, <addr>
               	lsl	x0, x0, #6
               	rbit	x1, x1
               	clz	x1, x1
               	add	x0, x0, x1
               	cmp	x0, #0x64
               	b.ls	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x64
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
