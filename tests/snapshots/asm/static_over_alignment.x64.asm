
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
               	leaq	<rip>, %rcx
               	movl	$0x3, %eax
               	movl	%eax, (%rcx)
               	testb	$0x3f, %cl
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	$0x9, (%rcx)
               	testl	$0xfff, %ecx            # imm = 0xFFF
               	je	<addr>
               	retq
               	movsbq	(%rcx), %rax
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
