
atomic_operand_in_working_regs.x64:	file format elf64-x86-64

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

<f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdx, 0x18(%rsp)
               	movq	%rcx, 0x10(%rsp)
               	movl	$0x64, %eax
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x5, %ecx
               	pushq	%rax
               	lock
               	cmpxchgq	%rcx, (%rdx)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	cmpq	$0x64, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmoveq	%rcx, %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	(%rdi,%rsi), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x8(%rsp), %r10
               	lock
               	xaddq	%r10, (%rcx)
               	movq	%r10, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	0x9(%rdi), %rcx
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	(%rdi,%rsi), %rax
               	addq	0x18(%rsp), %rax
               	addq	0x10(%rsp), %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	subq	$0x10, %rsp
               	movq	$0x7, (%rsp)
               	movq	$0x8, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	xorl	%ecx, %ecx
               	cmpq	$0x24, %rax
               	cmoveq	%rcx, %rax
               	popq	%rbp
               	retq
