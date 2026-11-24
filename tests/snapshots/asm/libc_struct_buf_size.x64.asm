
libc_struct_buf_size.x64:	file format elf64-x86-64

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
               	subq	$0x98, %rsp
               	leaq	<rip>, %rdi
               	leaq	(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	addq	$0x98, %rsp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x98, %rsp
               	retq
