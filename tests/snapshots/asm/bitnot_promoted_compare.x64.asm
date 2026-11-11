
bitnot_promoted_compare.x64:	file format elf64-x86-64

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
               	movb	$0x0, -0x8(%rbp)
               	movl	<rip>, %ecx # <addr>
               	movb	$0x0, -0x8(%rbp)
               	cmpl	$-0x1, %ecx
               	jae	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jb	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jb	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jae	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jae	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	<rip>, %esi # <addr>
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movb	%al, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$-0x1, %ecx
               	jae	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movzbq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	shlq	%rdx
               	cmpl	$-0x2, %edx
               	jne	<addr>
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	movl	%edx, %edx
               	shrq	%rdx
               	cmpl	$0x7fffffff, %edx       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorq	$-0x1, %rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	ja	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	xorq	$-0x1, %rcx
               	sarq	%rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movb	$0xf, -0x8(%rbp)
               	movl	<rip>, %ecx # <addr>
               	cmpl	$-0x10, %ecx
               	jae	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$-0x10, %ecx
               	jb	<addr>
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
