
store_forward_local_slot.x64:	file format elf64-x86-64

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

<forwards>:
               	leaq	<rip>, %rax # <addr>
               	jmpq	*%rax
               	movl	$0x1e, %eax
               	retq

<volatile_kept>:
               	subq	$0x18, %rsp
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x7, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	jmpq	*%rcx
               	addq	$0x18, %rsp
               	retq

<aliased_kept>:
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xa, %eax
               	jmpq	*%rcx
               	retq

<cross_block>:
               	leaq	<rip>, %rax # <addr>
               	jmpq	*%rax
               	movl	$0xc, %eax
               	retq

<main>:
               	pushq	%rax
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	$0x6, %edi
               	callq	<addr>
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
