
bitfields.aarch64:	file format elf64-littleaarch64

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
               	ldr	w1, [x0]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	str	w1, [x0]
               	sub	x2, x29, #0x10
               	mov	w0, w1
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	str	w0, [x2]
               	sub	x1, x29, #0x10
               	mov	w0, w0
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x14              // =20
               	orr	x0, x0, x17
               	str	w0, [x1]
               	sub	x1, x29, #0x10
               	mov	w0, w0
               	mov	x17, #0xfc1f            // =64543
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x220             // =544
               	orr	x0, x0, x17
               	str	w0, [x1]
               	sub	x1, x29, #0x10
               	ldr	w2, [x1, #0x4]
               	mov	x17, #0xffff00000000    // =281470681743360
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	orr	x2, x2, x17
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0x10
               	mov	x3, #0x3e7              // =999
               	str	w3, [x1, #0x8]
               	mov	w1, w0
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #1
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #2
               	mov	x17, #0x7               // =7
               	and	x1, x1, x17
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #5
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	cmp	x1, #0x11
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w2
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	w0, w0
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	str	w0, [x1]
               	mov	w1, w0
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #1
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #2
               	mov	x17, #0x7               // =7
               	and	x1, x1, x17
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #5
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	cmp	x1, #0x11
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	w0, w0
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x1c              // =28
               	orr	x0, x0, x17
               	str	w0, [x1]
               	mov	w1, w0
               	asr	x1, x1, #2
               	mov	x17, #0x7               // =7
               	and	x1, x1, x17
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #5
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	cmp	x1, #0x11
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, w0
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	str	w1, [x0]
               	sub	x2, x29, #0x18
               	mov	w0, w1
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x2               // =2
               	orr	x0, x0, x17
               	str	w0, [x2]
               	sub	x1, x29, #0x18
               	mov	w0, w0
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	str	w0, [x1]
               	sub	x1, x29, #0x18
               	mov	w0, w0
               	mov	x17, #0xfff7            // =65527
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x8               // =8
               	orr	x0, x0, x17
               	str	w0, [x1]
               	sub	x1, x29, #0x18
               	mov	w0, w0
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xb0              // =176
               	orr	x0, x0, x17
               	str	w0, [x1]
               	sub	x1, x29, #0x18
               	mov	w0, w0
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xc800            // =51200
               	orr	x0, x0, x17
               	str	w0, [x1]
               	mov	w1, w0
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #1
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #2
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #3
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #4
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	x1, #0xb
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #8
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	cmp	x1, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x18
               	mov	w0, w0
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xc900            // =51456
               	orr	x0, x0, x17
               	str	w0, [x1]
               	mov	w0, w0
               	asr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0xc9
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
