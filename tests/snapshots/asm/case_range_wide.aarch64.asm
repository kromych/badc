
case_range_wide.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	w0, w0
               	mov	x17, #0x100000          // =1048576
               	cmp	x0, x17
               	b.hs	<addr>
               	cmp	x0, #0x7
               	b.hs	<addr>
               	mov	x17, #0xf0000000        // =4026531840
               	cmp	x0, x17
               	b.hs	<addr>
               	cmp	x0, #0x5
               	b.lo	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x64               // =100
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	b.hi	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, #0x9
               	b.ls	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1f, lsl #16
               	cmp	x0, x17
               	b.hi	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	b	<addr>

<classify_s>:
               	sxtw	x0, w0
               	mov	x17, #0xff9c            // =65436
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.ge	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0xb                // =11
               	ret
               	mov	x17, #0xffce            // =65486
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.gt	<addr>
               	mov	x0, #0xa                // =10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x100000           // =1048576
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x1f, lsl #16
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0xe360             // =58208
               	movk	x0, #0x16, lsl #16
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xf, lsl #16
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x200000           // =2097152
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x2
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf0000000         // =4026531840
               	bl	<addr>
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xefff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff9c             // =65436
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0xa
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0xffce             // =65486
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0xa
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0xffb5             // =65461
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0xa
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff9b             // =65435
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0xc
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0xffcf             // =65487
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0xc
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
