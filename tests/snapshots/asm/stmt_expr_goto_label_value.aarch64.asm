
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
               	sub	sp, sp, #0x20
               	mov	x0, #0xa                // =10
               	mov	x0, #0x3                // =3
               	mov	x0, #0x6                // =6
               	mov	x0, #0x74               // =116
               	mov	x0, #0x5                // =5
               	mov	x0, #0xf                // =15
               	mov	x5, #0x0                // =0
               	mov	x0, x5
               	sub	x2, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x4, #0x64               // =100
               	mov	x0, #0x11               // =17
               	movk	x0, #0x8000, lsl #48
               	mov	x3, x5
               	b	<addr>
               	add	x1, x3, #0x1
               	lsl	x0, x1, #6
               	cmp	x0, #0x64
               	b.hs	<addr>
               	ldr	x0, [x2, x1, lsl #3]
               	mov	x3, x1
               	cbz	x0, <addr>
               	lsl	x1, x3, #6
               	sub	x2, x0, #0x1
               	mvn	x0, x0
               	and	x0, x2, x0
               	lsr	x2, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x2, x2, x17
               	sub	x0, x0, x2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x2, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x2, x0
               	lsr	x2, x0, #4
               	add	x0, x0, x2
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x2, x0, #8
               	add	x0, x0, x2
               	lsr	x2, x0, #16
               	add	x0, x0, x2
               	lsr	x2, x0, #32
               	add	x0, x0, x2
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	add	x0, x1, x0
               	cmp	x0, #0x64
               	b.ls	<addr>
               	mov	x9, #0xffff             // =65535
               	movk	x9, #0xffff, lsl #16
               	movk	x9, #0xffff, lsl #32
               	movk	x9, #0xffff, lsl #48
               	mov	x10, #0x3f              // =63
               	mov	x11, #0x7f              // =127
               	mov	x12, #0xf0f             // =3855
               	movk	x12, #0xf0f, lsl #16
               	movk	x12, #0xf0f, lsl #32
               	movk	x12, #0xf0f, lsl #48
               	mov	x8, #0x3333             // =13107
               	movk	x8, #0x3333, lsl #16
               	movk	x8, #0x3333, lsl #32
               	movk	x8, #0x3333, lsl #48
               	mov	x13, #0x5555            // =21845
               	movk	x13, #0x5555, lsl #16
               	movk	x13, #0x5555, lsl #32
               	movk	x13, #0x5555, lsl #48
               	mov	x6, x5
               	mov	x7, x5
               	cmp	x4, #0x64
               	cset	x0, lo
               	cbz	x0, <addr>
               	cmp	x5, #0xc8
               	cset	x0, lo
               	cbz	x0, <addr>
               	add	x7, x7, #0x1
               	add	x6, x6, x4
               	sub	x3, x29, #0x10
               	add	x0, x4, #0x1
               	mov	x4, #0x64               // =100
               	cmp	x0, #0x64
               	b.lo	<addr>
               	add	x5, x5, #0x1
               	b	<addr>
               	lsr	x2, x0, #6
               	ldr	x1, [x3, x2, lsl #3]
               	and	x0, x0, x10
               	lsl	x0, x9, x0
               	and	x0, x1, x0
               	b	<addr>
               	add	x1, x2, #0x1
               	lsl	x0, x1, #6
               	cmp	x0, #0x64
               	b.hs	<addr>
               	ldr	x0, [x3, x1, lsl #3]
               	mov	x2, x1
               	cbz	x0, <addr>
               	lsl	x1, x2, #6
               	sub	x2, x0, #0x1
               	mvn	x0, x0
               	and	x0, x2, x0
               	lsr	x2, x0, #1
               	and	x2, x2, x13
               	sub	x0, x0, x2
               	and	x2, x0, x8
               	lsr	x0, x0, #2
               	and	x0, x0, x8
               	add	x0, x2, x0
               	lsr	x2, x0, #4
               	add	x0, x0, x2
               	and	x0, x0, x12
               	lsr	x2, x0, #8
               	add	x0, x0, x2
               	lsr	x2, x0, #16
               	add	x0, x0, x2
               	lsr	x2, x0, #32
               	add	x0, x0, x2
               	and	x0, x0, x11
               	add	x0, x1, x0
               	cmp	x0, #0x64
               	b.ls	<addr>
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	cmp	x7, #0x5
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x6, #0xcb
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x64               // =100
               	mov	x0, x4
               	mov	x0, x4
               	sub	x3, x29, #0x10
               	mov	x2, #0x1                // =1
               	ldr	x0, [x3, #0x8]
               	mov	x17, #0xfe00            // =65024
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	b	<addr>
               	add	x1, x2, #0x1
               	lsl	x0, x1, #6
               	cmp	x0, #0x64
               	b.hs	<addr>
               	ldr	x0, [x3, x1, lsl #3]
               	mov	x2, x1
               	cbz	x0, <addr>
               	lsl	x1, x2, #6
               	sub	x2, x0, #0x1
               	mvn	x0, x0
               	and	x0, x2, x0
               	lsr	x2, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x2, x2, x17
               	sub	x0, x0, x2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x2, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x2, x0
               	lsr	x2, x0, #4
               	add	x0, x0, x2
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x2, x0, #8
               	add	x0, x0, x2
               	lsr	x2, x0, #16
               	add	x0, x0, x2
               	lsr	x2, x0, #32
               	add	x0, x0, x2
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	add	x0, x1, x0
               	cmp	x0, #0x64
               	b.ls	<addr>
               	cmp	x4, #0x64
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, x0
               	b	<addr>
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	b	<addr>
