
nested_designator_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0xc, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0x14, %eax
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	%eax, (%rcx)
               	movl	$0x1e, %eax
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	movl	%eax, (%rcx)
               	movl	$0x28, %eax
               	leaq	-0x18(%rbp), %rcx
               	addq	$0xc, %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rcx
               	addq	$0xc, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
