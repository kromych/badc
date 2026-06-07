
string_literal_no_room_for_nul.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x65, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	addq	$0xf, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x6b, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x6f, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x5, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x13, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x77, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x64, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x5, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
