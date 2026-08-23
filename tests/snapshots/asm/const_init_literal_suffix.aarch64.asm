
const_init_literal_suffix.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	mov	x1, #0x0                // =0
               	fmov	s16, w0
               	fmov	s17, w1
               	fadd	s0, s16, s17
               	mov	x1, #0x999a             // =39322
               	movk	x1, #0x9999, lsl #16
               	movk	x1, #0x9999, lsl #32
               	movk	x1, #0x3fb9, lsl #48
               	mov	x0, #0x0                // =0
               	fmov	d16, x1
               	fmov	d17, x0
               	fadd	d1, d16, d17
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x4880            // =18560
               	movk	x17, #0x7793, lsl #16
               	movk	x17, #0xe, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x10000000000     // =1099511627776
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x1a00            // =6656
               	movk	x17, #0x1871, lsl #16
               	movk	x17, #0x2, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x4880            // =18560
               	movk	x17, #0x7793, lsl #16
               	movk	x17, #0xe, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x4880            // =18560
               	movk	x17, #0x7793, lsl #16
               	movk	x17, #0xe, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	mov	x17, #0x10000000000     // =1099511627776
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x10000000000     // =1099511627776
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	mov	x17, #0x200000000       // =8589934592
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x10]
               	cbz	x1, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d2, [x1]
               	fcvt	d0, s0
               	fcmp	d2, d0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0xc
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x4880            // =18560
               	movk	x17, #0x7793, lsl #16
               	movk	x17, #0xe, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x10000000000     // =1099511627776
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cbz	x1, <addr>
               	mov	x0, #0x20               // =32
               	b	<addr>
               	b	<addr>
