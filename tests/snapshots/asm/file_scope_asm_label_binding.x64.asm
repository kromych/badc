
file_scope_asm_label_binding.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movl	-0x8(%rbp), %eax
               	xorq	$0x1234, %rax           # imm = 0x1234
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax        # <addr>
               	movl	(%rax), %eax
               	xorq	$0x5678, %rax           # imm = 0x5678
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax        # <addr>
               	leaq	<rip>, %rcx        # <addr>
               	subq	%rcx, %rax
               	leaq	<rip>, %rcx        # <addr>
               	movslq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2a, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%al, %bh

<asm_store_magic>:
               	movl	$0x1234, (%rdi)         # imm = 0x1234
               	retq
               	nop
               	js	<addr>
               	addb	%al, (%rax)
               	nop
               	nopl	(%rax)
               	orb	%al, (%rax)
               	addb	%al, (%rax)
