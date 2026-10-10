
runtime_array_member.x64:	file format elf64-x86-64

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
               	movl	$0xa, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movl	-0x8(%rbp), %ecx
               	incq	%rcx
               	movl	-0x8(%rbp), %edx
               	addq	$0x2, %rdx
               	movl	-0x8(%rbp), %esi
               	addq	$0x3, %rsi
               	movl	-0x8(%rbp), %edi
               	addq	$0x64, %rdi
               	cmpl	$0xa, %eax
               	jne	<addr>
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	cmpl	$0xc, %edx
               	jne	<addr>
               	cmpl	$0xd, %esi
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpl	$0x6e, %edi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	movl	-0x8(%rbp), %ecx
               	incq	%rcx
               	movl	-0x8(%rbp), %edx
               	cmpl	$0xa, %eax
               	jne	<addr>
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpl	$0xa, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	movl	-0x8(%rbp), %ecx
               	addq	$0x2, %rcx
               	movl	-0x8(%rbp), %edx
               	addq	$0x4, %rdx
               	cmpl	$0xa, %eax
               	jne	<addr>
               	cmpl	$0xc, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	cmpl	$0xe, %edx
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	movl	-0x8(%rbp), %ecx
               	incq	%rcx
               	cmpl	$0xa, %eax
               	jne	<addr>
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	movl	-0x8(%rbp), %ecx
               	incq	%rcx
               	movl	-0x8(%rbp), %edx
               	addq	$0x2, %rdx
               	movl	-0x8(%rbp), %esi
               	addq	$0x3, %rsi
               	movl	-0x8(%rbp), %edi
               	addq	$0x4, %rdi
               	movl	-0x8(%rbp), %r8d
               	addq	$0x5, %r8
               	movl	-0x8(%rbp), %r9d
               	addq	$0x6, %r9
               	cmpl	$0xa, %eax
               	jne	<addr>
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	cmpl	$0xc, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	cmpl	$0xd, %esi
               	jne	<addr>
               	cmpl	$0xe, %edi
               	jne	<addr>
               	cmpl	$0xf, %r8d
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	cmpl	$0x10, %r9d
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	incq	%rax
               	movl	-0x8(%rbp), %ecx
               	movl	-0x8(%rbp), %edx
               	addq	$0x2, %rdx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	cmpl	$0xc, %edx
               	jne	<addr>
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
