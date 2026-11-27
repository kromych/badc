
tentative_deferred_array_ref_before_definition.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x13, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x6d, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	0x10(%rax), %eax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	addq	$0x48, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	0x10(%rax), %eax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
