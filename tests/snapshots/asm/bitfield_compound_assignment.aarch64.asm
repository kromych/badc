
bitfield_compound_assignment.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	mov	x2, #0x0                // =0
               	ldrh	w1, [x0]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x1, x1, x2
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x1, x1, x2
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x1, x1, x2
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x1, x1, x2
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x3, x1, x17
               	asr	x4, x3, #1
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	mov	x17, #0x5               // =5
               	orr	x4, x4, x17
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x3, x17
               	lsl	x3, x4, #1
               	orr	x1, x1, x3
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x3, x1, x17
               	asr	x4, x3, #1
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	cmp	x4, #0x5
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x3, x17
               	mov	x17, #0xe               // =14
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x3, x1, x17
               	asr	x4, x3, #1
               	mov	x17, #0x7               // =7
               	and	x5, x4, x17
               	cmp	x5, #0x7
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x6               // =6
               	and	x4, x4, x17
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x3, x17
               	lsl	x3, x4, #1
               	orr	x1, x1, x3
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x3, x1, x17
               	asr	x4, x3, #1
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	cmp	x4, #0x6
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x3, x17
               	mov	x17, #0x2               // =2
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x3, x1, x17
               	asr	x4, x3, #1
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	cmp	x4, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x3, x17
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0xc0              // =192
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0xc800            // =51200
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x3, x1, x17
               	asr	x4, x3, #1
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	mov	x17, #0x7               // =7
               	eor	x4, x4, x17
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x3, x17
               	lsl	x3, x4, #1
               	orr	x1, x1, x3
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x3, x1, x17
               	mov	x17, #0x1               // =1
               	and	x4, x3, x17
               	cmp	x4, #0x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x4, x3, #1
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	cmp	x4, #0x6
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x4, x3, #4
               	mov	x17, #0xf               // =15
               	and	x4, x4, x17
               	cmp	x4, #0xc
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x4, x3, #8
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	cmp	x4, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x3, x17
               	mov	x17, #0xd0              // =208
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x3, x1, x17
               	asr	x4, x3, #4
               	mov	x17, #0xf               // =15
               	and	x4, x4, x17
               	cmp	x4, #0xd
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x3, x17
               	mov	x17, #0x90              // =144
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x3, x1, x17
               	asr	x4, x3, #4
               	mov	x17, #0xf               // =15
               	and	x4, x4, x17
               	cmp	x4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x4, x3, #8
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x4, x4, #1
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x3, x17
               	lsl	x3, x4, #8
               	orr	x1, x1, x3
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x3, x1, x17
               	asr	x4, x3, #8
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	mov	x17, #0x90              // =144
               	eor	x4, x4, x17
               	mov	w4, w4
               	cbz	x4, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x4, x3, #4
               	mov	x17, #0xf               // =15
               	and	x4, x4, x17
               	asr	x4, x4, #2
               	mov	x17, #0xf               // =15
               	and	x4, x4, x17
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x3, x17
               	lsl	x3, x4, #4
               	orr	x1, x1, x3
               	strh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x0, x1, x17
               	asr	x0, x0, #4
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
