
static_init_offsetof.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x4, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movzbq	0x2(%rax), %rcx
               	xorq	$0x8, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movzbq	0x3(%rax), %rcx
               	xorq	$0x10, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movzbq	0x4(%rax), %rax
               	xorq	$0x12, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
