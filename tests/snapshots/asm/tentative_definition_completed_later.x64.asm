
tentative_definition_completed_later.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx # <addr>
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
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x10, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x4, %eax
               	movq	%rax, <rip> # <addr>
               	movl	$0x5, %edx
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	%rsi, <rip> # <addr>
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
               	movl	$0x7, %ecx
               	movb	%cl, <rip> # <addr>
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	movsbq	<rip>, %rdi # <addr>
               	cmpl	$0x7, %edi
               	jne	<addr>
               	movl	$0x8, %edx
               	movq	%rdx, <rip> # <addr>
               	movl	%eax, <rip> # <addr>
               	movq	<rip>, %rdi # <addr>
               	cmpq	$0x8, %rdi
               	je	<addr>
               	movq	%rsi, %rax
               	retq
               	movl	$0x9, %esi
               	movq	%rsi, <rip> # <addr>
               	movl	%eax, <rip> # <addr>
               	movq	<rip>, %rdi # <addr>
               	cmpq	$0x9, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	$0xa, <rip> # <addr>
               	movl	$0xb, %ecx
               	movb	%cl, <rip> # <addr>
               	movb	%cl, <rip> # <addr>
               	testb	$0x1f, %dil
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	cmpq	$0xa, %rdi
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movabsq	$0x100000000, %rdx      # imm = 0x100000000
               	movq	%rdx, <rip> # <addr>
               	movl	%eax, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rdx
               	je	<addr>
               	movq	%rsi, %rax
               	retq
               	movq	$-0x1, <rip> # <addr>
               	movb	$0x2, <rip> # <addr>
               	movb	$0xc, <rip> # <addr>
               	movzbq	<rip>, %rdx # <addr>
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movl	$0xd, %ecx
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x8, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x9, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	retq
               	movq	%rcx, %rax
               	retq
               	movq	%rdx, %rax
               	retq
