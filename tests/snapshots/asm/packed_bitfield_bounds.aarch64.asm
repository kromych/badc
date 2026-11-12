
packed_bitfield_bounds.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0x1e               // =30
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x0                // =0
               	lsl	x1, x20, #1
               	mov	x2, #0x3                // =3
               	mov	x3, #0x22               // =34
               	mov	x4, #-0x1               // =-1
               	mov	x5, x0
               	bl	<addr>
               	mov	x21, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x21, x17
               	b.eq	<addr>
               	add	x0, x21, x20
               	mov	x2, #0x0                // =0
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	add	x0, x21, x20
               	cbz	x0, <addr>
               	sub	x1, x0, #0x3
               	sub	x7, x0, #0x5
               	sub	x8, x0, #0x6
               	sub	x2, x0, #0x7
               	sub	x5, x0, #0xe
               	sub	x6, x0, #0x9
               	sub	x4, x0, #0x11
               	sub	x9, x0, #0x10
               	mov	x3, #0xff               // =255
               	strb	w3, [x9]
               	sub	x10, x0, #0xf
               	strb	w3, [x10]
               	sub	x11, x0, #0xe
               	strb	w3, [x11]
               	sub	x12, x0, #0xd
               	strb	w3, [x12]
               	sub	x13, x0, #0xc
               	strb	w3, [x13]
               	sub	x14, x0, #0xb
               	strb	w3, [x14]
               	sub	x15, x0, #0xa
               	strb	w3, [x15]
               	sub	x20, x0, #0x9
               	strb	w3, [x20]
               	sub	x21, x0, #0x8
               	strb	w3, [x21]
               	sub	x22, x0, #0x7
               	strb	w3, [x22]
               	sub	x23, x0, #0x6
               	strb	w3, [x23]
               	sub	x23, x0, #0x5
               	strb	w3, [x23]
               	sub	x23, x0, #0x4
               	strb	w3, [x23]
               	sub	x23, x0, #0x3
               	strb	w3, [x23]
               	sub	x23, x0, #0x2
               	strb	w3, [x23]
               	sub	x23, x0, #0x1
               	strb	w3, [x23]
               	ldrh	w24, [x1]
               	ldrb	w25, [x1, #0x2]
               	orr	x24, x24, x25, lsl #16
               	and	x24, x24, #0xffffffffffc00000
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0x3f, lsl #16
               	orr	x24, x24, x17
               	strh	w24, [x1]
               	lsr	x24, x24, #16
               	strb	w24, [x1, #0x2]
               	ldrh	w24, [x1]
               	ldrb	w25, [x1, #0x2]
               	orr	x26, x24, x25, lsl #16
               	sbfx	x26, x26, #0, #22
               	add	x26, x26, #0x7
               	and	x26, x26, #0x3fffff
               	orr	x24, x24, x25, lsl #16
               	and	x24, x24, #0xffffffffffc00000
               	orr	x24, x24, x26
               	strh	w24, [x1]
               	lsr	x24, x24, #16
               	strb	w24, [x1, #0x2]
               	ldrh	w24, [x1]
               	ldrb	w25, [x1, #0x2]
               	orr	x24, x24, x25, lsl #16
               	sbfx	x24, x24, #0, #22
               	cmp	w24, #0x2
               	b.ne	<addr>
               	ldrb	w23, [x23]
               	cmp	w23, #0xc0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	strb	w3, [x9]
               	strb	w3, [x10]
               	strb	w3, [x11]
               	strb	w3, [x12]
               	strb	w3, [x13]
               	strb	w3, [x14]
               	strb	w3, [x15]
               	strb	w3, [x20]
               	strb	w3, [x21]
               	strb	w3, [x22]
               	sub	x10, x0, #0x6
               	strb	w3, [x10]
               	sub	x11, x0, #0x5
               	strb	w3, [x11]
               	sub	x12, x0, #0x4
               	strb	w3, [x12]
               	sub	x13, x0, #0x3
               	strb	w3, [x13]
               	sub	x14, x0, #0x2
               	strb	w3, [x14]
               	sub	x9, x0, #0x1
               	strb	w3, [x9]
               	ldr	w3, [x7]
               	ldrb	w15, [x7, #0x4]
               	orr	x3, x3, x15, lsl #32
               	and	x3, x3, #0xfffffff000000000
               	mov	x17, #0x9877            // =39031
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xe, lsl #32
               	orr	x3, x3, x17
               	str	w3, [x7]
               	lsr	x3, x3, #32
               	strb	w3, [x7, #0x4]
               	ldr	w3, [x7]
               	ldrb	w15, [x7, #0x4]
               	orr	x20, x3, x15, lsl #32
               	sbfx	x20, x20, #0, #36
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x20, x17
               	b.ne	<addr>
               	ldrb	w20, [x9]
               	cmp	w20, #0xfe
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	orr	x3, x3, x15, lsl #32
               	and	x3, x3, #0xfffffff000000000
               	mov	x17, #0x5               // =5
               	orr	x3, x3, x17
               	str	w3, [x7]
               	lsr	x3, x3, #32
               	strb	w3, [x7, #0x4]
               	ldr	w3, [x7]
               	ldrb	w7, [x7, #0x4]
               	orr	x3, x3, x7, lsl #32
               	sbfx	x3, x3, #0, #36
               	cmp	x3, #0x5
               	b.ne	<addr>
               	ldrb	w3, [x9]
               	cmp	w3, #0xf0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sub	x7, x0, #0x10
               	mov	x3, #0xff               // =255
               	strb	w3, [x7]
               	sub	x15, x0, #0xf
               	strb	w3, [x15]
               	sub	x20, x0, #0xe
               	strb	w3, [x20]
               	sub	x21, x0, #0xd
               	strb	w3, [x21]
               	sub	x22, x0, #0xc
               	strb	w3, [x22]
               	sub	x23, x0, #0xb
               	strb	w3, [x23]
               	sub	x24, x0, #0xa
               	strb	w3, [x24]
               	sub	x24, x0, #0x9
               	strb	w3, [x24]
               	sub	x24, x0, #0x8
               	strb	w3, [x24]
               	sub	x24, x0, #0x7
               	strb	w3, [x24]
               	strb	w3, [x10]
               	strb	w3, [x11]
               	strb	w3, [x12]
               	strb	w3, [x13]
               	strb	w3, [x14]
               	strb	w3, [x9]
               	ldr	w10, [x8]
               	ldrh	w11, [x8, #0x4]
               	orr	x10, x10, x11, lsl #32
               	and	x10, x10, #0xfffff00000000000
               	orr	x10, x10, #0x7ffffffffff
               	str	w10, [x8]
               	lsr	x10, x10, #32
               	strh	w10, [x8, #0x4]
               	ldr	w10, [x8]
               	ldrh	w11, [x8, #0x4]
               	orr	x12, x10, x11, lsl #32
               	sbfx	x12, x12, #0, #44
               	sub	x12, x12, #0x1
               	and	x12, x12, #0xfffffffffff
               	orr	x10, x10, x11, lsl #32
               	and	x10, x10, #0xfffff00000000000
               	orr	x10, x10, x12
               	str	w10, [x8]
               	lsr	x10, x10, #32
               	strh	w10, [x8, #0x4]
               	ldr	w10, [x8]
               	ldrh	w8, [x8, #0x4]
               	orr	x8, x10, x8, lsl #32
               	sbfx	x8, x8, #0, #44
               	mov	x17, #0x7fffffffffe     // =8796093022206
               	cmp	x8, x17
               	b.ne	<addr>
               	ldrb	w8, [x9]
               	cmp	w8, #0xf7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	strb	w3, [x7]
               	strb	w3, [x15]
               	strb	w3, [x20]
               	strb	w3, [x21]
               	strb	w3, [x22]
               	strb	w3, [x23]
               	sub	x8, x0, #0xa
               	strb	w3, [x8]
               	sub	x9, x0, #0x9
               	strb	w3, [x9]
               	sub	x10, x0, #0x8
               	strb	w3, [x10]
               	sub	x11, x0, #0x7
               	strb	w3, [x11]
               	sub	x12, x0, #0x6
               	strb	w3, [x12]
               	sub	x13, x0, #0x5
               	strb	w3, [x13]
               	sub	x14, x0, #0x4
               	strb	w3, [x14]
               	sub	x15, x0, #0x3
               	strb	w3, [x15]
               	sub	x20, x0, #0x2
               	strb	w3, [x20]
               	sub	x7, x0, #0x1
               	strb	w3, [x7]
               	ldr	w3, [x2]
               	ldrh	w21, [x2, #0x4]
               	orr	x3, x3, x21, lsl #32
               	ldrb	w21, [x2, #0x6]
               	orr	x3, x3, x21, lsl #48
               	and	x3, x3, #0xfff0000000000000
               	orr	x3, x3, #0xfffffffffffff
               	str	w3, [x2]
               	lsr	x21, x3, #32
               	strh	w21, [x2, #0x4]
               	lsr	x3, x3, #48
               	strb	w3, [x2, #0x6]
               	ldr	w3, [x2]
               	ldrh	w21, [x2, #0x4]
               	orr	x23, x3, x21, lsl #32
               	ldrb	w22, [x2, #0x6]
               	orr	x23, x23, x22, lsl #48
               	sbfx	x23, x23, #0, #52
               	mov	x17, #0x5               // =5
               	eor	x23, x23, x17
               	and	x23, x23, #0xfffffffffffff
               	orr	x3, x3, x21, lsl #32
               	orr	x3, x3, x22, lsl #48
               	and	x3, x3, #0xfff0000000000000
               	orr	x3, x3, x23
               	str	w3, [x2]
               	lsr	x21, x3, #32
               	strh	w21, [x2, #0x4]
               	lsr	x3, x3, #48
               	strb	w3, [x2, #0x6]
               	ldr	w3, [x2]
               	ldrh	w21, [x2, #0x4]
               	orr	x23, x3, x21, lsl #32
               	ldrb	w22, [x2, #0x6]
               	orr	x23, x23, x22, lsl #48
               	sbfx	x23, x23, #0, #52
               	mov	x17, #-0x6              // =-6
               	cmp	x23, x17
               	b.ne	<addr>
               	ldrb	w23, [x7]
               	cmp	w23, #0xff
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	orr	x3, x3, x21, lsl #32
               	orr	x3, x3, x22, lsl #48
               	and	x3, x3, #0xfff0000000000000
               	str	w3, [x2]
               	lsr	x21, x3, #32
               	strh	w21, [x2, #0x4]
               	lsr	x3, x3, #48
               	strb	w3, [x2, #0x6]
               	ldr	w3, [x2]
               	ldrh	w21, [x2, #0x4]
               	orr	x3, x3, x21, lsl #32
               	ldrb	w21, [x2, #0x6]
               	orr	x3, x3, x21, lsl #48
               	sbfx	x3, x3, #0, #52
               	cbnz	x3, <addr>
               	ldrb	w3, [x7]
               	cmp	w3, #0xf0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sub	x21, x0, #0x10
               	strb	wzr, [x21]
               	sub	x22, x0, #0xf
               	strb	wzr, [x22]
               	sub	x23, x0, #0xe
               	strb	wzr, [x23]
               	sub	x24, x0, #0xd
               	strb	wzr, [x24]
               	sub	x25, x0, #0xc
               	strb	wzr, [x25]
               	sub	x26, x0, #0xb
               	strb	wzr, [x26]
               	strb	wzr, [x8]
               	strb	wzr, [x9]
               	strb	wzr, [x10]
               	strb	wzr, [x11]
               	strb	wzr, [x12]
               	strb	wzr, [x13]
               	strb	wzr, [x14]
               	strb	wzr, [x15]
               	strb	wzr, [x20]
               	strb	wzr, [x7]
               	ldrb	w3, [x1]
               	and	x3, x3, #0xfffffffffffffff0
               	mov	x17, #0x9               // =9
               	orr	x3, x3, x17
               	strb	w3, [x1]
               	ldrh	w3, [x1]
               	ldrb	w7, [x1, #0x2]
               	orr	x3, x3, x7, lsl #16
               	and	x3, x3, #0xffffffffff00000f
               	mov	x17, #0xcbb0            // =52144
               	movk	x17, #0xed, lsl #16
               	orr	x3, x3, x17
               	strh	w3, [x1]
               	lsr	x3, x3, #16
               	strb	w3, [x1, #0x2]
               	ldrh	w3, [x1]
               	ldrb	w7, [x1, #0x2]
               	orr	x8, x3, x7, lsl #16
               	sbfx	x8, x8, #4, #20
               	mov	x17, #-0x2345           // =-9029
               	movk	x17, #0xfffe, lsl #16
               	cmp	w8, w17
               	b.ne	<addr>
               	ldrb	w8, [x1]
               	and	x8, x8, #0xf
               	cmp	w8, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	orr	x3, x3, x7, lsl #16
               	sbfx	x3, x3, #4, #20
               	add	x3, x3, #0x1
               	and	x3, x3, #0xfffff
               	ldrh	w7, [x1]
               	ldrb	w8, [x1, #0x2]
               	orr	x7, x7, x8, lsl #16
               	and	x7, x7, #0xffffffffff00000f
               	orr	x3, x7, x3, lsl #4
               	strh	w3, [x1]
               	lsr	x3, x3, #16
               	strb	w3, [x1, #0x2]
               	ldrh	w3, [x1]
               	ldrb	w7, [x1, #0x2]
               	orr	x3, x3, x7, lsl #16
               	sbfx	x3, x3, #4, #20
               	mov	x17, #-0x2344           // =-9028
               	movk	x17, #0xfffe, lsl #16
               	cmp	w3, w17
               	b.ne	<addr>
               	ldrb	w3, [x1]
               	and	x3, x3, #0xf
               	cmp	w3, #0x9
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x3, #0xff               // =255
               	strb	w3, [x21]
               	strb	w3, [x22]
               	strb	w3, [x23]
               	strb	w3, [x24]
               	strb	w3, [x25]
               	sub	x8, x0, #0xb
               	strb	w3, [x8]
               	sub	x9, x0, #0xa
               	strb	w3, [x9]
               	sub	x10, x0, #0x9
               	strb	w3, [x10]
               	sub	x11, x0, #0x8
               	strb	w3, [x11]
               	sub	x12, x0, #0x7
               	strb	w3, [x12]
               	sub	x13, x0, #0x6
               	strb	w3, [x13]
               	sub	x14, x0, #0x5
               	strb	w3, [x14]
               	sub	x15, x0, #0x4
               	strb	w3, [x15]
               	sub	x20, x0, #0x3
               	strb	w3, [x20]
               	sub	x21, x0, #0x2
               	strb	w3, [x21]
               	sub	x7, x0, #0x1
               	strb	w3, [x7]
               	ldrh	w3, [x1]
               	ldrb	w22, [x1, #0x2]
               	orr	x3, x3, x22, lsl #16
               	and	x3, x3, #0xffffffffff800000
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2a, lsl #16
               	orr	x3, x3, x17
               	strh	w3, [x1]
               	lsr	x3, x3, #16
               	strb	w3, [x1, #0x2]
               	ldrh	w3, [x1]
               	ldrb	w1, [x1, #0x2]
               	orr	x1, x3, x1, lsl #16
               	and	x1, x1, #0x7fffff
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2a, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w1, [x7]
               	cmp	w1, #0xaa
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sub	x3, x0, #0x10
               	strb	wzr, [x3]
               	sub	x22, x0, #0xf
               	strb	wzr, [x22]
               	sub	x23, x0, #0xe
               	strb	wzr, [x23]
               	sub	x24, x0, #0xd
               	strb	wzr, [x24]
               	sub	x25, x0, #0xc
               	strb	wzr, [x25]
               	strb	wzr, [x8]
               	strb	wzr, [x9]
               	strb	wzr, [x10]
               	strb	wzr, [x11]
               	strb	wzr, [x12]
               	strb	wzr, [x13]
               	strb	wzr, [x14]
               	strb	wzr, [x15]
               	strb	wzr, [x20]
               	strb	wzr, [x21]
               	strb	wzr, [x7]
               	mov	x1, #0x5a               // =90
               	strb	w1, [x2]
               	ldur	w1, [x2, #0x1]
               	ldurh	w3, [x2, #0x5]
               	orr	x1, x1, x3, lsl #32
               	and	x1, x1, #0xffff000000000000
               	mov	x17, #0x7654            // =30292
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	orr	x1, x1, x17
               	stur	w1, [x2, #0x1]
               	lsr	x1, x1, #32
               	sturh	w1, [x2, #0x5]
               	ldur	w1, [x2, #0x1]
               	ldurh	w3, [x2, #0x5]
               	orr	x8, x1, x3, lsl #32
               	mov	x17, #0x7654            // =30292
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	cmp	x8, x17
               	b.ne	<addr>
               	ldrb	w7, [x7]
               	cmp	w7, #0xfe
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	orr	x7, x1, x3, lsl #32
               	orr	x1, x1, x3, lsl #32
               	and	x1, x1, #0xffff000000000000
               	orr	x1, x1, x7, lsr #4
               	stur	w1, [x2, #0x1]
               	lsr	x1, x1, #32
               	sturh	w1, [x2, #0x5]
               	ldur	w1, [x2, #0x1]
               	ldurh	w2, [x2, #0x5]
               	orr	x1, x1, x2, lsl #32
               	mov	x17, #0x8765            // =34661
               	movk	x17, #0xcba9, lsl #16
               	movk	x17, #0xfed, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	sub	x3, x0, #0x20
               	mov	x1, #0xff               // =255
               	strb	w1, [x3]
               	sub	x7, x0, #0x1f
               	strb	w1, [x7]
               	sub	x8, x0, #0x1e
               	strb	w1, [x8]
               	sub	x9, x0, #0x1d
               	strb	w1, [x9]
               	sub	x10, x0, #0x1c
               	strb	w1, [x10]
               	sub	x11, x0, #0x1b
               	strb	w1, [x11]
               	sub	x12, x0, #0x1a
               	strb	w1, [x12]
               	sub	x13, x0, #0x19
               	strb	w1, [x13]
               	sub	x14, x0, #0x18
               	strb	w1, [x14]
               	sub	x15, x0, #0x17
               	strb	w1, [x15]
               	sub	x20, x0, #0x16
               	strb	w1, [x20]
               	sub	x21, x0, #0x15
               	strb	w1, [x21]
               	sub	x26, x0, #0x14
               	strb	w1, [x26]
               	sub	x2, x0, #0x13
               	strb	w1, [x2]
               	sub	x2, x0, #0x12
               	strb	w1, [x2]
               	sub	x2, x0, #0x11
               	strb	w1, [x2]
               	sub	x2, x0, #0x10
               	strb	w1, [x2]
               	strb	w1, [x22]
               	strb	w1, [x23]
               	strb	w1, [x24]
               	strb	w1, [x25]
               	sub	x2, x0, #0xb
               	strb	w1, [x2]
               	sub	x2, x0, #0xa
               	strb	w1, [x2]
               	sub	x2, x0, #0x9
               	strb	w1, [x2]
               	sub	x2, x0, #0x8
               	strb	w1, [x2]
               	sub	x2, x0, #0x7
               	strb	w1, [x2]
               	sub	x2, x0, #0x6
               	strb	w1, [x2]
               	sub	x2, x0, #0x5
               	strb	w1, [x2]
               	sub	x2, x0, #0x4
               	strb	w1, [x2]
               	sub	x2, x0, #0x3
               	strb	w1, [x2]
               	sub	x2, x0, #0x2
               	strb	w1, [x2]
               	sub	x2, x0, #0x1
               	strb	w1, [x2]
               	mov	x1, #0x3                // =3
               	strb	w1, [x5]
               	ldur	w1, [x5, #0x9]
               	ldrb	w22, [x5, #0xd]
               	orr	x1, x1, x22, lsl #32
               	and	x1, x1, #0xfffffff000000000
               	mov	x22, #0x3210            // =12816
               	movk	x22, #0x7654, lsl #16
               	movk	x22, #0xba98, lsl #32
               	movk	x22, #0xfedc, lsl #48
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	orr	x1, x1, x17
               	stur	x22, [x5, #0x1]
               	stur	w1, [x5, #0x9]
               	lsr	x1, x1, #32
               	strb	w1, [x5, #0xd]
               	ldur	w22, [x5, #0x9]
               	ldrb	w23, [x5, #0xd]
               	orr	x1, x22, x23, lsl #32
               	mov	x24, #0xcba9            // =52137
               	movk	x24, #0xfed, lsl #16
               	orr	x24, x24, x1, lsl #28
               	mov	x1, #0x3210             // =12816
               	movk	x1, #0x7654, lsl #16
               	movk	x1, #0x8, lsl #32
               	orr	x25, x1, x24, lsl #36
               	add	x1, x25, #0x1
               	cmp	x1, x25
               	cset	x25, lo
               	add	x24, x25, x24, asr #28
               	and	x24, x24, #0xfffffffff
               	orr	x22, x22, x23, lsl #32
               	and	x22, x22, #0xfffffff000000000
               	orr	x22, x22, x24
               	stur	x1, [x5, #0x1]
               	stur	w22, [x5, #0x9]
               	lsr	x22, x22, #32
               	strb	w22, [x5, #0xd]
               	ldur	w22, [x5, #0x9]
               	ldrb	w23, [x5, #0xd]
               	orr	x22, x22, x23, lsl #32
               	lsl	x22, x22, #28
               	orr	x22, x22, x1, lsr #36
               	mov	x23, #0x6789            // =26505
               	movk	x23, #0x2345, lsl #16
               	movk	x23, #0x1, lsl #32
               	ubfx	x1, x1, #0, #36
               	orr	x1, x1, x22, lsl #36
               	mov	x17, #0x3211            // =12817
               	movk	x17, #0x7654, lsl #16
               	movk	x17, #0xba98, lsl #32
               	movk	x17, #0xfedc, lsl #48
               	eor	x1, x1, x17
               	eor	x22, x23, x22, asr #28
               	orr	x1, x1, x22
               	cbnz	x1, <addr>
               	ldrb	w1, [x2]
               	cmp	w1, #0xf1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x1, #-0x2               // =-2
               	ldur	w22, [x5, #0x9]
               	ldrb	w23, [x5, #0xd]
               	orr	x22, x22, x23, lsl #32
               	and	x22, x22, #0xfffffff000000000
               	orr	x22, x22, #0xfffffffff
               	stur	x1, [x5, #0x1]
               	stur	w22, [x5, #0x9]
               	lsr	x22, x22, #32
               	strb	w22, [x5, #0xd]
               	ldur	w22, [x5, #0x9]
               	ldrb	w5, [x5, #0xd]
               	orr	x5, x22, x5, lsl #32
               	lsl	x5, x5, #28
               	orr	x5, x5, #0xfffffff
               	asr	x22, x5, #28
               	lsl	x5, x5, #36
               	orr	x5, x5, #0xffffffffe
               	eor	x1, x5, x1
               	mvn	x5, x22
               	orr	x1, x1, x5
               	cbnz	x1, <addr>
               	ldrb	w1, [x2]
               	cmp	w1, #0xff
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x1, #0x0                // =0
               	strb	w1, [x3]
               	strb	w1, [x7]
               	strb	w1, [x8]
               	strb	w1, [x9]
               	strb	w1, [x10]
               	strb	w1, [x11]
               	strb	w1, [x12]
               	strb	w1, [x13]
               	strb	w1, [x14]
               	strb	w1, [x15]
               	strb	w1, [x20]
               	strb	w1, [x21]
               	strb	w1, [x26]
               	sub	x3, x0, #0x13
               	strb	w1, [x3]
               	sub	x5, x0, #0x12
               	strb	w1, [x5]
               	sub	x7, x0, #0x11
               	strb	w1, [x7]
               	sub	x8, x0, #0x10
               	strb	w1, [x8]
               	sub	x9, x0, #0xf
               	strb	w1, [x9]
               	sub	x10, x0, #0xe
               	strb	w1, [x10]
               	sub	x11, x0, #0xd
               	strb	w1, [x11]
               	sub	x12, x0, #0xc
               	strb	w1, [x12]
               	sub	x13, x0, #0xb
               	strb	w1, [x13]
               	sub	x14, x0, #0xa
               	strb	w1, [x14]
               	sub	x15, x0, #0x9
               	strb	w1, [x15]
               	sub	x20, x0, #0x8
               	strb	w1, [x20]
               	sub	x21, x0, #0x7
               	strb	w1, [x21]
               	sub	x22, x0, #0x6
               	strb	w1, [x22]
               	sub	x23, x0, #0x5
               	strb	w1, [x23]
               	sub	x2, x0, #0x4
               	strb	w1, [x2]
               	sub	x2, x0, #0x3
               	strb	w1, [x2]
               	sub	x2, x0, #0x2
               	strb	w1, [x2]
               	sub	x2, x0, #0x1
               	strb	w1, [x2]
               	ldrb	w24, [x6]
               	and	x24, x24, #0xfffffffffffffffe
               	orr	x24, x24, #0x1
               	strb	w24, [x6]
               	ldrb	w24, [x6, #0x8]
               	and	x24, x24, #0xffffffffffffff01
               	mov	x17, #0xaa              // =170
               	orr	x24, x24, x17
               	strb	w24, [x6, #0x8]
               	ldr	x24, [x6]
               	ldrb	w25, [x6, #0x8]
               	and	x24, x24, #0x1
               	and	x25, x25, #0xfffffffffffffffe
               	mov	x17, #0x9bde            // =39902
               	movk	x17, #0x1357, lsl #16
               	movk	x17, #0x8acf, lsl #32
               	movk	x17, #0x246, lsl #48
               	orr	x24, x24, x17
               	orr	x25, x25, #0x1
               	str	x24, [x6]
               	strb	w25, [x6, #0x8]
               	ldrb	w25, [x6, #0x8]
               	lsr	x24, x24, #1
               	orr	x24, x24, x25, lsl #63
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x8123, lsl #48
               	cmp	x24, x17
               	b.ne	<addr>
               	ldrb	w24, [x6]
               	and	x24, x24, #0x1
               	cmp	w24, #0x1
               	b.ne	<addr>
               	asr	x24, x25, #1
               	cmp	w24, #0x55
               	b.ne	<addr>
               	ldrb	w24, [x2]
               	cmp	w24, #0xab
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldr	x24, [x6]
               	ldrb	w25, [x6, #0x8]
               	lsr	x26, x24, #1
               	orr	x26, x26, x25, lsl #63
               	mov	x17, #-0x3              // =-3
               	cmp	x26, x17
               	cset	x26, hs
               	and	x24, x24, #0x1
               	and	x25, x25, #0xfffffffffffffffe
               	orr	x24, x24, x26, lsl #1
               	str	x24, [x6]
               	strb	w25, [x6, #0x8]
               	ldrb	w25, [x6, #0x8]
               	lsr	x24, x24, #1
               	orr	x24, x24, x25, lsl #63
               	cbnz	x24, <addr>
               	ldrb	w6, [x6]
               	and	x6, x6, #0x1
               	cmp	w6, #0x1
               	b.ne	<addr>
               	asr	x6, x25, #1
               	cmp	w6, #0x55
               	b.ne	<addr>
               	ldrb	w2, [x2]
               	cmp	w2, #0xaa
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sub	x2, x0, #0x20
               	strb	w1, [x2]
               	sub	x2, x0, #0x1f
               	strb	w1, [x2]
               	sub	x2, x0, #0x1e
               	strb	w1, [x2]
               	sub	x2, x0, #0x1d
               	strb	w1, [x2]
               	sub	x2, x0, #0x1c
               	strb	w1, [x2]
               	sub	x2, x0, #0x1b
               	strb	w1, [x2]
               	sub	x2, x0, #0x1a
               	strb	w1, [x2]
               	sub	x2, x0, #0x19
               	strb	w1, [x2]
               	sub	x2, x0, #0x18
               	strb	w1, [x2]
               	sub	x2, x0, #0x17
               	strb	w1, [x2]
               	sub	x2, x0, #0x16
               	strb	w1, [x2]
               	sub	x2, x0, #0x15
               	strb	w1, [x2]
               	sub	x2, x0, #0x14
               	strb	w1, [x2]
               	strb	w1, [x3]
               	strb	w1, [x5]
               	strb	w1, [x7]
               	strb	w1, [x8]
               	strb	w1, [x9]
               	strb	w1, [x10]
               	strb	w1, [x11]
               	strb	w1, [x12]
               	strb	w1, [x13]
               	strb	w1, [x14]
               	strb	w1, [x15]
               	strb	w1, [x20]
               	strb	w1, [x21]
               	strb	w1, [x22]
               	strb	w1, [x23]
               	sub	x2, x0, #0x4
               	strb	w1, [x2]
               	sub	x2, x0, #0x3
               	strb	w1, [x2]
               	sub	x2, x0, #0x2
               	strb	w1, [x2]
               	sub	x0, x0, #0x1
               	strb	w1, [x0]
               	ldrb	w2, [x4]
               	and	x2, x2, #0xfffffffffffffffe
               	orr	x2, x2, #0x1
               	strb	w2, [x4]
               	ldrb	w2, [x4, #0x10]
               	and	x2, x2, #0xffffffffffffff01
               	mov	x17, #0x54              // =84
               	orr	x2, x2, x17
               	strb	w2, [x4, #0x10]
               	ldr	x2, [x4]
               	ldrb	w3, [x4, #0x10]
               	and	x2, x2, #0x1
               	mov	x17, #0x6420            // =25632
               	movk	x17, #0xeca8, lsl #16
               	movk	x17, #0x7530, lsl #32
               	movk	x17, #0xfdb9, lsl #48
               	orr	x2, x2, x17
               	mov	x5, #0x9bdf             // =39903
               	movk	x5, #0x1357, lsl #16
               	movk	x5, #0x8acf, lsl #32
               	movk	x5, #0x246, lsl #48
               	str	x2, [x4]
               	str	x5, [x4, #0x8]
               	and	x3, x3, #0xfffffffffffffffe
               	strb	w3, [x4, #0x10]
               	ldrb	w3, [x4, #0x10]
               	lsr	x2, x2, #1
               	orr	x5, x2, #0x8000000000000000
               	mov	x2, #0xcdef             // =52719
               	movk	x2, #0x89ab, lsl #16
               	movk	x2, #0x4567, lsl #32
               	movk	x2, #0x123, lsl #48
               	orr	x6, x2, x3, lsl #63
               	add	x2, x5, #0x1
               	cmp	x2, x5
               	cset	x5, lo
               	add	x5, x6, x5
               	lsl	x6, x5, #1
               	orr	x6, x6, x2, lsr #63
               	ldr	x7, [x4]
               	and	x7, x7, #0x1
               	orr	x2, x7, x2, lsl #1
               	orr	x1, x1, x6
               	str	x2, [x4]
               	str	x1, [x4, #0x8]
               	and	x3, x3, #0xfffffffffffffffe
               	orr	x3, x3, x5, lsr #63
               	strb	w3, [x4, #0x10]
               	ldrb	w3, [x4, #0x10]
               	lsr	x5, x1, #1
               	lsr	x2, x2, #1
               	orr	x1, x2, x1, lsl #63
               	orr	x2, x5, x3, lsl #63
               	mov	x17, #0x3211            // =12817
               	movk	x17, #0x7654, lsl #16
               	movk	x17, #0xba98, lsl #32
               	movk	x17, #0xfedc, lsl #48
               	eor	x1, x1, x17
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	eor	x2, x2, x17
               	orr	x1, x1, x2
               	cbnz	x1, <addr>
               	ldrb	w1, [x4]
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	asr	x1, x3, #1
               	cmp	w1, #0x2a
               	b.ne	<addr>
               	ldrb	w1, [x0]
               	cmp	w1, #0x54
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldr	x1, [x4]
               	ldrb	w2, [x4, #0x10]
               	and	x1, x1, #0x1
               	orr	x1, x1, #0xfffffffffffffffe
               	mov	x3, #-0x1               // =-1
               	str	x1, [x4]
               	str	x3, [x4, #0x8]
               	and	x2, x2, #0xfffffffffffffffe
               	orr	x2, x2, #0x1
               	strb	w2, [x4, #0x10]
               	ldrb	w2, [x4, #0x10]
               	lsr	x1, x1, #1
               	orr	x1, x1, #0x8000000000000000
               	lsl	x3, x2, #63
               	orr	x3, x3, #0x7fffffffffffffff
               	mvn	x1, x1
               	mvn	x3, x3
               	orr	x1, x1, x3
               	cbnz	x1, <addr>
               	ldrb	w1, [x4]
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	asr	x1, x2, #1
               	cmp	w1, #0x2a
               	b.ne	<addr>
               	ldrb	w0, [x0]
               	cmp	w0, #0x55
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
