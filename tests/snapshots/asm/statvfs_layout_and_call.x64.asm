
statvfs_layout_and_call.x64:	file format elf64-x86-64

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
               	subq	$0xe0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	leaq	-0xe0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	cmpq	$0x0, -0xe0(%rbp)
               	je	<addr>
               	cmpq	$0x0, -0xd8(%rbp)
               	je	<addr>
               	cmpq	$0x0, -0xd0(%rbp)
               	je	<addr>
               	cmpq	$0x0, -0x90(%rbp)
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0xc8(%rbp), %rax
               	movq	-0xd0(%rbp), %rcx
               	cmpq	%rcx, %rax
               	ja	<addr>
               	movq	-0xc0(%rbp), %rax
               	movq	-0xd0(%rbp), %rcx
               	cmpq	%rcx, %rax
               	ja	<addr>
               	movq	-0xb0(%rbp), %rax
               	movq	-0xb8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jbe	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x70(%rbp), %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%r12d, %r12d
               	jne	<addr>
               	movq	-0x68(%rbp), %rax
               	movq	-0xd8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x60(%rbp), %rax
               	movq	-0xd0(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	-0xa0(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
