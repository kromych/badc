
aggregate_result_alignment.aarch64:	file format elf64-littleaarch64

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

<results>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stp	x20, x21, [sp]
               	sub	sp, sp, #0xc0
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x20, x0
               	and	x1, x20, #0xff
               	add	x0, sp, #0x80
               	strb	w1, [sp, #0x80]
               	strb	w1, [sp, #0x81]
               	strb	w1, [sp, #0x82]
               	strb	w1, [sp, #0x83]
               	strb	w1, [sp, #0x84]
               	strb	w1, [sp, #0x85]
               	strb	w1, [sp, #0x86]
               	strb	w1, [sp, #0x87]
               	strb	w1, [sp, #0x88]
               	strb	w1, [sp, #0x89]
               	strb	w1, [sp, #0x8a]
               	strb	w1, [sp, #0x8b]
               	strb	w1, [sp, #0x8c]
               	strb	w1, [sp, #0x8d]
               	strb	w1, [sp, #0x8e]
               	strb	w1, [sp, #0x8f]
               	strb	w1, [sp, #0x90]
               	strb	w1, [sp, #0x91]
               	strb	w1, [sp, #0x92]
               	strb	w1, [sp, #0x93]
               	strb	w1, [sp, #0x94]
               	strb	w1, [sp, #0x95]
               	strb	w1, [sp, #0x96]
               	strb	w1, [sp, #0x97]
               	strb	w1, [sp, #0x98]
               	strb	w1, [sp, #0x99]
               	strb	w1, [sp, #0x9a]
               	strb	w1, [sp, #0x9b]
               	strb	w1, [sp, #0x9c]
               	strb	w1, [sp, #0x9d]
               	strb	w1, [sp, #0x9e]
               	strb	w1, [sp, #0x9f]
               	and	x0, x0, #0xf
               	add	x2, sp, #0xa0
               	strb	w1, [sp, #0xa0]
               	strb	w1, [sp, #0xa1]
               	strb	w1, [sp, #0xa2]
               	strb	w1, [sp, #0xa3]
               	strb	w1, [sp, #0xa4]
               	strb	w1, [sp, #0xa5]
               	strb	w1, [sp, #0xa6]
               	strb	w1, [sp, #0xa7]
               	strb	w1, [sp, #0xa8]
               	strb	w1, [sp, #0xa9]
               	strb	w1, [sp, #0xaa]
               	strb	w1, [sp, #0xab]
               	strb	w1, [sp, #0xac]
               	strb	w1, [sp, #0xad]
               	strb	w1, [sp, #0xae]
               	strb	w1, [sp, #0xaf]
               	and	x2, x2, #0xf
               	add	x21, x0, x2
               	mov	x0, sp
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	mov	x0, sp
               	and	x0, x0, #0x1f
               	add	x0, x21, x0
               	cbz	x0, <addr>
               	add	x0, x0, #0x3e8
               	sub	sp, x29, #0x10
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x20, #0xff
               	add	x21, x1, x1
               	add	x0, sp, #0x40
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	ldrb	w0, [sp, #0x7f]
               	add	x0, x21, x0
               	and	x1, x20, #0xff
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>

<probe2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stp	x20, x21, [sp]
               	sub	sp, sp, #0x100
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	mov	x0, sp
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	mov	x0, sp
               	and	x20, x0, #0x1f
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	ldur	x1, [x29, #-0x10]
               	ldur	x2, [x29, #-0x8]
               	sub	x1, x1, x2
               	add	x0, x0, x1
               	add	x2, sp, #0xc0
               	mov	x1, #0x3                // =3
               	strb	w1, [sp, #0xc0]
               	strb	w1, [sp, #0xc1]
               	strb	w1, [sp, #0xc2]
               	strb	w1, [sp, #0xc3]
               	strb	w1, [sp, #0xc4]
               	strb	w1, [sp, #0xc5]
               	strb	w1, [sp, #0xc6]
               	strb	w1, [sp, #0xc7]
               	strb	w1, [sp, #0xc8]
               	strb	w1, [sp, #0xc9]
               	strb	w1, [sp, #0xca]
               	strb	w1, [sp, #0xcb]
               	strb	w1, [sp, #0xcc]
               	strb	w1, [sp, #0xcd]
               	strb	w1, [sp, #0xce]
               	strb	w1, [sp, #0xcf]
               	strb	w1, [sp, #0xd0]
               	strb	w1, [sp, #0xd1]
               	strb	w1, [sp, #0xd2]
               	strb	w1, [sp, #0xd3]
               	strb	w1, [sp, #0xd4]
               	strb	w1, [sp, #0xd5]
               	strb	w1, [sp, #0xd6]
               	strb	w1, [sp, #0xd7]
               	strb	w1, [sp, #0xd8]
               	strb	w1, [sp, #0xd9]
               	strb	w1, [sp, #0xda]
               	strb	w1, [sp, #0xdb]
               	strb	w1, [sp, #0xdc]
               	strb	w1, [sp, #0xdd]
               	strb	w1, [sp, #0xde]
               	strb	w1, [sp, #0xdf]
               	and	x2, x2, #0xf
               	add	x0, x0, x2
               	add	x2, sp, #0xe0
               	strb	w1, [sp, #0xe0]
               	strb	w1, [sp, #0xe1]
               	strb	w1, [sp, #0xe2]
               	strb	w1, [sp, #0xe3]
               	strb	w1, [sp, #0xe4]
               	strb	w1, [sp, #0xe5]
               	strb	w1, [sp, #0xe6]
               	strb	w1, [sp, #0xe7]
               	strb	w1, [sp, #0xe8]
               	strb	w1, [sp, #0xe9]
               	strb	w1, [sp, #0xea]
               	strb	w1, [sp, #0xeb]
               	strb	w1, [sp, #0xec]
               	strb	w1, [sp, #0xed]
               	strb	w1, [sp, #0xee]
               	strb	w1, [sp, #0xef]
               	and	x2, x2, #0xf
               	add	x21, x0, x2
               	add	x0, sp, #0x40
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0x40
               	and	x0, x0, #0x1f
               	add	x0, x21, x0
               	mov	x17, #0x64              // =100
               	mul	x1, x20, x17
               	add	x20, x0, x1
               	add	x0, sp, #0x80
               	mov	x1, #0x3                // =3
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	ldrb	w0, [sp, #0x85]
               	add	x0, x20, x0
               	sub	x0, x0, #0x3
               	sub	sp, x29, #0x20
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<probe_vla>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	sxtw	x20, w0
               	mov	x21, x1
               	add	x17, x20, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x22, sp
               	sub	x22, x22, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x22
               	and	x1, x21, #0xff
               	mov	x0, x22
               	mov	x2, x20
               	bl	<addr>
               	and	x1, x21, #0xff
               	sub	x0, x29, #0x40
               	sturb	w1, [x29, #-0x40]
               	sturb	w1, [x29, #-0x3f]
               	sturb	w1, [x29, #-0x3e]
               	sturb	w1, [x29, #-0x3d]
               	sturb	w1, [x29, #-0x3c]
               	sturb	w1, [x29, #-0x3b]
               	sturb	w1, [x29, #-0x3a]
               	sturb	w1, [x29, #-0x39]
               	sturb	w1, [x29, #-0x38]
               	sturb	w1, [x29, #-0x37]
               	sturb	w1, [x29, #-0x36]
               	sturb	w1, [x29, #-0x35]
               	sturb	w1, [x29, #-0x34]
               	sturb	w1, [x29, #-0x33]
               	sturb	w1, [x29, #-0x32]
               	sturb	w1, [x29, #-0x31]
               	sturb	w1, [x29, #-0x30]
               	sturb	w1, [x29, #-0x2f]
               	sturb	w1, [x29, #-0x2e]
               	sturb	w1, [x29, #-0x2d]
               	sturb	w1, [x29, #-0x2c]
               	sturb	w1, [x29, #-0x2b]
               	sturb	w1, [x29, #-0x2a]
               	sturb	w1, [x29, #-0x29]
               	sturb	w1, [x29, #-0x28]
               	sturb	w1, [x29, #-0x27]
               	sturb	w1, [x29, #-0x26]
               	sturb	w1, [x29, #-0x25]
               	sturb	w1, [x29, #-0x24]
               	sturb	w1, [x29, #-0x23]
               	sturb	w1, [x29, #-0x22]
               	sturb	w1, [x29, #-0x21]
               	and	x0, x0, #0xf
               	sub	x2, x29, #0x20
               	sturb	w1, [x29, #-0x20]
               	sturb	w1, [x29, #-0x1f]
               	sturb	w1, [x29, #-0x1e]
               	sturb	w1, [x29, #-0x1d]
               	sturb	w1, [x29, #-0x1c]
               	sturb	w1, [x29, #-0x1b]
               	sturb	w1, [x29, #-0x1a]
               	sturb	w1, [x29, #-0x19]
               	sturb	w1, [x29, #-0x18]
               	sturb	w1, [x29, #-0x17]
               	sturb	w1, [x29, #-0x16]
               	sturb	w1, [x29, #-0x15]
               	sturb	w1, [x29, #-0x14]
               	sturb	w1, [x29, #-0x13]
               	sturb	w1, [x29, #-0x12]
               	sturb	w1, [x29, #-0x11]
               	and	x2, x2, #0xf
               	add	x0, x0, x2
               	sub	x2, x20, #0x1
               	ldrb	w2, [x22, w2, sxtw]
               	add	x0, x0, x2
               	sub	x0, x0, x1
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	sub	sp, sp, #0xa0
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x30
               	ldr	x20, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x20]
               	bl	<addr>
               	ldur	x1, [x29, #-0x20]
               	sub	x1, x1, #0x2
               	add	x1, x0, x1
               	add	x2, sp, #0x40
               	mov	x0, #0x2                // =2
               	strb	w0, [sp, #0x40]
               	strb	w0, [sp, #0x41]
               	strb	w0, [sp, #0x42]
               	strb	w0, [sp, #0x43]
               	strb	w0, [sp, #0x44]
               	strb	w0, [sp, #0x45]
               	strb	w0, [sp, #0x46]
               	strb	w0, [sp, #0x47]
               	strb	w0, [sp, #0x48]
               	strb	w0, [sp, #0x49]
               	strb	w0, [sp, #0x4a]
               	strb	w0, [sp, #0x4b]
               	strb	w0, [sp, #0x4c]
               	strb	w0, [sp, #0x4d]
               	strb	w0, [sp, #0x4e]
               	strb	w0, [sp, #0x4f]
               	strb	w0, [sp, #0x50]
               	strb	w0, [sp, #0x51]
               	strb	w0, [sp, #0x52]
               	strb	w0, [sp, #0x53]
               	strb	w0, [sp, #0x54]
               	strb	w0, [sp, #0x55]
               	strb	w0, [sp, #0x56]
               	strb	w0, [sp, #0x57]
               	strb	w0, [sp, #0x58]
               	strb	w0, [sp, #0x59]
               	strb	w0, [sp, #0x5a]
               	strb	w0, [sp, #0x5b]
               	strb	w0, [sp, #0x5c]
               	strb	w0, [sp, #0x5d]
               	strb	w0, [sp, #0x5e]
               	strb	w0, [sp, #0x5f]
               	and	x2, x2, #0xf
               	add	x1, x1, x2
               	add	x2, sp, #0x60
               	strb	w0, [sp, #0x60]
               	strb	w0, [sp, #0x61]
               	strb	w0, [sp, #0x62]
               	strb	w0, [sp, #0x63]
               	strb	w0, [sp, #0x64]
               	strb	w0, [sp, #0x65]
               	strb	w0, [sp, #0x66]
               	strb	w0, [sp, #0x67]
               	strb	w0, [sp, #0x68]
               	strb	w0, [sp, #0x69]
               	strb	w0, [sp, #0x6a]
               	strb	w0, [sp, #0x6b]
               	strb	w0, [sp, #0x6c]
               	strb	w0, [sp, #0x6d]
               	strb	w0, [sp, #0x6e]
               	strb	w0, [sp, #0x6f]
               	and	x2, x2, #0xf
               	add	x1, x1, x2
               	cbz	w1, <addr>
               	sub	sp, x29, #0x30
               	ldr	x20, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x30
               	ldr	x20, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4                // =4
               	stur	x1, [x29, #-0x18]
               	stur	x1, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldur	x0, [x29, #-0x18]
               	ldur	x2, [x29, #-0x10]
               	add	x0, x0, x2
               	ldur	x2, [x29, #-0x8]
               	sub	x0, x0, x2, lsl #1
               	add	x2, sp, #0x70
               	strb	w1, [sp, #0x70]
               	strb	w1, [sp, #0x71]
               	strb	w1, [sp, #0x72]
               	strb	w1, [sp, #0x73]
               	strb	w1, [sp, #0x74]
               	strb	w1, [sp, #0x75]
               	strb	w1, [sp, #0x76]
               	strb	w1, [sp, #0x77]
               	strb	w1, [sp, #0x78]
               	strb	w1, [sp, #0x79]
               	strb	w1, [sp, #0x7a]
               	strb	w1, [sp, #0x7b]
               	strb	w1, [sp, #0x7c]
               	strb	w1, [sp, #0x7d]
               	strb	w1, [sp, #0x7e]
               	strb	w1, [sp, #0x7f]
               	strb	w1, [sp, #0x80]
               	strb	w1, [sp, #0x81]
               	strb	w1, [sp, #0x82]
               	strb	w1, [sp, #0x83]
               	strb	w1, [sp, #0x84]
               	strb	w1, [sp, #0x85]
               	strb	w1, [sp, #0x86]
               	strb	w1, [sp, #0x87]
               	strb	w1, [sp, #0x88]
               	strb	w1, [sp, #0x89]
               	strb	w1, [sp, #0x8a]
               	strb	w1, [sp, #0x8b]
               	strb	w1, [sp, #0x8c]
               	strb	w1, [sp, #0x8d]
               	strb	w1, [sp, #0x8e]
               	strb	w1, [sp, #0x8f]
               	and	x2, x2, #0xf
               	add	x0, x0, x2
               	add	x2, sp, #0x90
               	strb	w1, [sp, #0x90]
               	strb	w1, [sp, #0x91]
               	strb	w1, [sp, #0x92]
               	strb	w1, [sp, #0x93]
               	strb	w1, [sp, #0x94]
               	strb	w1, [sp, #0x95]
               	strb	w1, [sp, #0x96]
               	strb	w1, [sp, #0x97]
               	strb	w1, [sp, #0x98]
               	strb	w1, [sp, #0x99]
               	strb	w1, [sp, #0x9a]
               	strb	w1, [sp, #0x9b]
               	strb	w1, [sp, #0x9c]
               	strb	w1, [sp, #0x9d]
               	strb	w1, [sp, #0x9e]
               	strb	w1, [sp, #0x9f]
               	and	x2, x2, #0xf
               	add	x20, x0, x2
               	mov	x0, sp
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	mov	x0, sp
               	and	x0, x0, #0x1f
               	add	x0, x20, x0
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0x30
               	ldr	x20, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, x0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0x30
               	ldr	x20, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	mov	x1, x0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	sub	sp, x29, #0x30
               	ldr	x20, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x30
               	ldr	x20, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
