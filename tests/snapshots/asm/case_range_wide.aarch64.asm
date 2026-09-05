
case_range_wide.aarch64:	file format elf64-littleaarch64

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

<classify_u>:
               	mov	w0, w0
               	mov	x17, #0x100000          // =1048576
               	cmp	w0, w17
               	b.hs	<addr>
               	cmp	w0, #0x7
               	b.hs	<addr>
               	mov	x17, #0xf0000000        // =4026531840
               	cmp	w0, w17
               	b.hs	<addr>
               	cmp	w0, #0x5
               	b.lo	<addr>
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	cbnz	x0, <addr>
               	mov	x0, #0x64               // =100
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	cmp	w0, #0x9
               	b.ls	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1f, lsl #16
               	cmp	w0, w17
               	b.hi	<addr>
               	mov	x0, #0x1                // =1
               	ret

<classify_s>:
               	sxtw	x0, w0
               	mov	x17, #0xff9c            // =65436
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	b.ge	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0xb                // =11
               	ret
               	mov	x17, #0xffce            // =65486
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	b.gt	<addr>
               	mov	x0, #0xa                // =10
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, #0x0                // =0
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x100000           // =1048576
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0x1f, lsl #16
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x1, #0xe360             // =58208
               	movk	x1, #0x16, lsl #16
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xf, lsl #16
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cbnz	x0, <addr>
               	mov	x1, #0x200000           // =2097152
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x5                // =5
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x2
               	b.ne	<addr>
               	mov	x1, #0x7                // =7
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x1, #0x9                // =9
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x6                // =6
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0xf0000000         // =4026531840
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x3
               	b.ne	<addr>
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xefff, lsl #16
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0xff9c             // =65436
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xa
               	b.ne	<addr>
               	mov	x1, #0xffce             // =65486
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xa
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x1, #0xffb5             // =65461
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xa
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0xff9b             // =65435
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xc
               	b.ne	<addr>
               	mov	x1, #0xffcf             // =65487
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xc
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
