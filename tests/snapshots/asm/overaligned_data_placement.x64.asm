
overaligned_data_placement.x64:	file format elf64-x86-64

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
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	testb	$0x7f, %cl
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	testb	$-0x1, %al
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	testb	$0x7f, %al
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rdx
               	testb	$-0x1, %dl
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rsi
               	testb	$0x7f, %sil
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rdi
               	testb	$-0x1, %dil
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movl	$0xb, %eax
               	movl	%eax, (%rcx)
               	movl	$0x16, (%rdx)
               	movl	$0x21, (%rsi)
               	movl	$0x2c, (%rdi)
               	movslq	(%rcx), %rcx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movslq	(%rdx), %rcx
               	cmpl	$0x16, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x21, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2c, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
