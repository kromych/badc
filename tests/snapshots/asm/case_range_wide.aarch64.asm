
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
               	cbnz	w0, <addr>
               	mov	x0, #0x64               // =100
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	cmp	w0, #0x9
               	b.ls	<addr>
               	b	<addr>
               	mov	x17, #0x1fffff          // =2097151
               	cmp	w0, w17
               	b.hi	<addr>
               	mov	x0, #0x1                // =1
               	ret

<classify_s>:
               	mov	x17, #-0x64             // =-100
               	cmp	w0, w17
               	b.ge	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0xb                // =11
               	ret
               	mov	x17, #-0x32             // =-50
               	cmp	w0, w17
               	b.gt	<addr>
               	mov	x0, #0xa                // =10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x100000           // =1048576
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x1fffff           // =2097151
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0xe360             // =58208
               	movk	x0, #0x16, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfffff            // =1048575
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cbnz	w0, <addr>
               	mov	x0, #0x200000           // =2097152
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x2
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x2
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf0000000         // =4026531840
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x3
               	b.ne	<addr>
               	mov	x0, #0xffffffff         // =4294967295
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xefff, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x64              // =-100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0xa
               	b.ne	<addr>
               	mov	x0, #-0x32              // =-50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0xa
               	b.ne	<addr>
               	mov	x0, #-0x4b              // =-75
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x65              // =-101
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0xc
               	b.ne	<addr>
               	mov	x0, #-0x31              // =-49
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
