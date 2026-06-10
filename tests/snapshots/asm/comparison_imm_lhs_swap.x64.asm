
comparison_imm_lhs_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x2b0, %esi            # imm = 0x2B0
               	callq	<addr>
               	ud2

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	testq	%rax, %rax
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
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x5, %ebx
               	xorq	%r12, %r12
               	testq	%rbx, %rbx
               	jle	<addr>
               	movq	%r12, %rax
               	incq	%rax
               	movslq	%eax, %r12
               	testq	%rbx, %rbx
               	jl	<addr>
               	movslq	%r12d, %rax
               	incq	%rax
               	movslq	%eax, %r12
               	cmpq	$0xa, %rbx
               	jge	<addr>
               	movslq	%r12d, %rax
               	incq	%rax
               	movslq	%eax, %r12
               	cmpq	$0xa, %rbx
               	jg	<addr>
               	movslq	%r12d, %rax
               	incq	%rax
               	movslq	%eax, %r12
               	testq	%rbx, %rbx
               	jbe	<addr>
               	movslq	%r12d, %rax
               	incq	%rax
               	movslq	%eax, %r12
               	testq	%rbx, %rbx
               	jb	<addr>
               	movslq	%r12d, %rax
               	incq	%rax
               	movslq	%eax, %r12
               	cmpq	$0xa, %rbx
               	jae	<addr>
               	movslq	%r12d, %rax
               	incq	%rax
               	movslq	%eax, %r12
               	cmpq	$0xa, %rbx
               	ja	<addr>
               	movslq	%r12d, %rax
               	incq	%rax
               	movslq	%eax, %r12
               	cmpq	$0xa, %rbx
               	jle	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	testq	%rbx, %rbx
               	jge	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	%r12d, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r12d, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
