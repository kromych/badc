
volatile_member_store.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x29               // =41
               	str	x1, [x0]
               	ldr	x1, [x0]
               	cmp	x1, #0x29
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x0]
               	add	x1, x1, #0x3
               	str	x1, [x0]
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	ldr	x1, [x0]
               	sub	x1, x1, #0x1
               	str	x1, [x0]
               	ldr	x1, [x0]
               	cmp	x1, #0x2d
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x1, #0x7                // =7
               	str	x1, [x0, #0x8]
               	ldr	x1, [x0, #0x8]
               	add	x1, x1, #0x7
               	str	x1, [x0, #0x8]
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0xe
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x2, #0x5                // =5
               	add	x1, x0, #0x10
               	str	x2, [x1, #0x8]
               	ldr	x3, [x1, #0x8]
               	add	x3, x3, #0x5
               	str	x3, [x1, #0x8]
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	w1, [x0, #0x20]
               	and	x1, x1, #0xffffffffffffffe0
               	mov	x17, #0x9               // =9
               	orr	x1, x1, x17
               	str	w1, [x0, #0x20]
               	ldr	w1, [x0, #0x20]
               	and	x1, x1, #0x1f
               	add	x1, x1, #0x1
               	and	x1, x1, #0x1f
               	ldr	w3, [x0, #0x20]
               	and	x3, x3, #0xffffffffffffffe0
               	orr	x1, x3, x1
               	str	w1, [x0, #0x20]
               	ldr	w0, [x0, #0x20]
               	and	x0, x0, #0x1f
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, x2
               	ret
               	mov	x0, #0x0                // =0
               	ret
