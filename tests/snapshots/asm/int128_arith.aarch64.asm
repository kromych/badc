
int128_arith.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	orr	x0, x2, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x3, [x5]
               	sub	x3, x3, #0x1
               	mov	x17, #-0x1              // =-1
               	cmp	x3, x17
               	cset	x6, lo
               	cbnz	x3, <addr>
               	cmp	w6, #0x1
               	b.eq	<addr>
               	mov	x4, #0x1                // =1
               	cbz	x4, <addr>
               	mov	x0, x4
               	ret
               	ldr	x4, [x5]
               	cmp	x3, x4
               	cset	x7, lo
               	sub	x4, x3, x4
               	sub	x3, x6, x7
               	mov	x17, #-0x1              // =-1
               	cmp	x4, x17
               	b.ne	<addr>
               	cbz	w3, <addr>
               	mov	x3, #0x2                // =2
               	cbz	x3, <addr>
               	mov	x0, x3
               	ret
               	add	x3, x0, x0
               	cmp	x3, x0
               	cset	x4, lo
               	add	x6, x1, x1
               	add	x4, x6, x4
               	mov	x17, #0xccee            // =52462
               	movk	x17, #0x88aa, lsl #16
               	movk	x17, #0x4466, lsl #32
               	movk	x17, #0x22, lsl #48
               	cmp	x3, x17
               	b.ne	<addr>
               	mov	x17, #0xddfe            // =56830
               	movk	x17, #0x99bb, lsl #16
               	movk	x17, #0x5577, lsl #32
               	movk	x17, #0x1133, lsl #48
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x3, #0x3                // =3
               	cbz	x3, <addr>
               	mov	x0, x3
               	ret
               	ldr	x3, [x5]
               	cmp	x0, #0x0
               	cset	x4, hi
               	sub	x6, x2, x0
               	sub	x3, x3, x1
               	sub	x3, x3, x4
               	mov	x17, #0x9989            // =39305
               	movk	x17, #0xbbaa, lsl #16
               	movk	x17, #0xddcc, lsl #32
               	movk	x17, #0xffee, lsl #48
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #0x1101            // =4353
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x3, #0x4                // =4
               	cbz	x3, <addr>
               	mov	x0, x3
               	ret
               	ldr	x3, [x5]
               	cmp	x3, #0x0
               	cset	x5, hi
               	sub	x7, x2, x3
               	sub	x5, x2, x5
               	mov	x3, #-0x1               // =-1
               	cmp	x7, x3
               	b.ne	<addr>
               	cmp	w5, w3
               	b.eq	<addr>
               	mov	x3, #0x5                // =5
               	cbz	x3, <addr>
               	mov	x0, x3
               	ret
               	sub	x2, x2, x1
               	sub	x2, x2, x4
               	mov	x17, #0x9989            // =39305
               	movk	x17, #0xbbaa, lsl #16
               	movk	x17, #0xddcc, lsl #32
               	movk	x17, #0xffee, lsl #48
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #0x1100            // =4352
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x6                // =6
               	cbz	x2, <addr>
               	mov	x0, x2
               	ret
               	mvn	x2, x0
               	mvn	x3, x1
               	mov	x17, #0x9988            // =39304
               	movk	x17, #0xbbaa, lsl #16
               	movk	x17, #0xddcc, lsl #32
               	movk	x17, #0xffee, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x17, #0x1100            // =4352
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x2, #0x7                // =7
               	cbz	x2, <addr>
               	mov	x0, x2
               	ret
               	and	x2, x0, #0xffffffffffff0000
               	mov	x17, #0x44550000        // =1146421248
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x2, #0x8                // =8
               	cbz	x2, <addr>
               	mov	x0, x2
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x2, [x4]
               	lsl	x2, x2, #63
               	orr	x2, x1, x2
               	mov	x17, #0x6677            // =26231
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x9                // =9
               	cbz	x2, <addr>
               	mov	x0, x2
               	ret
               	eor	x3, x0, x0
               	eor	x5, x1, x1
               	cbnz	x3, <addr>
               	cbz	x5, <addr>
               	mov	x2, #0xa                // =10
               	cbz	x2, <addr>
               	mov	x0, x2
               	ret
               	orr	x2, x0, x1
               	cbz	x2, <addr>
               	ldr	x6, [x4]
               	mov	x2, #0x0                // =0
               	orr	x6, x2, x6
               	cbz	x6, <addr>
               	orr	x3, x3, x5
               	cbz	x3, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldr	x3, [x4]
               	add	x3, x0, x3
               	cmp	x3, x0
               	cset	x5, lo
               	add	x5, x1, x5
               	mov	x17, #0x6678            // =26232
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x3, x17
               	b.ne	<addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x3, #0xc                // =12
               	cbz	x3, <addr>
               	mov	x0, x3
               	ret
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x6, [x5]
               	ldr	x3, [x4]
               	ldr	x4, [x5]
               	cmp	x6, x4
               	b.ne	<addr>
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x3, #0xd                // =13
               	cbz	x3, <addr>
               	mov	x0, x3
               	ret
               	orr	x4, x2, x0
               	add	x3, x0, x1
               	cmp	x3, x0
               	cset	x0, lo
               	add	x1, x1, x4
               	add	x1, x1, x0
               	mov	x0, #0x5576             // =21878
               	movk	x0, #0x1133, lsl #16
               	movk	x0, #0xccef, lsl #32
               	movk	x0, #0x88aa, lsl #48
               	cmp	x3, x0
               	b.ne	<addr>
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	cbz	x0, <addr>
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x0, [x4]
               	cmp	x3, x0
               	cset	x6, lo
               	sub	x3, x3, x0
               	sub	x0, x1, x6
               	and	x1, x3, #0xffffffffffffff00
               	mov	x17, #0x5               // =5
               	orr	x1, x1, x17
               	ldr	x3, [x4]
               	lsl	x3, x3, #63
               	eor	x0, x0, x3
               	mov	x17, #0x5505            // =21765
               	movk	x17, #0x1133, lsl #16
               	movk	x17, #0xccef, lsl #32
               	movk	x17, #0x88aa, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x17, #0x5576            // =21878
               	movk	x17, #0x1133, lsl #16
               	movk	x17, #0xccef, lsl #32
               	movk	x17, #0x8aa, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	cbz	x0, <addr>
               	ret
               	mov	x0, x2
               	ret
               	mov	x0, x2
               	b	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
