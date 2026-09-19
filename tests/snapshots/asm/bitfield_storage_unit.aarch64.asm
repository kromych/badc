
bitfield_storage_unit.aarch64:	file format elf64-littleaarch64

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
               	sub	x0, x29, #0x10
               	add	x1, x0, #0x4
               	sub	x1, x1, x0
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x8
               	sub	x0, x1, x0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x18]
               	and	x0, x0, #0xffffffffffffff00
               	mov	x17, #0xab              // =171
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x18]
               	and	x0, x0, #0xfffffffffffffeff
               	orr	x0, x0, #0x100
               	stur	w0, [x29, #-0x18]
               	and	x0, x0, #0xffffffff000001ff
               	mov	x17, #0x8a00            // =35328
               	movk	x17, #0x246, lsl #16
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x18]
               	and	x1, x0, #0xff
               	cmp	w1, #0xab
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x2, x1, #8
               	and	x2, x2, #0x1
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x1, x1, #9
               	mov	x17, #0x2345            // =9029
               	movk	x17, #0x1, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x0, #0xffffffffffffff00
               	mov	x17, #0x55              // =85
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x18]
               	and	x1, x0, #0xff
               	cmp	w1, #0x55
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x2, x1, #8
               	and	x2, x2, #0x1
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x0, x1, #9
               	mov	x17, #0x2345            // =9029
               	movk	x17, #0x1, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	and	x1, x1, #0xffffffffffffff00
               	orr	x1, x1, #0xff
               	str	w1, [x0]
               	and	x1, x1, #0xfffffffffffffeff
               	orr	x1, x1, #0x100
               	str	w1, [x0]
               	and	x1, x1, #0xffffffff000001ff
               	orr	x1, x1, #0xfffffe00
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	and	x1, x1, #0xffffffffffffff00
               	str	w1, [x0, #0x4]
               	and	x1, x1, #0xfffffffffffffeff
               	str	w1, [x0, #0x4]
               	and	x1, x1, #0xffffffff000001ff
               	str	w1, [x0, #0x4]
               	and	x0, x1, #0xff
               	cbz	w0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, w1
               	asr	x2, x0, #8
               	tbz	w2, #0x0, <addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x0, x0, #9
               	cbz	w0, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
