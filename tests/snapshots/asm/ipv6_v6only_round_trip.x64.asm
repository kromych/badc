
ipv6_v6only_round_trip.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	pushq	%rbx
               	xorl	%edx, %edx
               	movl	%edx, -0x20(%rbp)
               	movl	$0x1, %esi
               	movl	%esi, -0x18(%rbp)
               	movl	$0xffffffff, -0x10(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x4, -0x8(%rbp)
               	movl	$0xa, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x29, %esi
               	movl	$0x1a, %edx
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x4, %r8d
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x29, %esi
               	movl	$0x1a, %edx
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %r8
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, -0x10(%rbp)
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x29, %esi
               	movl	$0x1a, %edx
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x4, %r8d
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, -0x8(%rbp)
               	movl	$0x29, %esi
               	movl	$0x1a, %edx
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %r8
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, -0x10(%rbp)
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
