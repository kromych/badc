
fts_and_fd_set_headers.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	xorl	%edx, %edx
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movl	$0x14, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x8(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movzwq	0x62(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	0x30(%rax), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	(%rdi), %rcx
               	cmpl	$0x2e, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movzwq	0x40(%rax), %r10
               	movq	%r10, (%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %r10
               	movq	(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
