
designator_override_and_braced_string.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x3, #0x0                // =0
               	ldrb	w1, [x0]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x62              // =98
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x3, ne
               	b	<addr>
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x63              // =99
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	b	<addr>
               	cbz	x2, <addr>
               	ldrb	w0, [x0, #0x3]
               	cmp	x0, #0x0
               	cset	x2, eq
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	adrp	x20, <page>
               	add	x20, x20, #0xd0
               	ldrsw	x0, [x20]
               	cmp	x0, #0x1
               	cset	x21, ne
               	cbnz	x21, <addr>
               	ldrsw	x0, [x20, #0x4]
               	cmp	x0, #0x2
               	cset	x21, ne
               	b	<addr>
               	cbz	x21, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x20, #0xc]
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x21, #0x1               // =1
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0xd]
               	mov	x17, #0x6               // =6
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x21, ne
               	b	<addr>
               	cbnz	x21, <addr>
               	ldrb	w0, [x20, #0xe]
               	cmp	x0, #0x0
               	cset	x21, ne
               	b	<addr>
               	cbz	x21, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xee
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xee
               	ldrb	w0, [x0, #0x4]
               	mov	x17, #0x6f              // =111
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xee
               	ldrb	w0, [x0, #0x5]
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	cbz	x20, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xf6
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xf6
               	ldrb	w0, [x0, #0x2]
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	cbz	x20, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, #0x10c
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldrb	w10, [x1, #0x4]
               	strb	w10, [x0, #0x4]
               	ldrb	w10, [x1, #0x5]
               	strb	w10, [x0, #0x5]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0]
               	mov	x17, #0x77              // =119
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x4]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x5]
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	cbz	x20, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, #0x119
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldrb	w10, [x1, #0x4]
               	strb	w10, [x0, #0x4]
               	ldrb	w10, [x1, #0x5]
               	strb	w10, [x0, #0x5]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
