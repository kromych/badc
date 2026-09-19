
switch_unsigned_negative_case.aarch64:	file format elf64-littleaarch64

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

<u32>:
               	mov	x17, #0xfffffffe        // =4294967294
               	cmp	w0, w17
               	b.lo	<addr>
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.lo	<addr>
               	mov	x0, #0x64               // =100
               	ret
               	mov	x0, #0xc8               // =200
               	ret
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3e7              // =999
               	ret
               	mov	x0, #0x5                // =5
               	ret

<u16>:
               	and	x0, x0, #0xffff
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x0, #0x3e7              // =999
               	ret
               	cmp	w0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ret

<u8>:
               	and	x0, x0, #0xff
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x0, #0x3e7              // =999
               	ret
               	cmp	w0, #0x3
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret

<s32>:
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.lt	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3e7              // =999
               	ret
               	mov	x0, #0x64               // =100
               	ret
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0xc8               // =200
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xffffffff         // =4294967295
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
               	mov	x0, #0xfffffffe         // =4294967294
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x1               // =-1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x2               // =-2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0xc8
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
