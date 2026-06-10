
bitfield_storage_unit.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	b	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x4
               	sub	x1, x29, #0x10
               	sub	x0, x0, x1
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	sub	x1, x29, #0x10
               	sub	x0, x0, x1
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0xab               // =171
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	mov	x17, #0xfeff            // =65279
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x100              // =256
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	mov	x17, #0x1ff             // =511
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x8a00             // =35328
               	movk	x2, #0x246, lsl #16
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0xab
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	asr	x0, x0, #8
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	asr	x0, x0, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0x2345            // =9029
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x55               // =85
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0x55
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	asr	x0, x0, #8
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	asr	x0, x0, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0x2345            // =9029
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	w1, [x0]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0xff               // =255
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	ldr	w1, [x0]
               	mov	x17, #0xfeff            // =65279
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x100              // =256
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	ldr	w1, [x0]
               	mov	x17, #0x1ff             // =511
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0xfe00             // =65024
               	movk	x2, #0xffff, lsl #16
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x4
               	ldr	w1, [x0]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x0                // =0
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x4
               	ldr	w1, [x0]
               	mov	x17, #0xfeff            // =65279
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x4
               	ldr	w1, [x0]
               	mov	x17, #0x1ff             // =511
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	ldr	w0, [x0, #0x4]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	w0, [x0, #0x4]
               	asr	x0, x0, #8
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	w0, [x0, #0x4]
               	asr	x0, x0, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
