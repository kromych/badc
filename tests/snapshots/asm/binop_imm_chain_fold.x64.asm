
binop_imm_chain_fold.x64:	file format elf64-x86-64

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
               	cmpq	$0x0, %rax
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
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x7, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rdx
               	addq	$0x8, %rdx
               	movslq	%edx, %rdx
               	subq	$0x3, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	subq	$0x4, %rsi
               	movslq	%esi, %rsi
               	addq	$0x9, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %rdi
               	subq	$0x2, %rdi
               	movslq	%edi, %rdi
               	subq	$0x5, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	andq	$0x3f, %r8
               	movq	%rax, %r9
               	orq	$0x3, %r9
               	xorq	$0x3, %rax
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%esi, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%edi, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r8d, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r9d, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	cmpq	$0x53, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
