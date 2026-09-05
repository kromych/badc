
scanf_fscanf_binding.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	leaq	(%rbx), %rax
               	movq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%rax), %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	addq	$0x0, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	(%rbx), %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	leaq	(%rbx), %rax
               	movq	(%rax), %rax
               	movq	(%rsp), %rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0x8(%rbp)
               	cmpl	$0x1869f, %edi          # imm = 0x1869F
               	jle	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x8(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x10(%rbp), %rax
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leave
               	retq
