
pragma_pack_push_pop_forms.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	movq	$0x1d, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x38, %rax
               	jae	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x38, %rax
               	jb	<addr>
               	movl	<rip>, %eax # <addr>
               	shlq	$0x2b, %rax
               	sarq	$0x2b, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpw	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	$0x0, 0x8(%rsp)
               	movq	$0x0, 0x10(%rsp)
               	movq	$0x0, 0x18(%rsp)
               	movb	$0x38, 0x10(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x8(%rsp), %rsi
               	movl	$0x18, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
