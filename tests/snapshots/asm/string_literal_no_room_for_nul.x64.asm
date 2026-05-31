
string_literal_no_room_for_nul.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movzbq	(%r11), %r11
               	xorq	$0x65, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0xf, %r11
               	movzbq	(%r11), %r11
               	xorq	$0x6b, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %r11
               	movzbq	(%r11), %r11
               	xorq	$0x68, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x4, %r11
               	movzbq	(%r11), %r11
               	xorq	$0x6f, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x5, %r11
               	movzbq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x13, %r11
               	movzbq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %r11
               	movzbq	(%r11), %r11
               	xorq	$0x77, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x4, %r11
               	movzbq	(%r11), %r11
               	xorq	$0x64, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x5, %r11
               	movzbq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, 0x41(%rdx)
