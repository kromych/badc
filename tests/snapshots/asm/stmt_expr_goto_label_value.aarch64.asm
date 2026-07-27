
stmt_expr_goto_label_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<find_next>:
               	mov	x3, x0
               	mov	x4, #0x64               // =100
               	cmp	x2, #0x64
               	b.lo	<addr>
               	mov	x0, x4
               	ret
               	lsr	x0, x2, #6
               	ldr	x1, [x3, x0, lsl #3]
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x17, #0x3f              // =63
               	and	x2, x2, x17
               	lsl	x2, x5, x2
               	and	x1, x1, x2
               	b	<addr>
               	add	x1, x0, #0x1
               	lsl	x1, x1, #6
               	cmp	x1, #0x64
               	b.hs	<addr>
               	add	x0, x0, #0x1
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	lsl	x2, x0, #6
               	sub	x0, x1, #0x1
               	mvn	x1, x1
               	and	x0, x0, x1
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	add	x0, x2, x0
               	cmp	x0, #0x64
               	b.ls	<addr>
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0xa                // =10
               	mov	x0, #0x3                // =3
               	mov	x0, #0x6                // =6
               	mov	x0, #0x74               // =116
               	mov	x0, #0x5                // =5
               	mov	x0, #0xf                // =15
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x23, #0x64              // =100
               	mov	x20, #0x0               // =0
               	sub	x0, x29, #0x10
               	mov	x1, x23
               	mov	x2, x20
               	bl	<addr>
               	mov	x21, x20
               	mov	x22, x20
               	cmp	x0, #0x64
               	cset	x1, lo
               	cbz	x1, <addr>
               	cmp	x20, #0xc8
               	cset	x1, lo
               	cbz	x1, <addr>
               	add	x22, x22, #0x1
               	add	x21, x21, x0
               	sub	x1, x29, #0x10
               	add	x2, x0, #0x1
               	mov	x0, x1
               	mov	x1, x23
               	bl	<addr>
               	add	x20, x20, #0x1
               	b	<addr>
               	b	<addr>
               	cmp	x22, #0x5
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	cmp	x21, #0xcb
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sub	x0, x29, #0x10
               	mov	x2, #0x64               // =100
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sub	x0, x29, #0x10
               	mov	x2, #0x2bc              // =700
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sub	x0, x29, #0x10
               	mov	x2, #0x49               // =73
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	b	<addr>
