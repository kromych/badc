
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
               	movl	$0x1, %edx
               	movsbq	0x1(%rcx), %rsi
               	cmpl	$0x41, %esi
               	je	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x2, %edx
               	movsbq	0x2(%rcx), %rsi
               	cmpl	$0x59, %esi
               	je	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x3, %edx
               	movsbq	0x3(%rcx), %rsi
               	cmpl	$0x4c, %esi
               	je	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x4, %edx
               	movsbq	0x4(%rcx), %rsi
               	cmpl	$0x4f, %esi
               	je	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x5, %edx
               	movsbq	0x5(%rcx), %rsi
               	cmpl	$0x41, %esi
               	je	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x6, %edx
               	movsbq	0x6(%rcx), %rsi
               	cmpl	$0x44, %esi
               	je	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x7, %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	subq	%rdx, %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	movsbq	(%rdx), %rcx
               	cmpl	$0x30, %ecx
               	jne	<addr>
               	movsbq	0x1(%rdx), %rcx
               	cmpl	$0x31, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	retq
