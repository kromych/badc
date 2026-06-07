
three_dim_array_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rdi), %rcx
               	movq	%rdi, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rdi, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x3, %rdi
               	movzbq	(%rdi), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rdx
               	movq	%rax, %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rcx
               	addq	$0x2, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rcx
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	addq	$0x8, %rsi
               	movzbq	(%rsi), %rdx
               	movq	%rsi, %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movq	%rsi, %rcx
               	addq	$0x2, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	addq	$0x3, %rsi
               	movzbq	(%rsi), %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	addq	$0x10, %rsi
               	movzbq	(%rsi), %rdx
               	movq	%rsi, %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movq	%rsi, %rcx
               	addq	$0x2, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	addq	$0x3, %rsi
               	movzbq	(%rsi), %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x4a, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movzbq	(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0xb, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0xc, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x17, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x18, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0xc, %rcx
               	movzbq	(%rcx), %rdx
               	movzbq	(%rax), %rcx
               	subq	%rcx, %rdx
               	movslq	%edx, %rcx
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x4, %rcx
               	movzbq	(%rcx), %rcx
               	movzbq	(%rax), %rax
               	subq	%rax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
