
file_scope_asm_incbin_skip_count.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rcx), %rdx
               	cmpl	$0x50, %edx
               	je	<addr>
               	incq	%rax
               	retq
               	movl	$0x1, %eax
               	movsbq	0x1(%rcx), %rdx
               	cmpl	$0x41, %edx
               	jne	<addr>
               	movl	$0x2, %eax
               	movsbq	0x2(%rcx), %rdx
               	cmpl	$0x59, %edx
               	jne	<addr>
               	movl	$0x3, %eax
               	movsbq	0x3(%rcx), %rdx
               	cmpl	$0x4c, %edx
               	jne	<addr>
               	movl	$0x4, %eax
               	movsbq	0x4(%rcx), %rdx
               	cmpl	$0x4f, %edx
               	jne	<addr>
               	movl	$0x5, %eax
               	movsbq	0x5(%rcx), %rdx
               	cmpl	$0x41, %edx
               	jne	<addr>
               	movl	$0x6, %eax
               	movsbq	0x6(%rcx), %rcx
               	cmpl	$0x44, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x7, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x30, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x31, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorl	%eax, %eax
               	retq
