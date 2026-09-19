
speculative_init_parse_data_rewind.x64:	file format elf64-x86-64

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
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movl	(%rcx), %ecx
               	xorq	$0xa, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	movl	0x4(%rcx), %ecx
               	xorq	$0x14, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpl	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	(%rax), %eax
               	xorq	$0x1e, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	cmpl	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
