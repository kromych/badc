
static_over_alignment.x64:	file format elf64-x86-64

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
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movb	$0x9, (%rax)
               	testl	$0xfff, %eax            # imm = 0xFFF
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	movsbq	(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movslq	(%rax), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	testb	$0x7f, %al
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
