
tentative_definition_completed_later.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x2, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x3, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	addq	$0x10, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x4, %eax
               	movq	%rax, <rip> # <addr>
               	movq	$0x5, <rip> # <addr>
               	movl	$0x6, %edx
               	movq	%rdx, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x4, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x5, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x6, %rcx
               	je	<addr>
               	retq
               	movl	$0x7, %eax
               	movb	%al, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movsbq	<rip>, %rsi # <addr>
               	cmpl	$0x7, %esi
               	jne	<addr>
               	movq	$0x8, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x8, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movl	$0x9, %edx
               	movq	%rdx, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x9, %rsi
               	je	<addr>
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	$0xa, <rip> # <addr>
               	movl	$0xb, %eax
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	testb	$0x1f, %sil
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0xa, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movabsq	$0x100000000, %rsi      # imm = 0x100000000
               	movq	%rsi, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	$-0x1, <rip> # <addr>
               	movb	$0x2, <rip> # <addr>
               	movb	$0xc, <rip> # <addr>
               	movzbq	<rip>, %rcx # <addr>
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	$0xd, %eax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x8, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x9, %rcx
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
               	retq
               	movl	$0x5, %eax
               	retq
