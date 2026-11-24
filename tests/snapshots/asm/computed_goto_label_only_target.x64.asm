
computed_goto_label_only_target.x64:	file format elf64-x86-64

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

<only_indirect>:
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	leaq	<rip>, %rax # <addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	(%rsp), %eax
               	addq	$0x2, %rax
               	addq	$0x18, %rsp
               	retq

<selected>:
               	leaq	<rip>, %rax # <addr>
               	testl	%esi, %esi
               	je	<addr>
               	jmpq	*%rax
               	movl	$0x19, %eax
               	retq
               	movl	$0xf, %eax
               	retq

<main>:
               	subq	$0x18, %rsp
               	movl	$0x1, 0x8(%rsp)
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x5, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x5, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x19, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x5, %edi
               	movl	0x8(%rsp), %esi
               	callq	<addr>
               	cmpl	$0x19, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
