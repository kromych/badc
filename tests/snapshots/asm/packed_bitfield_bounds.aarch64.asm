
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

<page_end>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
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
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	add	x0, x21, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	bl	<addr>
               	mov	x22, x0
               	cbnz	x22, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x21, x22, #0x3
               	sub	x23, x22, #0x5
               	sub	x24, x22, #0x6
               	sub	x20, x22, #0x7
               	sub	x0, x22, #0x10
               	mov	x1, #0xff               // =255
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	ldrh	w0, [x21]
               	ldrb	w1, [x21, #0x2]
               	lsl	x1, x1, #16
               	orr	x0, x0, x1
               	and	x0, x0, #0xffffffffffc00000
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0x3f, lsl #16
               	orr	x0, x0, x17
               	strh	w0, [x21]
               	lsr	x0, x0, #16
               	strb	w0, [x21, #0x2]
               	ldrh	w0, [x21]
               	ldrb	w1, [x21, #0x2]
               	lsl	x1, x1, #16
               	orr	x0, x0, x1
               	and	x0, x0, #0x3fffff
               	lsl	x0, x0, #42
               	asr	x0, x0, #42
               	add	x0, x0, #0x7
               	and	x0, x0, #0x3fffff
               	ldrh	w1, [x21]
               	ldrb	w2, [x21, #0x2]
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	and	x1, x1, #0xffffffffffc00000
               	orr	x0, x1, x0
               	strh	w0, [x21]
               	lsr	x0, x0, #16
               	strb	w0, [x21, #0x2]
               	ldrh	w0, [x21]
               	ldrb	w1, [x21, #0x2]
               	lsl	x1, x1, #16
               	orr	x0, x0, x1
               	and	x0, x0, #0x3fffff
               	lsl	x0, x0, #42
               	asr	x0, x0, #42
               	cmp	w0, #0x2
               	b.ne	<addr>
               	sub	x0, x22, #0x1
               	ldrb	w0, [x0]
               	eor	x0, x0, #0xc0
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x0, x22, #0x10
               	mov	x1, #0xff               // =255
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	ldr	w0, [x23]
               	ldrb	w1, [x23, #0x4]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	and	x0, x0, #0xfffffff000000000
               	mov	x17, #0x9877            // =39031
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xe, lsl #32
               	orr	x0, x0, x17
               	str	w0, [x23]
               	lsr	x0, x0, #32
               	strb	w0, [x23, #0x4]
               	ldr	w0, [x23]
               	ldrb	w1, [x23, #0x4]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	and	x0, x0, #0xfffffffff
               	lsl	x0, x0, #28
               	asr	x0, x0, #28
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x0, x22, #0x1
               	ldrb	w1, [x0]
               	eor	x1, x1, #0xfe
               	cbz	w1, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	w1, [x23]
               	ldrb	w2, [x23, #0x4]
               	lsl	x2, x2, #32
               	orr	x1, x1, x2
               	and	x1, x1, #0xfffffff000000000
               	mov	x17, #0x5               // =5
               	orr	x1, x1, x17
               	str	w1, [x23]
               	lsr	x1, x1, #32
               	strb	w1, [x23, #0x4]
               	ldr	w1, [x23]
               	ldrb	w2, [x23, #0x4]
               	lsl	x2, x2, #32
               	orr	x1, x1, x2
               	and	x1, x1, #0xfffffffff
               	lsl	x1, x1, #28
               	asr	x1, x1, #28
               	cmp	x1, #0x5
               	b.ne	<addr>
               	ldrb	w0, [x0]
               	eor	x0, x0, #0xf0
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x0, x22, #0x10
               	mov	x1, #0xff               // =255
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	ldr	w0, [x24]
               	ldrh	w1, [x24, #0x4]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	and	x0, x0, #0xfffff00000000000
               	orr	x0, x0, #0x7ffffffffff
               	str	w0, [x24]
               	lsr	x0, x0, #32
               	strh	w0, [x24, #0x4]
               	ldr	w0, [x24]
               	ldrh	w1, [x24, #0x4]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	and	x0, x0, #0xfffffffffff
               	lsl	x0, x0, #20
               	asr	x0, x0, #20
               	sub	x0, x0, #0x1
               	and	x0, x0, #0xfffffffffff
               	ldr	w1, [x24]
               	ldrh	w2, [x24, #0x4]
               	lsl	x2, x2, #32
               	orr	x1, x1, x2
               	and	x1, x1, #0xfffff00000000000
               	orr	x0, x1, x0
               	str	w0, [x24]
               	lsr	x0, x0, #32
               	strh	w0, [x24, #0x4]
               	ldr	w0, [x24]
               	ldrh	w1, [x24, #0x4]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	and	x0, x0, #0xfffffffffff
               	lsl	x0, x0, #20
               	asr	x0, x0, #20
               	mov	x17, #0x7fffffffffe     // =8796093022206
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x0, x22, #0x1
               	ldrb	w0, [x0]
               	mov	x17, #0xf7              // =247
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x0, x22, #0x10
               	mov	x1, #0xff               // =255
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	ldr	w0, [x20]
               	ldrh	w1, [x20, #0x4]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	ldrb	w1, [x20, #0x6]
               	lsl	x1, x1, #48
               	orr	x0, x0, x1
               	and	x0, x0, #0xfff0000000000000
               	orr	x0, x0, #0xfffffffffffff
               	str	w0, [x20]
               	lsr	x1, x0, #32
               	strh	w1, [x20, #0x4]
               	lsr	x0, x0, #48
               	strb	w0, [x20, #0x6]
               	ldr	w0, [x20]
               	ldrh	w1, [x20, #0x4]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	ldrb	w1, [x20, #0x6]
               	lsl	x1, x1, #48
               	orr	x0, x0, x1
               	and	x0, x0, #0xfffffffffffff
               	lsl	x0, x0, #12
               	asr	x0, x0, #12
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	and	x0, x0, #0xfffffffffffff
               	ldr	w1, [x20]
               	ldrh	w2, [x20, #0x4]
               	lsl	x2, x2, #32
               	orr	x1, x1, x2
               	ldrb	w2, [x20, #0x6]
               	lsl	x2, x2, #48
               	orr	x1, x1, x2
               	and	x1, x1, #0xfff0000000000000
               	orr	x0, x1, x0
               	str	w0, [x20]
               	lsr	x1, x0, #32
               	strh	w1, [x20, #0x4]
               	lsr	x0, x0, #48
               	strb	w0, [x20, #0x6]
               	ldr	w0, [x20]
               	ldrh	w1, [x20, #0x4]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	ldrb	w1, [x20, #0x6]
               	lsl	x1, x1, #48
               	orr	x0, x0, x1
               	and	x0, x0, #0xfffffffffffff
               	lsl	x0, x0, #12
               	asr	x0, x0, #12
               	mov	x17, #-0x6              // =-6
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x1, x22, #0x1
               	ldrb	w0, [x1]
               	eor	x0, x0, #0xff
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	w0, [x20]
               	ldrh	w2, [x20, #0x4]
               	lsl	x2, x2, #32
               	orr	x0, x0, x2
               	ldrb	w2, [x20, #0x6]
               	lsl	x2, x2, #48
               	orr	x0, x0, x2
               	and	x0, x0, #0xfff0000000000000
               	str	w0, [x20]
               	lsr	x2, x0, #32
               	strh	w2, [x20, #0x4]
               	lsr	x0, x0, #48
               	strb	w0, [x20, #0x6]
               	ldr	w0, [x20]
               	ldrh	w2, [x20, #0x4]
               	lsl	x2, x2, #32
               	orr	x0, x0, x2
               	ldrb	w2, [x20, #0x6]
               	lsl	x2, x2, #48
               	orr	x0, x0, x2
               	and	x0, x0, #0xfffffffffffff
               	lsl	x0, x0, #12
               	asr	x0, x0, #12
               	cbnz	x0, <addr>
               	ldrb	w0, [x1]
               	eor	x0, x0, #0xf0
               	cbz	w0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x0, x22, #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	ldrb	w0, [x21]
               	and	x0, x0, #0xfffffffffffffff0
               	mov	x17, #0x9               // =9
               	orr	x0, x0, x17
               	strb	w0, [x21]
               	ldrh	w0, [x21]
               	ldrb	w1, [x21, #0x2]
               	lsl	x1, x1, #16
               	orr	x0, x0, x1
               	and	x0, x0, #0xffffffffff00000f
               	mov	x17, #0xcbb0            // =52144
               	movk	x17, #0xed, lsl #16
               	orr	x0, x0, x17
               	strh	w0, [x21]
               	lsr	x0, x0, #16
               	strb	w0, [x21, #0x2]
               	ldrh	w0, [x21]
               	ldrb	w1, [x21, #0x2]
               	lsl	x1, x1, #16
               	orr	x0, x0, x1
               	asr	x0, x0, #4
               	lsl	x0, x0, #44
               	asr	x0, x0, #44
               	mov	x17, #-0x2345           // =-9029
               	movk	x17, #0xfffe, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrb	w0, [x21]
               	and	x0, x0, #0xf
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrh	w0, [x21]
               	ldrb	w1, [x21, #0x2]
               	lsl	x2, x1, #16
               	orr	x2, x0, x2
               	asr	x2, x2, #4
               	lsl	x2, x2, #44
               	asr	x2, x2, #44
               	add	x2, x2, #0x1
               	and	x2, x2, #0xfffff
               	lsl	x1, x1, #16
               	orr	x0, x0, x1
               	and	x0, x0, #0xffffffffff00000f
               	lsl	x1, x2, #4
               	orr	x0, x0, x1
               	strh	w0, [x21]
               	lsr	x0, x0, #16
               	strb	w0, [x21, #0x2]
               	ldrh	w0, [x21]
               	ldrb	w1, [x21, #0x2]
               	lsl	x1, x1, #16
               	orr	x0, x0, x1
               	asr	x0, x0, #4
               	lsl	x0, x0, #44
               	asr	x0, x0, #44
               	mov	x17, #-0x2344           // =-9028
               	movk	x17, #0xfffe, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrb	w0, [x21]
               	and	x0, x0, #0xf
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x0, x22, #0x10
               	mov	x1, #0xff               // =255
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	ldrh	w0, [x21]
               	ldrb	w1, [x21, #0x2]
               	lsl	x1, x1, #16
               	orr	x0, x0, x1
               	and	x0, x0, #0xffffffffff800000
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2a, lsl #16
               	orr	x0, x0, x17
               	strh	w0, [x21]
               	lsr	x0, x0, #16
               	strb	w0, [x21, #0x2]
               	ldrh	w0, [x21]
               	ldrb	w1, [x21, #0x2]
               	lsl	x1, x1, #16
               	orr	x0, x0, x1
               	and	x0, x0, #0x7fffff
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2a, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	sub	x0, x22, #0x1
               	ldrb	w0, [x0]
               	mov	x17, #0xaa              // =170
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x0, x22, #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	mov	x0, #0x5a               // =90
               	strb	w0, [x20]
               	ldur	w0, [x20, #0x1]
               	ldurh	w1, [x20, #0x5]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	and	x0, x0, #0xffff000000000000
               	mov	x17, #0x7654            // =30292
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	orr	x0, x0, x17
               	stur	w0, [x20, #0x1]
               	lsr	x0, x0, #32
               	sturh	w0, [x20, #0x5]
               	ldur	w0, [x20, #0x1]
               	ldurh	w1, [x20, #0x5]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	mov	x17, #0x7654            // =30292
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x0, x22, #0x1
               	ldrb	w0, [x0]
               	eor	x0, x0, #0xfe
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldur	w0, [x20, #0x1]
               	ldurh	w1, [x20, #0x5]
               	lsl	x2, x1, #32
               	orr	x2, x0, x2
               	asr	x2, x2, #4
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	and	x0, x0, #0xffff000000000000
               	orr	x0, x0, x2
               	stur	w0, [x20, #0x1]
               	lsr	x0, x0, #32
               	sturh	w0, [x20, #0x5]
               	ldur	w0, [x20, #0x1]
               	ldurh	w1, [x20, #0x5]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	mov	x17, #0x8765            // =34661
               	movk	x17, #0xcba9, lsl #16
               	movk	x17, #0xfed, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
