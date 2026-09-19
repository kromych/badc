
struct_array_brace_elision.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x30
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x0                // =0
               	lsl	x4, x1, #4
               	add	x5, x3, x4
               	lsl	x6, x0, #3
               	add	x2, x5, x6
               	ldrsw	x7, [x2]
               	cbnz	w7, <addr>
               	ldrsw	x2, [x2, #0x4]
               	cbnz	w2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	sub	x3, x29, #0x30
               	mov	x1, #0x0                // =0
               	mov	x0, #0x0                // =0
               	lsl	x4, x1, #4
               	add	x5, x3, x4
               	lsl	x6, x0, #3
               	add	x2, x5, x6
               	ldrsw	x7, [x2]
               	cbnz	w7, <addr>
               	ldrsw	x2, [x2, #0x4]
               	cbnz	w2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x10]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x14]
               	cmp	w1, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x18]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x1c]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x8]
               	cbnz	w1, <addr>
               	ldrsw	x1, [x0, #0xc]
               	cbz	w1, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x10]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x14]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x18]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x1c]
               	cmp	w1, #0x6
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x20]
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0x2c]
               	cbz	w0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
