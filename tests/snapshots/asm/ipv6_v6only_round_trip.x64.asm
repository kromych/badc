
ipv6_v6only_round_trip.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x30, %rsp
               	pushq	%rbx
               	xorl	%edx, %edx
               	movl	%edx, 0x10(%rsp)
               	movl	$0x1, %esi
               	movl	%esi, 0x18(%rsp)
               	movl	$0xffffffff, 0x20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0x4, 0x28(%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x29, %esi
               	movl	$0x1a, %edx
               	leaq	0x10(%rsp), %rcx
               	movl	$0x4, %r8d
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x29, %esi
               	movl	$0x1a, %edx
               	leaq	0x20(%rsp), %rcx
               	leaq	0x28(%rsp), %r8
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, 0x20(%rsp)
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x29, %esi
               	movl	$0x1a, %edx
               	leaq	0x18(%rsp), %rcx
               	movl	$0x4, %r8d
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x4, 0x28(%rsp)
               	movl	$0x29, %esi
               	movl	$0x1a, %edx
               	leaq	0x20(%rsp), %rcx
               	leaq	0x28(%rsp), %r8
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, 0x20(%rsp)
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
