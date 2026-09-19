
zero_test_of_memory.aarch64:	file format elf64-littleaarch64

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

<set8>:
               	ldrsb	x0, [x0, #0x1]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<clear8>:
               	ldrsb	x0, [x0, #0x1]
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<set16>:
               	ldrsh	x0, [x0, #0x6]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<clear16>:
               	ldrsh	x0, [x0, #0x6]
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<set32>:
               	ldrsw	x0, [x0, #0x10]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<clear32>:
               	ldrsw	x0, [x0, #0x10]
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<set64>:
               	ldr	x0, [x0, #0x28]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<clear64>:
               	ldr	x0, [x0, #0x28]
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<setu8>:
               	ldrb	w0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<setu16>:
               	ldrh	w0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<setu32>:
               	ldr	w0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<set_at16>:
               	ldrsh	x0, [x0, x1, lsl #1]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<set_at64>:
               	ldr	x0, [x0, w1, sxtw #3]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<fill>:
               	str	x1, [x0]
               	ret

<set_local>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x8
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<read_then_clear>:
               	ldrb	w2, [x0]
               	mov	x0, #0x0                // =0
               	strb	w0, [x1]
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ret

<length>:
               	mov	x1, x0
               	mov	x0, x1
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	sub	x0, x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x0, x29, #0x80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [sp], #0x10
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #-0x80              // =-128
               	strb	w1, [x0, #0x1]
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	mov	x2, #-0x8000            // =-32768
               	strh	w2, [x0, #0x6]
               	mov	x2, #-0x80000000        // =-2147483648
               	str	w2, [x0, #0x10]
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x100              // =256
               	strh	w1, [x0, #0x6]
               	mov	x1, #0x10000            // =65536
               	str	w1, [x0, #0x10]
               	mov	x1, #0x100000000        // =4294967296
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x2]
               	strb	w10, [x1]
               	ldrb	w10, [x2, #0x1]
               	strb	w10, [x1, #0x1]
               	ldrb	w10, [x2, #0x2]
               	strb	w10, [x1, #0x2]
               	ldrb	w10, [x2, #0x3]
               	strb	w10, [x1, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x38
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x48
               	add	x0, x0, #0x1
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x2
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x38
               	add	x0, x0, #0x4
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x30
               	add	x0, x0, #0x6
               	mov	x1, #-0x1               // =-1
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x28
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x18
               	mov	x1, #-0x1               // =-1
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x28
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x100000000        // =4294967296
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	ldurb	w0, [x29, #-0x8]
               	cbz	w0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
