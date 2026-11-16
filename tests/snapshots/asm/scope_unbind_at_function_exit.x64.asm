
scope_unbind_at_function_exit.x64:	file format elf64-x86-64

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

<by_param>:
               	movq	%rdi, %rax
               	retq

<by_local>:
               	movl	$0x1, %eax
               	retq

<by_block>:
               	movl	$0x2, %eax
               	retq

<by_static>:
               	movl	<rip>, %eax # <addr>
               	retq

<by_typedef>:
               	movl	$0x4, %eax
               	retq

<by_extern_over_enum>:
               	movl	$0x5, %eax
               	retq

<use_m>:
               	movq	%rdi, %rax
               	retq

<use_n>:
               	leaq	(%rdi,%rsi), %rax
               	retq

<use_n2>:
               	leaq	(%rdi,%rsi), %rax
               	retq

<main>:
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x37, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x58, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	cmpl	$0x58, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	addq	%rax, %rcx
               	cmpl	$0x6e, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	xorl	%eax, %eax
               	retq
