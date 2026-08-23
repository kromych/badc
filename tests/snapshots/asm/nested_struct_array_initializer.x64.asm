
nested_struct_array_initializer.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x64, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movslq	0x14(%rax), %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movslq	0x18(%rax), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movslq	0x1c(%rax), %rax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x23, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x24, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpl	$0x13, %eax
               	je	<addr>
               	movl	$0x25, %eax
               	retq
               	xorq	%rax, %rax
               	retq
