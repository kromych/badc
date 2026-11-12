
int_compare_narrow_width.aarch64:	file format elf64-littleaarch64

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
               	adrp	x2, <page>
               	ldr	x0, [x2, #0x10]
               	sxtw	x4, w0
               	adrp	x3, <page>
               	ldr	x0, [x3, #0x18]
               	sxtw	x1, w0
               	ldr	x0, [x2, #0x10]
               	ldr	x5, [x3, #0x18]
               	cmp	w4, #0x0
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	w4, w1
               	b.lt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	w1, w4
               	b.gt	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x17, #-0x7fffffff       // =-2147483647
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	cmp	w4, w1
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	cmp	w1, #0xc
               	b.gt	<addr>
               	cmp	w1, #0xc
               	b.ge	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	cmp	w0, w5
               	b.hi	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	cmp	w0, w5
               	b.lt	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w0, w17
               	b.hi	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	cmp	w1, w0
               	b.ls	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	ldr	x0, [x2, #0x10]
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x0, x17
               	b.gt	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	mul	x0, x1, x1
               	cmp	w0, #0x90
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	lsl	x0, x1, #4
               	cmp	w0, #0xc0
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	asr	x0, x1, #2
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x4, x17
               	asr	x0, x0, #34
               	add	x0, x0, x0, lsr #63
               	mov	x17, #0x7               // =7
               	mul	x0, x0, x17
               	sub	x0, x4, x0
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ret
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x20]
               	sxtb	x2, w2
               	ldr	x3, [x0, #0x20]
               	and	x3, x3, #0xff
               	ldr	x0, [x0, #0x20]
               	sxth	x0, w0
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mov	x17, #-0x6e             // =-110
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	ret
               	cmp	w3, #0x0
               	b.le	<addr>
               	cmp	w3, #0x92
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	ret
               	cmp	w2, w0
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x3, x0, x0, lsl #1
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0, x1, lsl #2]
               	cmp	w2, #0x24
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ret
               	ldrsw	x2, [x0, w5, sxtw #2]
               	cmp	w2, #0x24
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ret
               	sub	x2, x1, #0x5
               	ldrsw	x3, [x0, w2, sxtw #2]
               	add	x3, x3, x4
               	str	w3, [x0, w2, sxtw #2]
               	ldrsw	x0, [x0, #0x1c]
               	mov	x17, #-0xffea           // =-65514
               	movk	x17, #0x8000, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	ret
               	mov	x17, #-0x5              // =-5
               	cmp	w1, w17
               	b.ge	<addr>
               	mov	x0, #0x26               // =38
               	ret
               	cmp	w1, #0x5
               	b.le	<addr>
               	mov	x0, #0x0                // =0
               	ret
