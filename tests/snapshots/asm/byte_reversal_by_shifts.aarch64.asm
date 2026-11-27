
byte_reversal_by_shifts.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<staged64>:
               	rev	x0, x0
               	ret

<terms64>:
               	rev	x0, x0
               	ret

<masks32>:
               	rev	w0, w0
               	ret

<shifts32>:
               	rev	w0, w0
               	ret

<signed32>:
               	rev	w0, w0
               	ret

<pair16>:
               	rev	w0, w0
               	lsr	w0, w0, #16
               	ret

<sum16>:
               	rev	w0, w0
               	lsr	w0, w0, #16
               	ret

<halves32>:
               	and	w1, w0, #0xff00ff
               	lsl	x1, x1, #8
               	and	w0, w0, #0xff00ff00
               	orr	x0, x1, x0, lsr #8
               	ret

<rotate64>:
               	ror	x0, x0, #0x8
               	ret

<widened32>:
               	rev	w0, w0
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x20, #0xcdef            // =52719
               	movk	x20, #0x89ab, lsl #16
               	movk	x20, #0x4567, lsl #32
               	movk	x20, #0x123, lsl #48
               	mov	x22, #0x0               // =0
               	and	x21, x20, #0xffff
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	sub	x3, x29, #0x40
               	lsl	x4, x1, #3
               	lsr	x4, x20, x4
               	and	x4, x4, #0xff
               	strb	w4, [x3, x1]
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	sub	x3, x29, #0x40
               	ldrb	w3, [x3, x1]
               	orr	x2, x3, x2, lsl #8
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	sub	x3, x29, #0x38
               	lsl	x4, x1, #3
               	lsr	x4, x20, x4
               	and	x4, x4, #0xff
               	strb	w4, [x3, x1]
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	sub	x3, x29, #0x38
               	ldrb	w3, [x3, x1]
               	orr	x2, x3, x2, lsl #8
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	w5, w0
               	mov	w2, w20
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sub	x3, x29, #0x30
               	lsl	x4, x0, #3
               	lsr	x4, x2, x4
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x30
               	ldrb	w2, [x2, x0]
               	orr	x1, x2, x1, lsl #8
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	cmp	x5, x1
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	w5, w0
               	mov	w2, w20
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sub	x3, x29, #0x28
               	lsl	x4, x0, #3
               	lsr	x4, x2, x4
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x28
               	ldrb	w2, [x2, x0]
               	orr	x1, x2, x1, lsl #8
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	cmp	x5, x1
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	w5, w0
               	mov	w2, w20
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sub	x3, x29, #0x20
               	lsl	x4, x0, #3
               	lsr	x4, x2, x4
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x20
               	ldrb	w2, [x2, x0]
               	orr	x1, x2, x1, lsl #8
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	cmp	x5, x1
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	and	x4, x0, #0xffff
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sub	x2, x29, #0x18
               	lsl	x3, x0, #3
               	lsr	x3, x21, x3
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x18
               	ldrb	w2, [x2, x0]
               	orr	x1, x2, x1, lsl #8
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	and	x4, x0, #0xffff
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sub	x2, x29, #0x10
               	lsl	x3, x0, #3
               	lsr	x3, x21, x3
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x10
               	ldrb	w2, [x2, x0]
               	orr	x1, x2, x1, lsl #8
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	w21, w20
               	rev	w1, w20
               	lsr	w1, w1, #16
               	ubfx	x2, x21, #16, #8
               	orr	x1, x1, x2, lsl #24
               	lsr	x2, x21, #24
               	orr	x1, x1, x2, lsl #16
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	ror	x1, x20, #0x8
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	sub	x3, x29, #0x8
               	lsl	x4, x1, #3
               	lsr	x4, x21, x4
               	and	x4, x4, #0xff
               	strb	w4, [x3, x1]
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	sub	x3, x29, #0x8
               	ldrb	w3, [x3, x1]
               	orr	x2, x3, x2, lsl #8
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	sxtw	x1, w2
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x0, x20, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x0, x0, x17
               	eor	x20, x0, x0, lsr #29
               	add	x22, x22, #0x1
               	mov	x17, #0x1000            // =4096
               	cmp	w22, w17
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
