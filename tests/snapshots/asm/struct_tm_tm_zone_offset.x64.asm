
struct_tm_tm_zone_offset.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, (%rsp)
               	leaq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x48, %rsp
               	retq
               	movq	0x38(%rsp), %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x48, %rsp
               	retq
               	callq	<addr>
               	cmpq	$0x40, %rax
               	jbe	<addr>
               	movl	$0x6, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
