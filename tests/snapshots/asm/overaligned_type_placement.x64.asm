
overaligned_type_placement.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	testb	$0x7f, %al
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	testb	$0x3f, %cl
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	testb	$0x7f, %cl
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rdx
               	testb	$0x3f, %dl
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rdx
               	testb	$0x7f, %dl
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rsi
               	testb	$0x7f, %sil
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0xb, (%rax)
               	movl	$0x16, (%rcx)
               	movl	$0x21, (%rdx)
               	movl	$0x2c, (%rsi)
               	movslq	(%rax), %rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x21, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
