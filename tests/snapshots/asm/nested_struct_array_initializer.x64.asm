
nested_struct_array_initializer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%rdx, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	%rdx, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	%rdx, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movq	%rdx, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movq	%rdx, %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movq	%rdx, %rax
               	addq	$0x18, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	addq	$0x1c, %rdx
               	movslq	(%rdx), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0xc, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0xc, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x14, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x24, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x18, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x13, %rax
               	je	<addr>
               	movl	$0x25, %eax
               	retq
               	xorq	%rax, %rax
               	retq
