
rand_time_and_strerror_follow_the_target_library.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%ebx, %r13
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %r13
               	sete	%r13b
               	movzbq	%r13b, %r13
               	movslq	%r12d, %r14
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %r14
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rdi
               	movq	%r13, %rsi
               	movq	%r12, %r8
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2a, %edi
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x5f5e1000, %rax       # imm = 0x5F5E1000
               	setg	%bl
               	movzbq	%bl, %rbx
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	callq	<addr>
               	testq	%rax, %rax
               	setge	%r13b
               	movzbq	%r13b, %r13
               	movl	$0xa, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movq	%r13, %rcx
               	movq	%r12, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x22, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	callq	<addr>
               	movl	$0xd, (%rax)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
