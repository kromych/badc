
file_scope_asm_label_binding.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movl	$0x0, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movl	0x8(%rsp), %eax
               	cmpl	$0x1234, %eax           # imm = 0x1234
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x5678, %ecx           # imm = 0x5678
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rcx # <addr>
               	subq	%rcx, %rax
               	leaq	<rip>, %rcx # <addr>
               	movslq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2a, %eax
               	addq	$0x18, %rsp
               	retq
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%al, %bh

<asm_store_magic>:
               	movl	$0x1234, (%rdi)         # imm = 0x1234
               	retq
               	nop

<asm_magic_word>:
               	js	<addr>
               	addb	%al, (%rax)
               	nop
               	nopl	(%rax)

<asm_label_delta>:
               	orb	%al, (%rax)
               	addb	%al, (%rax)
