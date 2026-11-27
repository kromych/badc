
runtime_array_member.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movl	$0xa, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	movl	0x8(%rsp), %ecx
               	leaq	0x1(%rcx), %rdx
               	movl	0x8(%rsp), %ecx
               	leaq	0x2(%rcx), %rsi
               	movl	0x8(%rsp), %ecx
               	leaq	0x3(%rcx), %rdi
               	movl	0x8(%rsp), %ecx
               	addq	$0x64, %rcx
               	cmpl	$0xa, %eax
               	jne	<addr>
               	cmpl	$0xb, %edx
               	jne	<addr>
               	cmpl	$0xc, %esi
               	jne	<addr>
               	cmpl	$0xd, %edi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpl	$0x6e, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	movl	0x8(%rsp), %ecx
               	incq	%rcx
               	movl	0x8(%rsp), %edx
               	cmpl	$0xa, %eax
               	jne	<addr>
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpl	$0xa, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	movl	0x8(%rsp), %ecx
               	addq	$0x2, %rcx
               	movl	0x8(%rsp), %edx
               	addq	$0x4, %rdx
               	cmpl	$0xa, %eax
               	jne	<addr>
               	cmpl	$0xc, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpl	$0xe, %edx
               	jne	<addr>
               	movl	0x8(%rsp), %eax
               	movl	0x8(%rsp), %ecx
               	incq	%rcx
               	cmpl	$0xa, %eax
               	jne	<addr>
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	movl	0x8(%rsp), %ecx
               	incq	%rcx
               	movl	0x8(%rsp), %edx
               	addq	$0x2, %rdx
               	movl	0x8(%rsp), %esi
               	addq	$0x3, %rsi
               	movl	0x8(%rsp), %edi
               	addq	$0x4, %rdi
               	movl	0x8(%rsp), %r8d
               	addq	$0x5, %r8
               	movl	0x8(%rsp), %r9d
               	addq	$0x6, %r9
               	cmpl	$0xa, %eax
               	jne	<addr>
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	cmpl	$0xc, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpl	$0xd, %esi
               	jne	<addr>
               	cmpl	$0xe, %edi
               	jne	<addr>
               	cmpl	$0xf, %r8d
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpl	$0x10, %r9d
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	incq	%rax
               	movl	0x8(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	addq	$0x2, %rdx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	cmpl	$0xc, %edx
               	jne	<addr>
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0xf, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
