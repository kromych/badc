
scope_unbind_at_function_exit.aarch64:	file format elf64-littleaarch64

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

<by_param>:
               	ret

<by_local>:
               	mov	x0, #0x1                // =1
               	ret

<by_block>:
               	mov	x0, #0x2                // =2
               	ret

<by_static>:
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x28]
               	ret

<by_typedef>:
               	mov	x0, #0x4                // =4
               	ret

<by_extern_over_enum>:
               	mov	x0, #0x5                // =5
               	ret

<use_m>:
               	ret

<use_n>:
               	add	x0, x0, x1
               	ret

<use_n2>:
               	add	x0, x0, x1
               	ret

<main>:
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x28]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x2, <page>
               	ldrsw	x0, [x2, #0x10]
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x14]
               	cmp	w0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x18]
               	cmp	w0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x1c]
               	cmp	w0, #0x37
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	adrp	x0, <page>
               	ldrsw	x3, [x0, #0x20]
               	cmp	w3, #0x58
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x24]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	cmp	w3, #0x58
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	ldrsw	x1, [x1, #0xc]
               	add	x1, x0, x1
               	cmp	w1, #0x6e
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	ldrsw	x1, [x2, #0x10]
               	add	x0, x0, x1
               	cmp	w0, #0x79
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	mov	x0, #0x0                // =0
               	ret
